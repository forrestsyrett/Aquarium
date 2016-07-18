//
//  NotificationController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/18/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit

class notificationController {
    
//    func scheduleLocalNotification (feedName: String, year: Int, weekday: Int, hour: Int, minute: Int) {
//        
//        
//        let dateComponent: NSDateComponents = NSDateComponents()
//        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//        let myComponents = myCalendar.components(.Weekday, fromDate: NSDate())
//        let currentWeekDay = myComponents.weekday
//        
//        
//    }
    
    
    func sharkFeedNotification() {
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: NSDate())
        let currentWeekDay = myComponents.weekday
        
        let sharkDateComponent: NSDateComponents = NSDateComponents()
        sharkDateComponent.year = 2016
        sharkDateComponent.weekday = 4;
        sharkDateComponent.hour = 13;
        sharkDateComponent.minute = 15;
        sharkDateComponent.timeZone = NSTimeZone.systemTimeZone()
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        guard let sharkDate: NSDate = calendar.dateFromComponents(sharkDateComponent)! else { return }
        
        
        let sharkFeedNotification = UILocalNotification()
        sharkFeedNotification.fireDate = sharkDate
        sharkFeedNotification.alertBody = "Shark Feeding in 15 minutes!"
        sharkFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
        sharkFeedNotification.repeatInterval = .Year
        sharkFeedNotification.repeatInterval = .Day
        
    }
    
}
//    init(feedName: String, dateComponent: NSDateComponents = NSDateComponents(), year: Int, weekday: Int, hour: Int, minute: Int) {
//        self.feedName = feedName
//        self.dateComponent = dateComponent
//        self.year = year
//        self.weekday = weekday
//        self.hour = hour
//        self.minute = minute
//    }
//}

