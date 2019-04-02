//
//  ViewController.swift
//  anti-waste
//
//  Created by Matthieu T on 01/04/2019.
//  Copyright © 2019 MT Creative. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Scanner", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        self.present(controller, animated: true, completion: nil)
    }
}

