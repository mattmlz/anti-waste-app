//
//  ProductViewController.swift
//  anti-waste
//
//  Created by Matthieu T on 04/04/2019.
//  Copyright © 2019 MT Creative. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductViewController: UIViewController {
    //Barcode from ScannerViewController
    var resultBarCode: String!

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        if let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController {
            homeViewController.modalTransitionStyle = .flipHorizontal
            self.present(homeViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func scanButtonAction(_ sender: Any) {
        print("ok")
        let scannerStoryboard: UIStoryboard = UIStoryboard(name: "Scanner", bundle: nil)
        if let scannerViewController = scannerStoryboard.instantiateViewController(withIdentifier: "scannerViewController") as? ScannerViewController {
            scannerViewController.modalTransitionStyle = .crossDissolve
            self.present(scannerViewController, animated: true, completion: nil)
        }
    }

    @IBAction func homeButtonAction(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        if let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController {
            homeViewController.modalTransitionStyle = .flipHorizontal
            self.present(homeViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testLabel.text = resultBarCode
        
        backButton.setTitle("Retour", for: .normal)
        backButton.setTitleColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "ProximaNova-SemiBold", size: 18)
        
        homeButton.setTitle("Accueil", for: .normal)
        homeButton.setTitleColor(UIColor(red: 195/255.0, green: 195/255.0, blue: 195/255.0, alpha: 1), for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "ProximaNova-SemiBold", size: 10)
        
        scanButton.setTitle("Scan", for: .normal)
        scanButton.setTitleColor(UIColor(red: 195/255.0, green: 195/255.0, blue: 195/255.0, alpha: 1), for: .normal)
        scanButton.titleLabel?.font = UIFont(name: "ProximaNova-SemiBold", size: 10)
        
        historyButton.setTitle("Historique", for: .normal)
        historyButton.setTitleColor(UIColor(red: 195/255.0, green: 195/255.0, blue: 195/255.0, alpha: 1), for: .normal)
        historyButton.titleLabel?.font = UIFont(name: "ProximaNova-SemiBold", size: 10)
        
        print(resultBarCode!)
        getProductInfo(resultBarCode: resultBarCode)
        
    }
    
    //Set status bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    
    func getProductInfo (resultBarCode: String){
        Alamofire.request("https://fr.openfoodfacts.org/api/v0/produit/\(resultBarCode).json").responseJSON { (responseData) -> Void in
            
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                let productImage = swiftyJsonVar["product"]["image_url"]
                let productName = swiftyJsonVar["product"]["generic_name_fr"]
                let productQuant = swiftyJsonVar["product"]["quantity"]
                let productIngredients = swiftyJsonVar["product"]["ingredients_text_fr"].stringValue.localizedCapitalized
          
                Alamofire.request("https://lucaslareginie.fr/cdn/product.json").responseJSON { (responseDlc) -> Void in
                    
                    if((responseData.result.value) != nil) {
                        let swiftyJsonVarDlc = JSON(responseDlc.result.value!)
                        let scoreArray = swiftyJsonVarDlc
                        var score = 0
                        var indexScore = 0
                        
                        for (index, element) in scoreArray.enumerated(){
                            let ingr = scoreArray[index]["Ingrédient"].stringValue
                            if(productIngredients.contains(ingr)){
                                
                                score += scoreArray[index]["Note"].intValue
                                indexScore += 1
                            }
                        }
                        
                        let finalScore = score/indexScore
                        if(finalScore > 0){
                            print("Félicitations ! Ce produit peut être consommé \(finalScore) jours après sa date limite de consommation (DLC).")
                        } else{
                            print("Il ne faut pas consommer ce produit après sa date limite de consommation (DLC).")
                        }
                    } else{
                        print("error in getting score")
                    }
                }
            } else{
                print("error in getting product")
            }
        }
        
    }

}