//// MARK: - NS USER DEFAULTS
//let defaults = NSUserDefaults.standardUserDefaults()
//
//// MARK: - Shark Feed Notification //
//
//let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//let myComponents = myCalendar.components(.Weekday, fromDate: NSDate())
//let currentWeekDay = myComponents.weekday
//
//let sharkDateComponent: NSDateComponents = NSDateComponents()
//sharkDateComponent.year = 2016
//sharkDateComponent.weekday = 4;
//sharkDateComponent.hour = 13;
//sharkDateComponent.minute = 15;
//sharkDateComponent.timeZone = NSTimeZone.systemTimeZone()
//
//let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//
//
//guard let sharkDate: NSDate = calendar.dateFromComponents(sharkDateComponent)! else { return }
//
//
//let sharkFeedNotification = UILocalNotification()
//sharkFeedNotification.fireDate = sharkDate
//sharkFeedNotification.alertBody = "Shark Feeding in 15 minutes!"
//sharkFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
//sharkFeedNotification.repeatInterval = .Year
//sharkFeedNotification.repeatInterval = .Day
//sharkFeedNotification.userInfo = [IDKey: "shark"]
//
//
//if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Shark Feed" && currentWeekDay != 2 && currentWeekDay != 4 && currentWeekDay != 6 {
//    UIApplication.sharedApplication().scheduleLocalNotification(sharkFeedNotification)
//    
//    defaults.setObject(notifyMeButtonLabel.titleLabel?.text, forKey: "notifyMe")
//    
//    notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmarkSelected")
//    //
//    //        } else if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Shark Feed"{
//    //            let noFeedTodayAlert = UIAlertController(title: "No Feeding Times Today", message: "Shark feedings occur Sundays, Tuesdays, Thursdays, and Saturdays", preferredStyle: .Alert)
//    //            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
//    //            noFeedTodayAlert.addAction(action)
//    //            self.window?.rootViewController?.presentViewController(noFeedTodayAlert, animated: true, completion: nil)
//}
//
//if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Shark Feed" {
//    UIApplication.sharedApplication().cancelLocalNotification(sharkFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmark")
//}
//if currentWeekDay != 1 && currentWeekDay != 3 && currentWeekDay != 5 && currentWeekDay != 7 {
//    UIApplication.sharedApplication().cancelLocalNotification(sharkFeedNotification)
//}
//
//
//
//// MARK: - Penguin Feed Notification //
//
//let penguinDateComponent: NSDateComponents = NSDateComponents()
//penguinDateComponent.year = 2016
//penguinDateComponent.weekday = 1;
//penguinDateComponent.hour = 15;
//penguinDateComponent.minute = 45;
//penguinDateComponent.timeZone = NSTimeZone.systemTimeZone()
//
//
//guard let penguinDate: NSDate = calendar.dateFromComponents(penguinDateComponent)! else { return }
//
//
//let penguinFeedNotification = UILocalNotification()
//penguinFeedNotification.fireDate = penguinDate
//penguinFeedNotification.alertBody = "Penguin Feeding in 15 minutes!"
//penguinFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
//penguinFeedNotification.repeatInterval = .Year
//penguinFeedNotification.repeatInterval = .Day
//
//
//if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Penguin Feed" {
//    UIApplication.sharedApplication().scheduleLocalNotification(penguinFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmarkSelected")
//}
//
//if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Penguin Feed" {
//    UIApplication.sharedApplication().cancelLocalNotification(penguinFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmark")
//}
//
//
//
//// MARK: - ArcherFish Feed Notification //
//
//let archerFishDateComponent: NSDateComponents = NSDateComponents()
//archerFishDateComponent.year = 2016
//archerFishDateComponent.weekday = 4;
//archerFishDateComponent.hour = 14;
//archerFishDateComponent.minute = 15;
//archerFishDateComponent.timeZone = NSTimeZone.systemTimeZone()
//
//
//guard let archerFishDate: NSDate = calendar.dateFromComponents(archerFishDateComponent)! else { return }
//
//
//let archerfishFeedNotification = UILocalNotification()
//archerfishFeedNotification.fireDate = archerFishDate
//archerfishFeedNotification.alertBody = "Archerfish Feeding in 15 minutes!"
//archerfishFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
//archerfishFeedNotification.repeatInterval = .Year
//archerfishFeedNotification.repeatInterval = .Day
//
//
//if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Archerfish Feed" && currentWeekDay != 1 && currentWeekDay != 3 && currentWeekDay != 4 && currentWeekDay != 6 {
//    UIApplication.sharedApplication().scheduleLocalNotification(archerfishFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmarkSelected")
//    //        } else if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Archerfish Feed"{
//    //            let noFeedTodayAlert = UIAlertController(title: "No Feeding Times Today", message: "Archerfish feedings occur Mondays, Thursdays, and Saturdays", preferredStyle: .Alert)
//    //            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
//    //            noFeedTodayAlert.addAction(action)
//    //            self.window?.rootViewController?.presentViewController(noFeedTodayAlert, animated: true, completion: nil)
//}
//
//if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Archerfish Feed" {
//    UIApplication.sharedApplication().cancelLocalNotification(archerfishFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmark")
//}
//if currentWeekDay != 2 && currentWeekDay != 5 && currentWeekDay != 7 {
//    UIApplication.sharedApplication().cancelLocalNotification(archerfishFeedNotification)
//}
//
//
//// MARK: - River Giants Feed Notification //
//
//let riverGiantDateComponent: NSDateComponents = NSDateComponents()
//riverGiantDateComponent.year = 2016
//riverGiantDateComponent.weekday = 3;
//riverGiantDateComponent.hour = 14;
//riverGiantDateComponent.minute = 15;
//riverGiantDateComponent.timeZone = NSTimeZone.systemTimeZone()
//
//
//guard let riverGiantDate: NSDate = calendar.dateFromComponents(riverGiantDateComponent)! else { return }
//
//
//let riverGiantFeedNotification = UILocalNotification()
//riverGiantFeedNotification.fireDate = riverGiantDate
//riverGiantFeedNotification.alertBody = "River Giants Feeding in 15 minutes!"
//riverGiantFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
//riverGiantFeedNotification.repeatInterval = .Year
//riverGiantFeedNotification.repeatInterval = .Day
//
//
//if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "River Giants Feed" && currentWeekDay != 1 && currentWeekDay != 2 && currentWeekDay != 4 && currentWeekDay != 6 {
//    UIApplication.sharedApplication().scheduleLocalNotification(riverGiantFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmarkSelected")
//    //        } else if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "River Giants Feed" {
//    //            let noFeedTodayAlert = UIAlertController(title: "No Feeding Times Today", message: "River Giant feedings occur Tuesdays, Thursdays, and Saturdays", preferredStyle: .Alert)
//    //            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
//    //            noFeedTodayAlert.addAction(action)
//    //            self.window?.rootViewController?.presentViewController(noFeedTodayAlert, animated: true, completion: nil)
//}
//if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "River Giants Feed" {
//    UIApplication.sharedApplication().cancelLocalNotification(riverGiantFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmark")
//}
//if currentWeekDay != 3 && currentWeekDay != 5 && currentWeekDay != 7 {
//    UIApplication.sharedApplication().cancelLocalNotification(riverGiantFeedNotification)
//}
//
//// MARK: - Piranha Feed Notification //
//
//let piranhaDateComponent: NSDateComponents = NSDateComponents()
//piranhaDateComponent.year = 2016
//piranhaDateComponent.weekday = 3;
//piranhaDateComponent.hour = 10;
//piranhaDateComponent.minute = 45;
//piranhaDateComponent.timeZone = NSTimeZone.systemTimeZone()
//
//
//guard let piranhaDate: NSDate = calendar.dateFromComponents(piranhaDateComponent)! else { return }
//
//
//let piranhaFeedNotification = UILocalNotification()
//piranhaFeedNotification.fireDate = piranhaDate
//piranhaFeedNotification.alertBody = "Piranha Feeding in 15 minutes!"
//piranhaFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
//piranhaFeedNotification.repeatInterval = .Year
//piranhaFeedNotification.repeatInterval = .Day
//
//
//if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Piranha Feed" && currentWeekDay != 1 && currentWeekDay != 2 && currentWeekDay != 4 && currentWeekDay != 6 && currentWeekDay != 7 {
//    UIApplication.sharedApplication().scheduleLocalNotification(piranhaFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(cancelNotification, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmarkSelected")
//    //
//    //        } else if notifyMeButtonLabel.titleLabel?.text == notifyMe && animalFeedLabel.text == "Piranha Feed" {
//    //            let noFeedTodayAlert = UIAlertController(title: "No Feeding Times Today", message: "Piranha feedings occur Tuesdays and Thursdays", preferredStyle: .Alert)
//    //            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
//    //            noFeedTodayAlert.addAction(action)
//    //            self.window?.rootViewController?.presentViewController(noFeedTodayAlert, animated: true, completion: nil)
//}
//
//if notifyMeButtonLabel.titleLabel?.text == cancelNotification && animalFeedLabel.text == "Piranha Feed" {
//    UIApplication.sharedApplication().cancelLocalNotification(piranhaFeedNotification)
//    
//    notifyMeButtonLabel.setTitle(notifyMe, forState: .Normal)
//    checkMarkImage.image = UIImage(named: "checkmark")
//}
//if currentWeekDay != 3 && currentWeekDay != 5 {
//    UIApplication.sharedApplication().cancelLocalNotification(piranhaFeedNotification)
//}
//notifyMeButtonLabel.backgroundColor = UIColor.lightGrayColor()
//}
