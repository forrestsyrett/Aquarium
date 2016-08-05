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
    
    // Figure out how to assign actions to the notification
    // Add a snooze action that schedules a new notification 5 min before the feeding
    
    
    func scheduleNotification(for feeding: Feeding, onWeekday weekday: Int, scheduled: Bool) {
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        // gets current weekday
//        let myComponents = myCalendar.components(.Weekday, fromDate: NSDate())
//        let currentWeekDay = myComponents.weekday
        
        
        let feedDateComponents: NSDateComponents = NSDateComponents()
        
        feedDateComponents.year = 2016
        feedDateComponents.month = 1
        feedDateComponents.day = weekday + 3
        feedDateComponents.weekday = 1
        feedDateComponents.hour = feeding.info.hour
        feedDateComponents.minute = feeding.info.minute
        feedDateComponents.timeZone = NSTimeZone.systemTimeZone()
        
        
        guard let feedNotificationDate: NSDate = myCalendar.dateFromComponents(feedDateComponents)! else { return }
        

        let feedNotification = UILocalNotification()
        let userInfoDictionary = [weekday : feeding.info.animalName]
        
        feedNotification.fireDate = feedNotificationDate
        feedNotification.alertBody = feeding.info.notificationTitle
        feedNotification.timeZone = NSTimeZone.defaultTimeZone()
        feedNotification.repeatInterval = .WeekOfYear
        feedNotification.userInfo = userInfoDictionary
    
        
        if scheduled {
        UIApplication.sharedApplication().scheduleLocalNotification(feedNotification)
        }
        if scheduled == false {
            UIApplication.sharedApplication().cancelLocalNotification(feedNotification)
        }
    }
}



