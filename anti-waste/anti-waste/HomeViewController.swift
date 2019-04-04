//
//  HomeViewController.swift
//  anti-waste
//
//  Created by Matthieu T on 04/04/2019.
//  Copyright © 2019 MT Creative. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeButton.setTitle("Accueil", for: .normal)
        homeButton.setTitleColor(UIColor(red: 195/255.0, green: 195/255.0, blue: 195/255.0, alpha: 1), for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "ProximaNova-SemiBold", size: 10)
        
        scanButton.setTitle("Scan", for: .normal)
        scanButton.setTitleColor(UIColor(red: 195/255.0, green: 195/255.0, blue: 195/255.0, alpha: 1), for: .normal)
        scanButton.titleLabel?.font = UIFont(name: "ProximaNova-SemiBold", size: 10)
        
        historyButton.setTitle("Historique", for: .normal)
        historyButton.setTitleColor(UIColor(red: 195/255.0, green: 195/255.0, blue: 195/255.0, alpha: 1), for: .normal)
        historyButton.titleLabel?.font = UIFont(name: "ProximaNova-SemiBold", size: 10)
        
    }
    

}
