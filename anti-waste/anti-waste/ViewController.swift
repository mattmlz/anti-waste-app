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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftyOnboard = SwiftyOnboard(frame: view.frame)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self as? SwiftyOnboardDataSource
    }
}

extension ViewController: SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        return page
    }
}
