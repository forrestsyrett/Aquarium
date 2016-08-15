//
//  ExhibitGalleriesViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/11/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit


protocol ExhibitGalleriesViewControllerDelegate: class {
    func discoverUtahButtonTapped(exhibitGalleriesViewController: ExhibitGalleriesViewController)
}

class ExhibitGalleriesViewController: UIViewController, UITabBarDelegate {
    

    
    // MARK: Outlets
    @IBOutlet weak var discoverUtahButton: UIButton!
    @IBOutlet weak var oceanExplorerButton: UIButton!
    @IBOutlet weak var journeyToSouthAmericaButton: UIButton!
    @IBOutlet weak var antarcticAdventureButton: UIButton!
    @IBOutlet weak var expeditionAsiaButton: UIButton!
    weak var delegate: ExhibitGalleriesViewControllerDelegate?
    
    
    // MARK: Animations
    
    func animate() {
        
        UIButton.animateWithDuration(3.0) { () -> Void in
            self.discoverUtahButton.alpha = 1.0
            self.discoverUtahButton.currentBackgroundImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient(self.view)
        
        
        roundCornerButtons(discoverUtahButton)
        roundCornerButtons(oceanExplorerButton)
        roundCornerButtons(journeyToSouthAmericaButton)
        roundCornerButtons(antarcticAdventureButton)
        roundCornerButtons(expeditionAsiaButton)
        
        transparentNavigationBar(self)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




    @IBAction func discoverUtahButtonTapped(sender: AnyObject) {
        ("discoverUtah", sender: self)
 
        
    }

    
}

