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
        
        
        // Navigation Title as an image
        
//        let logo = UIImage(named: "smallLogo")
//        let imageView = UIImageView(image:logo)
//        self.navigationItem.titleView = imageView
        
     

        gradient(self.view)
        transparentNavigationBar(self)
        

        // Do any additional setup after loading the view.
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
        
        let alert = UIAlertController(title: "Open in Maps?", message: nil, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/?q=Loveland+Living+Planet+Aquarium")!)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            return }))
        
        presentViewController(alert, animated: true, completion: nil)
        
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
