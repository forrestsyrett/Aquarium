//
//  HomeViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/21/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var livingPlanetLabel: UILabel!
    @IBOutlet weak var buyTicketsLabel: UIButton!
    @IBOutlet weak var becomeAMemberLabel: UIButton!
    @IBOutlet weak var animalEncountersLabel: UIButton!
    @IBOutlet weak var directionsLabel: UIButton!
    @IBOutlet weak var donateLabel: UIButton!
    @IBOutlet weak var smallLogo: UIImageView!
    @IBOutlet weak var lineOne: UIView!
    @IBOutlet weak var lineTwo: UIView!
    @IBOutlet weak var lineThree: UIView!
    @IBOutlet weak var lineFour: UIView!
    @IBOutlet weak var aquariumLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     

        tabBarTint(view: self)
        
        gradient(self.view)
        transparentNavigationBar(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateImage(smallLogo, animateTime: 2.0)
        animateLabel(welcomeLabel, animateTime: 0.5)
        animateLabel(livingPlanetLabel, animateTime: 1.0)
        animateLabel(aquariumLabel, animateTime: 1.0)
        animateLines(lineOne, animateTime: 0.75)
        animateLines(lineTwo, animateTime: 1.0)
        animateLines(lineThree, animateTime: 1.5)
        animateLines(lineFour, animateTime: 2.0)
    }
    
   
    
    // These codes will animate the tab bar controller each time the view changes
    // implement a swipe gesture to change tabs

//      func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        
//    }
//    
    
 
//      func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//
//    }

    

    
    @IBAction func buyTicketsButtonTapped(_ sender: AnyObject) {
        let safariVC = SFSafariViewController(url: URL(string: "https://tickets.thelivingplanet.com/WebStore/Shop/ViewItems.aspx?CG=online&C=Tickets")!)
        safariVC.preferredControlTintColor = UIColor.white
        safariVC.preferredBarTintColor = UIColor(red:0.00, green:0.10, blue:0.20, alpha:1.00)
        present(safariVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func becomeAMemberButtonTapped(_ sender: AnyObject) {
        let safariVC = SFSafariViewController(url: URL(string: "https://tickets.thelivingplanet.com/WebStore/Shop/ViewItems.aspx?CG=online&C=Memberships")!)
        safariVC.preferredControlTintColor = UIColor.white
        safariVC.preferredBarTintColor = UIColor(red:0.00, green:0.10, blue:0.20, alpha:1.00)
        present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func donateButtonTapped(_ sender: AnyObject) {
        let safariVC = SFSafariViewController(url: URL(string: "http://www.thelivingplanet.com/home-4/give/")!)
        safariVC.preferredControlTintColor = UIColor.white
        safariVC.preferredBarTintColor = UIColor(red:0.00, green:0.10, blue:0.20, alpha:1.00)
        present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func directionButtonTapped(_ sender: AnyObject) {

        
    }
    
    
}
