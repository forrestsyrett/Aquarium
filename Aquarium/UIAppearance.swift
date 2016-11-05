//
//  UIAppearance.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/11/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit

func gradient (_ view: UIView) {
    
    
    let gradientLayer = CAGradientLayer()
    
    view.backgroundColor = UIColor(red: 0, green: 0.3961, blue: 0.8196, alpha: 1.0)
    gradientLayer.frame = view.bounds
    let color1 = UIColor(red: 0, green: 0.3961, blue: 0.8196, alpha: 1.0).cgColor as CGColor
    let color2 = UIColor(red: 0, green: 0.0941, blue: 0.2, alpha: 1.0).cgColor as CGColor
    let color3 = UIColor(red: 0.149, green: 0.4392, blue: 0.498, alpha: 1.0).cgColor as CGColor
    gradientLayer.colors = [color1, color3, color2]
    
    gradientLayer.locations = [0.0, 0.50, 1.0]
    
    view.layer.insertSublayer(gradientLayer, at: 0)
    
    
} 

func transparentNavigationBar(_ viewController: UIViewController) {
    
    viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    viewController.navigationController?.navigationBar.shadowImage = UIImage()
    viewController.navigationController?.navigationBar.isTranslucent = true
    viewController.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    viewController.navigationController?.navigationBar.tintColor = UIColor.white
    
}

func roundCornerButtons(_ view: UIView) {
    view.layer.cornerRadius = 5
    view.layer.masksToBounds = true
}

