//
//  ProductViewController.swift
//  anti-waste
//
//  Created by Matthieu T on 04/04/2019.
//  Copyright © 2019 MT Creative. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    //Barcode from ScannerViewController
    var resultBarCode: String!
    @IBOutlet weak var testLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testLabel.text = resultBarCode
        
        print(resultBarCode!)
    }
    
    

}
