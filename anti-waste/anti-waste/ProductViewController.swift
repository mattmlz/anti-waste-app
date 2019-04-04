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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testLabel.text = resultBarCode
        
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
