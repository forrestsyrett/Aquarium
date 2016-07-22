//
//  AnimalFeedTableViewCell.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class AnimalFeedTableViewCell: UITableViewCell {
    
    private let yes = "yes"
    private let no = "no"
    
    
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
        
        // MARK: - NS USER DEFAULTS
        //        let defaults = NSUserDefaults.standardUserDefaults()
        
        // MARK: - Shark Feed Notification //
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: NSDate())
        let currentWeekDay = myComponents.weekday
        
        
        
        if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Shark Feed" && currentWeekDay != 2 && currentWeekDay != 4 && currentWeekDay != 6 {
            
            notificationController().scheduleSharkFeedNotification(true)
            
            notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
            
        } else if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Shark Feed"{
            let noFeedTodayAlert = UIAlertController(title: "No Feeding Times Today", message: "Shark feedings occur Sundays, Tuesdays, Thursdays, and Saturdays", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            noFeedTodayAlert.addAction(action)
            self.window?.rootViewController?.presentViewController(noFeedTodayAlert, animated: true, completion: nil)
        }
        
        if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Shark Feed" {
            notificationController().scheduleSharkFeedNotification(false)
            notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
        }
        
        //
        //
        //
        //        // MARK: - Penguin Feed Notification //
        //
        
        //
        if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Penguin Feed" {
            notificationController().schedulePenguinFeedNotification(true)
            notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
        }
        
        if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Penguin Feed" {
            notificationController().schedulePenguinFeedNotification(false)
            notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
        }
        
        
        //
        //        // MARK: - ArcherFish Feed Notification //
        //
        
        if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Archerfish Feed" && currentWeekDay != 1 && currentWeekDay != 3 && currentWeekDay != 4 && currentWeekDay != 6 {
            notificationController().scheduleArcherfishNotification(true)
            notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
        } else if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Archerfish Feed"{
            let noFeedTodayAlert = UIAlertController(title: "No Feeding Times Today", message: "Archerfish feedings occur Mondays, Thursdays, and Saturdays", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            noFeedTodayAlert.addAction(action)
            self.window?.rootViewController?.presentViewController(noFeedTodayAlert, animated: true, completion: nil)
        }
        
        if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Archerfish Feed" {
            notificationController().scheduleArcherfishNotification(false)
            notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
            
        }
        
            //
            //        // MARK: - River Giants Feed Notification //
            //
            
            
            if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "River Giants Feed" && currentWeekDay != 1 && currentWeekDay != 2 && currentWeekDay != 4 && currentWeekDay != 6 {
                notificationController().scheduleRiverGiantsNotification(true)
                notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
                checkMarkImage.image = UIImage(named: "checkmarkSelected")
            } else if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "River Giants Feed" {
                let noFeedTodayAlert = UIAlertController(title: "No Feeding Times Today", message: "River Giant feedings occur Tuesdays, Thursdays, and Saturdays", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                noFeedTodayAlert.addAction(action)
                self.window?.rootViewController?.presentViewController(noFeedTodayAlert, animated: true, completion: nil)
            }
            if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "River Giants Feed" {
                notificationController().scheduleRiverGiantsNotification(false)
                notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
                checkMarkImage.image = UIImage(named: "checkmark")
            }
            
            
            //
            //        // MARK: - Piranha Feed Notification //
            //
            
            
            if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Piranha Feed" && currentWeekDay != 1 && currentWeekDay != 2 && currentWeekDay != 4 && currentWeekDay != 6 && currentWeekDay != 7 {
                notificationController().schedulePiranhaFeedNotification(true)
                notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
                checkMarkImage.image = UIImage(named: "checkmarkSelected")
                
            } else if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Piranha Feed" {
                let noFeedTodayAlert = UIAlertController(title: "No Feeding Times Today", message: "Piranha feedings occur Tuesdays and Thursdays", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                noFeedTodayAlert.addAction(action)
                self.window?.rootViewController?.presentViewController(noFeedTodayAlert, animated: true, completion: nil)
            }
            
            if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Piranha Feed" {
                notificationController().schedulePiranhaFeedNotification(false)
                notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
                checkMarkImage.image = UIImage(named: "checkmark")
            }
            
            
        }
        
    }


