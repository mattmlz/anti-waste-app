//
//  customOverlayView.swift
//  SwiftyOnboard
//
//  Created by Jay on 3/26/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

open class SwiftyOnboardOverlay: UIView {
    
    open var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(red: 183/255.0, green: 183/255.0, blue: 183/255.0, alpha: 1)
        return pageControl
    }()
    
    open var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        if let image = UIImage(named: "continueButton.png") {
            button.setImage(image, for: .normal)
        }
        return button
    }()
    
    open var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Passer", for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    open func set(style: SwiftyOnboardStyle) {
        switch style {
        case .light:
            continueButton.setTitleColor(UIColor(red: 53/255.0, green: 215/255.0, blue: 137/255.0, alpha: 1), for: .normal)
            skipButton.setTitleColor(UIColor(red: 53/255.0, green: 215/255.0, blue: 137/255.0, alpha: 1), for: .normal)
            pageControl.currentPageIndicatorTintColor = UIColor(red: 53/255.0, green: 215/255.0, blue: 137/255.0, alpha: 1)
        case .dark:
            continueButton.setTitleColor(UIColor(red: 53/255.0, green: 215/255.0, blue: 137/255.0, alpha: 1), for: .normal)
            skipButton.setTitleColor(UIColor(red: 53/255.0, green: 215/255.0, blue: 137/255.0, alpha: 1), for: .normal)
            pageControl.currentPageIndicatorTintColor = UIColor(red: 53/255.0, green: 215/255.0, blue: 137/255.0, alpha: 1)
        }
    }
    
    open func page(count: Int) {
        pageControl.numberOfPages = count
    }
    
    open func currentPage(index: Int) {
        pageControl.currentPage = index
    }
    
    func setUp() {
        self.addSubview(pageControl)
        
        let margin = self.layoutMarginsGuide
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.heightAnchor.constraint(equalToConstant: 15).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -10).isActive = true
        pageControl.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10).isActive = true
        pageControl.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -10).isActive = true
        
        self.addSubview(continueButton)
        continueButton.isHidden = true
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.heightAnchor.constraint(equalToConstant: 112).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        continueButton.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10).isActive = true
        continueButton.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -10).isActive = true
        
        self.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        skipButton.topAnchor.constraint(equalTo: margin.topAnchor, constant: 15).isActive = true
        skipButton.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10).isActive = true
        skipButton.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -20).isActive = true
    }
    
}
