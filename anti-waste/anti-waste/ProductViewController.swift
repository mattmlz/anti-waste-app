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

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productQuantLabel: UILabel!
    @IBOutlet weak var productSuppDaysLabel: UILabel!
    @IBOutlet weak var advertissementLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBAction func backButtonAction(_ sender: Any) {
        let scannerStoryboard: UIStoryboard = UIStoryboard(name: "Scanner", bundle: nil)
        if let scannerViewController = scannerStoryboard.instantiateViewController(withIdentifier: "scannerViewController") as? ScannerViewController {
            scannerViewController.modalTransitionStyle = .crossDissolve
            self.present(scannerViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func scanButtonAction(_ sender: Any) {
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
        
        productNameLabel.textAlignment = .center
        advertissementLabel.textColor = UIColor(red: 255/255.0, green: 67/255.0, blue: 112/255.0, alpha: 1)

        getProductInfo(resultBarCode: resultBarCode)
    }
    
    //Set status bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    
    func getProductInfo (resultBarCode: String) {
        Alamofire.request("https://fr.openfoodfacts.org/api/v0/produit/\(resultBarCode).json").responseJSON { (responseData) -> Void in
            
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                let productImage = swiftyJsonVar["product"]["image_url"]
                let productName = swiftyJsonVar["product"]["generic_name_fr"]
                let productQuant = swiftyJsonVar["product"]["quantity"]
                let productIngredients = swiftyJsonVar["product"]["ingredients_text_fr"].stringValue.localizedCapitalized
                
                self.productNameLabel.text = productName.stringValue
                self.productQuantLabel.text = productQuant.stringValue
                
                //Get product image in  URL format
                let productPictureURL = URL(string: "\(productImage.stringValue)")!
                
                DispatchQueue.main.async {
                    // Creating a session object with the default configuration.
                    let session = URLSession(configuration: .default)
                    
                    // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
                    let downloadPicTask = session.dataTask(with: productPictureURL) { (data, response, error) in
                        // The download has finished.
                        if let e = error {
                            print("Error downloading picture: \(e)")
                        } else {
                            // No errors found.
                            // It would be weird if we didn't have a response, so check for that too.
                            if let res = response as? HTTPURLResponse {
                                print("Downloaded picture with response code \(res.statusCode)")
                                if let imageData = data {
                                    // Finally convert that Data into an image and do what you wish with it.
                                    let productImageDownloaded = UIImage(data: imageData)
                                    self.productImageView.image = productImageDownloaded
                                } else {
                                    print("Couldn't get image: Image is nil")
                                }
                            } else {
                                print("Couldn't get response code for some reason")
                            }
                        }
                    }
                    
                    downloadPicTask.resume()
                }
          
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
                            self.productSuppDaysLabel.text = "\(finalScore) jour(s)"
                            self.advertissementLabel.text = "Consommez-le sans crainte !"
                        } else{
                            self.productSuppDaysLabel.text = "0 jour"
                            self.advertissementLabel.text = "Le consommer serait dangereux pour votre santé !"
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
