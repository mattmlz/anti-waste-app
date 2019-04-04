//
//  ViewController.swift
//  anti-waste
//
//  Created by Matthieu T on 01/04/2019.
//  Copyright © 2019 MT Creative. All rights reserved.
//

import UIKit
import SwiftyOnboard

class ViewController: UIViewController {
    var swiftyOnboard: SwiftyOnboard!
    let colors:[UIColor] = [#colorLiteral(red: 0.5253944397, green: 0.8520762324, blue: 0.8496518135, alpha: 1),#colorLiteral(red: 0.2090480626, green: 0.8448944688, blue: 0.5354943275, alpha: 1),#colorLiteral(red: 0.3278443813, green: 0.3882383704, blue: 0.8835648298, alpha: 1)]
    var titleArray: [String] = ["Bienvenue !", "Des propositions certifiées !", "Rejoignez la communauté"]
    var subTitleArray: [String] = ["Anti-waste va vous faire découvrir comment arrêter de jeter des produits dont la date limite de consommation est dépassée ou à quelques jours de l'être.", "Toutes les propositions anti-gaspillage sont validées par des médecins nutritionnistes et Les Restos du Coeur. Nous ne vous mettrons jamais en danger.", "Qu'attendez-vous pour arrêter de jeter l'argent à la poubelle et faire un geste pour la planète ?"]
    
    var gradiant: CAGradientLayer = {
        //Gradiant for the background view
        let blue = UIColor(red: 69/255, green: 127/255, blue: 202/255, alpha: 1.0).cgColor
        let purple = UIColor(red: 166/255, green: 172/255, blue: 236/255, alpha: 1.0).cgColor
        let gradiant = CAGradientLayer()
        gradiant.colors = [purple, blue]
        gradiant.startPoint = CGPoint(x: 0.5, y: 0.18)
        return gradiant
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient()
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func gradient() {
        //Add the gradiant to the view:
        self.gradiant.frame = view.bounds
        view.layer.addSublayer(gradiant)
    }
    
    @objc func handleSkip() {
        swiftyOnboard?.goToPage(index: 2, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        
        if index == 2 {
            //Perfom continue if user is on the last onboarding screen
            let scannerViewController = ScannerViewController()
            scannerViewController.modalTransitionStyle = .crossDissolve
            present(scannerViewController, animated: true, completion: nil)
        }
        
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
    }
}

extension ViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 3
    }
    
    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        //Return the background color for the page at index:
        return colors[index]
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        
        //Set the logo on the page:
        view.logoView.image = UIImage(named: "logo-onboarding-white")
        
        //Set the image on the page:
        view.imageView.image = UIImage(named: "onboard-\(index)")
        
        //Set the @ and color for the labels:
        view.title.font = UIFont(name: "OpenSans-Bold", size: 29)
        view.subTitle.font = UIFont(name: "OpenSans-Regular", size: 16)
        
        //Set the text in the page:
        view.title.text = titleArray[index]
        view.subTitle.text = subTitleArray[index]
        
        //Return the page for the given index:
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        //Setup for the overlay buttons:
        //overlay.continueButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
        //overlay.continueButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont(name: "Lato-Heavy", size: 16)
        
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        //print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            let image = UIImage(named: "continueButton.png")
            overlay.continueButton.setImage(image, for: .normal)
            overlay.skipButton.setTitle("Passer", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            let image = UIImage(named: "go-button.png")
            overlay.continueButton.setImage(image, for: .normal)
            overlay.skipButton.isHidden = true
        }
    }

}
