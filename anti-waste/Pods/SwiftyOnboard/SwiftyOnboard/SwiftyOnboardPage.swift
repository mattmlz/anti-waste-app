//
//  customPageView.swift
//  SwiftyOnboard
//
//  Created by Jay on 3/25/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

open class SwiftyOnboardPage: UIView {
    
    public var title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var subTitle: UILabel = {
        let label = UILabel()
        label.text = "Sub Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public var logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    
    func set(style: SwiftyOnboardStyle) {
        switch style {
        case .light:
            title.textColor = UIColor(red: 53/255.0, green: 215/255.0, blue: 137/255.0, alpha: 1)
            subTitle.textColor = UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1)
        case .dark:
            title.textColor = UIColor(red: 53/255.0, green: 215/255.0, blue: 137/255.0, alpha: 1)
            subTitle.textColor = UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1)
        }
    }
    
    func setUp() {
        let margin = self.layoutMarginsGuide
        
        self.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 150).isActive = true
        logoView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -150).isActive = true
        logoView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 20).isActive = true
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 40).isActive = true
        imageView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30).isActive = true
        imageView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 40).isActive = true
        imageView.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.25).isActive = true
        
        
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 30).isActive = true
        title.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30).isActive = true
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 85).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = false
        
        self.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 30).isActive = true
        subTitle.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30).isActive = true
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15).isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 100).isActive = false
    }
}
