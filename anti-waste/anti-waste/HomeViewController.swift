//
//  HomeViewController.swift
//  anti-waste
//
//  Created by Matthieu T on 04/04/2019.
//  Copyright © 2019 MT Creative. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //Barcode from ScannerViewController
    var resultBarCode: String!
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.testLabel.text = resultBarCode
        
        print(resultBarCode!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
