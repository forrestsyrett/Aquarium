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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Navigation Title as an image
        
//        let logo = UIImage(named: "smallLogo")
//        let imageView = UIImageView(image:logo)
//        self.navigationItem.titleView = imageView
        
        
        

        gradient(self.view)
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
