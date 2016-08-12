//
//  ContactUsViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/12/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var mapsButton: UIButton!
    @IBOutlet weak var phoneNumberButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        gradient(self.view)
        roundCornerButtons(mapsButton)
        roundCornerButtons(phoneNumberButton)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func phoneNumberButton(sender: AnyObject) {
        
        let callAlert = UIAlertController(title: "Call the Living Planet Aquarium?", message: "801-355-3474", preferredStyle: .Alert)
        let callAction = UIAlertAction(title: "Call", style: .Default) { (callAlert) in
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://8013553474")!)
    }
        let cancelAlert = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        callAlert.addAction(callAction)
        callAlert.addAction(cancelAlert)
        
        self.presentViewController(callAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func openInMapsButtonTapped(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Open in Maps?", message: "12033 Lone Peak Parkway, Draper UT", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/?q=Loveland+Living+Planet+Aquarium")!)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            return }))
        
        presentViewController(alert, animated: true, completion: nil)

    }
    
}
