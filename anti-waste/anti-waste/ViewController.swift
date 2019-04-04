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
    let colors:[UIColor] = [#colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1),#colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1),#colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)]
    var titleArray: [String] = ["Le saviez-vous ?", "Propositions certifiées !", "Essayez pour changer !"]
    var subTitleArray: [String] = ["Aujourd'hui en France, nous jetons\n chacun en moyenne plus de 20 kilos de\n produits encore consommables dans nos\n poubelles...", "Toutes les propositions anti-gaspillage sont\n validées par des médecins nutritionnistes\n et Les Restos du Coeur.\n Nous ne vous mettrons jamais en danger.", "Il suffit de scanner vos produits pour voir\n la réelle date limite de consommation !"]
    
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
        return .default
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
        view.title.font = UIFont(name: "ProximaNova-Bold", size: 29)
        view.subTitle.font = UIFont(name: "ProximaNova-Regular", size: 16)
        
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
        overlay.skipButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 16)
        
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        //print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.isHidden = true
            overlay.skipButton.setTitle("Passer", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            let image = UIImage(named: "go-button.png")
            overlay.continueButton.setImage(image, for: .normal)
            overlay.continueButton.isHidden = false
            overlay.skipButton.isHidden = true
        }
    }

}
