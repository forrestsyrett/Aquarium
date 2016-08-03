//
//  AnimalFeedTableViewCell.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class AnimalFeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var animalFeedImage: UIImageView!
    @IBOutlet weak var animalFeedLabel: UILabel!
    @IBOutlet weak var animalFeedTimeLabel: UILabel!
    @IBOutlet weak var notifyMeButtonLabel: UIButton!
    @IBOutlet weak var checkMarkImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private let notifyMe = "Notify Me!"
    private let cancelNotification = "Cancel"
    private let IDKey = "ID"
    
    
    
    @IBAction func notifyMeButtonTapped(sender: AnyObject) {
        
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes:
            [.Alert, .Badge, .Sound], categories: nil))
        
        
        
        // MARK: - Shark Feed Notification //

        
        if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Shark Feed"  {
            notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
            
           
        }
        
        if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Shark Feed" {
            notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
        }
        
        
        
        //
        //        // MARK: - Penguin Feed Notification //
        //
        
        
        if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Penguin Feed" {
            notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
            print(UIApplication.sharedApplication().scheduledLocalNotifications)

        }
        
        if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Penguin Feed" {
            notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
            print(UIApplication.sharedApplication().scheduledLocalNotifications)
        }
        
        
        //
        //        // MARK: - ArcherFish Feed Notification //
        //
        
        if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Archerfish Feed" {
            notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
            
        }
        
        if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Archerfish Feed" {
            notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
            
        }
        
        //
        //        // MARK: - River Giants Feed Notification //
        //
        
        
        if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "River Giants Feed" {
            notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
        }
        
        if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "River Giants Feed" {
            notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
        }
        
        
        //
        //        // MARK: - Piranha Feed Notification //
        //
        
        
        if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Piranha Feed" {
            notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
        }
        
        if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Piranha Feed" {
            notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
        }
        
        
    }
    
}


