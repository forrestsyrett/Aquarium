//
//  ViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/10/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let gradientLayer = CAGradientLayer()
        
        view.backgroundColor = .blueColor()
        gradientLayer.frame = view.bounds
        let color1 = UIColor.yellowColor().CGColor as CGColorRef
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        
        gradientLayer.locations = [0.0, 0.25, 0.50, 1.0]
        
        gradientView.layer.addSublayer(gradientLayer)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

