//
//  UIAppearance.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/11/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit

func gradient (view: UIView) {
    
    
    let gradientLayer = CAGradientLayer()
    
    view.backgroundColor = UIColor(red: 0, green: 0.3961, blue: 0.8196, alpha: 1.0)
    gradientLayer.frame = view.bounds
    let color1 = UIColor(red: 0, green: 0.3961, blue: 0.8196, alpha: 1.0).CGColor as CGColorRef
    let color2 = UIColor(red: 0, green: 0.0941, blue: 0.2, alpha: 1.0).CGColor as CGColorRef
    let color3 = UIColor(red: 0.149, green: 0.4392, blue: 0.498, alpha: 1.0).CGColor as CGColorRef
    gradientLayer.colors = [color1, color3, color2]
    
    gradientLayer.locations = [0.0, 0.50, 1.0]
    
    view.layer.insertSublayer(gradientLayer, atIndex: 0)
    
    
}

func transparentNavigationBar(viewController: UIViewController) {
    
    viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    viewController.navigationController?.navigationBar.shadowImage = UIImage()
    viewController.navigationController?.navigationBar.translucent = true
    
}

func roundCornerButtons(button: UIButton) {
    button.layer.cornerRadius = 5
    button.layer.masksToBounds = true
}

