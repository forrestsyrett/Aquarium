//
//  HomeViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/21/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient(self.view)
        transparentNavigationBar(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        animateImage(smallLogo, animateTime: 2.0)
        animateLabel(welcomeLabel, animateTime: 0.5)
        animateLabel(livingPlanetLabel, animateTime: 1.0)
        animateLines(lineOne, animateTime: 0.75)
        animateLines(lineTwo, animateTime: 1.0)
        animateLines(lineThree, animateTime: 1.5)
        animateLines(lineFour, animateTime: 2.0)
    }
    

    
    @IBAction func buyTicketsButtonTapped(sender: AnyObject) {
        let safariVC = SFSafariViewController(URL: NSURL(string: "https://tickets.thelivingplanet.com/WebStore/Shop/ViewItems.aspx?CG=online&C=Tickets")!)
        presentViewController(safariVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func becomeAMemberButtonTapped(sender: AnyObject) {
        let safariVC = SFSafariViewController(URL: NSURL(string: "https://tickets.thelivingplanet.com/WebStore/Shop/ViewItems.aspx?CG=online&C=Memberships")!)
        presentViewController(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func donateButtonTapped(sender: AnyObject) {
        let safariVC = SFSafariViewController(URL: NSURL(string: "http://www.thelivingplanet.com/home-4/give/")!)
        presentViewController(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func directionButtonTapped(sender: AnyObject) {

        
    }
    
    
}
