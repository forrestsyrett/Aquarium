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
    
    
    func scheduleSharkFeedNotification(on: Bool) {
        
        //        check current day
        //
        //        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        //        let myComponents = myCalendar.components(.Weekday, fromDate: NSDate())
        //        let currentWeekDay = myComponents.weekday
        
        let sharkDateComponent: NSDateComponents = NSDateComponents()
        sharkDateComponent.year = 2016
        sharkDateComponent.weekday = 2;
        sharkDateComponent.hour = 13;
        sharkDateComponent.minute = 21;
        sharkDateComponent.timeZone = NSTimeZone.systemTimeZone()
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        guard let sharkDate: NSDate = calendar.dateFromComponents(sharkDateComponent)! else { return }
        
        
        let sharkFeedNotification = UILocalNotification()
        sharkFeedNotification.fireDate = sharkDate
        sharkFeedNotification.alertBody = "Shark Feeding in 15 minutes!"
        sharkFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
        sharkFeedNotification.repeatInterval = .Year
        sharkFeedNotification.repeatInterval = .Weekday
        
        if on {
            UIApplication.sharedApplication().scheduleLocalNotification(sharkFeedNotification)
        } else { UIApplication.sharedApplication().cancelLocalNotification(sharkFeedNotification)
        }}
    
    
    func schedulePenguinFeedNotification(on: Bool) {
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let penguinDateComponent: NSDateComponents = NSDateComponents()
        penguinDateComponent.year = 2016
        penguinDateComponent.weekday = 1;
        penguinDateComponent.hour = 15;
        penguinDateComponent.minute = 45;
        penguinDateComponent.timeZone = NSTimeZone.systemTimeZone()
        
        
        guard let penguinDate: NSDate = calendar.dateFromComponents(penguinDateComponent)! else { return }
        
        
        let penguinFeedNotification = UILocalNotification()
        penguinFeedNotification.fireDate = penguinDate
        penguinFeedNotification.alertBody = "Penguin Feeding in 15 minutes!"
        penguinFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
        penguinFeedNotification.repeatInterval = .Year
        penguinFeedNotification.repeatInterval = .Day
        
        if on {
            UIApplication.sharedApplication().scheduleLocalNotification(penguinFeedNotification)
        } else { UIApplication.sharedApplication().cancelLocalNotification(penguinFeedNotification)
        }}
    
    
    func scheduleArcherfishNotification(on: Bool) {
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let archerFishDateComponent: NSDateComponents = NSDateComponents()
        archerFishDateComponent.year = 2016
        archerFishDateComponent.weekday = 4;
        archerFishDateComponent.hour = 14;
        archerFishDateComponent.minute = 15;
        archerFishDateComponent.timeZone = NSTimeZone.systemTimeZone()
        
        
        guard let archerFishDate: NSDate = calendar.dateFromComponents(archerFishDateComponent)! else { return }
        
        
        let archerfishFeedNotification = UILocalNotification()
        archerfishFeedNotification.fireDate = archerFishDate
        archerfishFeedNotification.alertBody = "Archerfish Feeding in 15 minutes!"
        archerfishFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
        archerfishFeedNotification.repeatInterval = .Year
        archerfishFeedNotification.repeatInterval = .Day
        
        if on {
            UIApplication.sharedApplication().scheduleLocalNotification(archerfishFeedNotification)
        } else { UIApplication.sharedApplication().cancelLocalNotification(archerfishFeedNotification)
        }}
    
    
    func scheduleRiverGiantsNotification(on: Bool) {
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let riverGiantDateComponent: NSDateComponents = NSDateComponents()
        riverGiantDateComponent.year = 2016
        riverGiantDateComponent.weekday = 3;
        riverGiantDateComponent.hour = 14;
        riverGiantDateComponent.minute = 15;
        riverGiantDateComponent.timeZone = NSTimeZone.systemTimeZone()
        
        
        guard let riverGiantDate: NSDate = calendar.dateFromComponents(riverGiantDateComponent)! else { return }
        
        
        let riverGiantFeedNotification = UILocalNotification()
        riverGiantFeedNotification.fireDate = riverGiantDate
        riverGiantFeedNotification.alertBody = "River Giants Feeding in 15 minutes!"
        riverGiantFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
        riverGiantFeedNotification.repeatInterval = .Year
        riverGiantFeedNotification.repeatInterval = .Day
        
        
        if on {
            UIApplication.sharedApplication().scheduleLocalNotification(riverGiantFeedNotification)
        } else { UIApplication.sharedApplication().cancelLocalNotification(riverGiantFeedNotification)
        }}
    
    
    func schedulePiranhaFeedNotification(on: Bool) {
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let piranhaDateComponent: NSDateComponents = NSDateComponents()
        piranhaDateComponent.year = 2016
        piranhaDateComponent.weekday = 3;
        piranhaDateComponent.hour = 10;
        piranhaDateComponent.minute = 45;
        piranhaDateComponent.timeZone = NSTimeZone.systemTimeZone()
        
        
        guard let piranhaDate: NSDate = calendar.dateFromComponents(piranhaDateComponent)! else { return }
        
        
        let piranhaFeedNotification = UILocalNotification()
        piranhaFeedNotification.fireDate = piranhaDate
        piranhaFeedNotification.alertBody = "Piranha Feeding in 15 minutes!"
        piranhaFeedNotification.timeZone = NSTimeZone.defaultTimeZone()
        piranhaFeedNotification.repeatInterval = .Year
        piranhaFeedNotification.repeatInterval = .Day
        
        if on {
            UIApplication.sharedApplication().scheduleLocalNotification(piranhaFeedNotification)
        } else { UIApplication.sharedApplication().cancelLocalNotification(piranhaFeedNotification)
        }
    }
}




