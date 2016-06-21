//
//  HomeViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/21/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        
//        let logoImage = UIImage(named: "logo")
//        navigationItem.titleView = UIImageView(image: logoImage)

        let gradientLayer = CAGradientLayer()
        
        view.backgroundColor = .blueColor()
        gradientLayer.frame = view.bounds
        let color1 = UIColor(red: 0, green: 0.3961, blue: 0.8196, alpha: 1.0).CGColor as CGColorRef
        let color2 = UIColor(red: 0, green: 0.0941, blue: 0.2, alpha: 1.0).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        
        gradientLayer.locations = [0.0, 1.0]
        
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
