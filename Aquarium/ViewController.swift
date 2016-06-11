//
//  ViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/10/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let gradientLayer = CAGradientLayer()
        
        view.backgroundColor = .blueColor()
        gradientLayer.frame = view.bounds
        let color1 = UIColor(red: 0, green: 0.3961, blue: 0.8196, alpha: 1.0).CGColor as CGColorRef
        let color2 = UIColor(red: 0, green: 0.0941, blue: 0.2, alpha: 1.0).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        
        gradientLayer.locations = [0.0, 1.0]
        
        view.layer.insertSublayer(gradientLayer, atIndex: 0)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

