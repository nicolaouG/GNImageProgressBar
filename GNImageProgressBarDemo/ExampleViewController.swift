//
//  ExampleViewController.swift
//  GNImageProgressBarDemo
//
//  Created by george on 03/03/2020.
//  Copyright © 2020 George Nicolaou. All rights reserved.
//

import UIKit
import GNImageProgressBar

class ExampleViewController: UIViewController {
    
    let width = min(#imageLiteral(resourceName: "united_logo").size.width, UIScreen.main.bounds.width - 40)
    let height = min(#imageLiteral(resourceName: "united_logo").size.height, UIScreen.main.bounds.height - 80)
    
    lazy var imageProgressBar: GNImageProgressBar = {
        let b = GNImageProgressBar(image: #imageLiteral(resourceName: "united_logo"), size: CGSize(width: width, height: height), backgroundImageAlpha: 0.3, shouldShowBackgroundImage: true, fillDirection: .fromBottom, progress: 0.3)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        view.addSubview(imageProgressBar)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint(item: imageProgressBar, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageProgressBar, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    @objc func viewTapped() {
        let addition = imageProgressBar.progress + 0.1
        let progress = addition >= 1 ? 0 :
            addition >= 0.9 ? 1 : addition
        imageProgressBar.setProgress(progress, animated: true)
    }
}
