//
//  AnimalFeedTableViewCell.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

protocol AnimalFeedTableViewCellDelegate: class {
    func feedNotificationButtonTapped(animalFeedTableViewCell: AnimalFeedTableViewCell)
}

class AnimalFeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var animalFeedImage: UIImageView!
    @IBOutlet weak var animalFeedLabel: UILabel!
    @IBOutlet weak var animalFeedTimeLabel: UILabel!
    @IBOutlet weak var notifyMeButtonLabel: UIButton!
    @IBOutlet weak var checkMarkImage: UIImageView!
    weak var delegate: AnimalFeedTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static let notifyMe = "Notify Me!"
    static let cancelNotification = "Cancel"
    static let IDKey = "ID"
    
    
    private let sunday = 0
    private let monday = 1
    private let tuesday = 2
    private let wednesday = 3
    private let thursday = 4
    private let friday = 5
    private let saturday = 6
    
    
    
    
    @IBAction func notifyMeButtonTapped(sender: AnyObject) {
        
        let checkmark = UIImage(named: "checkmark")
        let checkmarkSelected = UIImage(named: "checkmarkSelected")
        
//        check notifications to see which are scheduled. access .userinfo
        func notificationCheck(dayOfWeek: String, feeding: String) {
            if let scheduledLocalNotifications = UIApplication.sharedApplication().scheduledLocalNotifications {
                for Notification in scheduledLocalNotifications {
                    if (Notification.userInfo! as? Dictionary<String, String>)! == [dayOfWeek : feeding] {
                        checkMarkImage.image = checkmarkSelected
                        print("success!")
                    } else {
                        checkMarkImage.image = checkmark
                        print("No notification found")
                    }
                }
            }
            
        }

        
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes:
            [.Alert, .Badge, .Sound], categories: nil))
        
        
        delegate?.feedNotificationButtonTapped(self)
        
        
        
        // MARK: - Shark Feed Notification //
        
        
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.notifyMe && animalFeedLabel.text == "Shark Feed"  {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
            
           
        }
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.cancelNotification && animalFeedLabel.text == "Shark Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
        }
        
        
        
        //
        //        // MARK: - Penguin Feed Notification //
        //
        
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.notifyMe && animalFeedLabel.text == "Penguin Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
//            notificationController().scheduleNotification(for: .penguin, onWeekday: sunday , scheduled: true)
//            print(UIApplication.sharedApplication().scheduledLocalNotifications)
        }
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.cancelNotification && animalFeedLabel.text == "Penguin Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
//            notificationController().scheduleNotification(for: .penguin, onWeekday: sunday , scheduled: false)
//            print(UIApplication.sharedApplication().scheduledLocalNotifications)
        }
        
        
        //
        //        // MARK: - ArcherFish Feed Notification //
        //
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.notifyMe && animalFeedLabel.text == "Archerfish Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
            
        }
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.cancelNotification && animalFeedLabel.text == "Archerfish Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
            
        }
        
        //
        //        // MARK: - River Giants Feed Notificati.on //
        //
        
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.notifyMe && animalFeedLabel.text == "River Giants Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
        }
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.cancelNotification && animalFeedLabel.text == "River Giants Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
        }
        
        
        //
        //        // MARK: - Piranha Feed Notification //
        //
        
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.notifyMe && animalFeedLabel.text == "Piranha Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.cancelNotification, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmarkSelected")
        }
        
        if notifyMeButtonLabel.titleLabel?.text == AnimalFeedTableViewCell.cancelNotification && animalFeedLabel.text == "Piranha Feed" {
            notifyMeButtonLabel.setTitle(AnimalFeedTableViewCell.notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")
        }
        
        
    }
    
}


