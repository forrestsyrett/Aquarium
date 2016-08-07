//
//  NotificationController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/18/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit

class NotificationController {
    
    // Figure out how to assign actions to the notification
    // Add a snooze action that schedules a new notification 5 min before the feeding
    
    
    func scheduleNotification(for feeding: Feeding, onWeekday weekday: Int, scheduled: Bool) {
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let now = NSDate()
        var fireDate = gregorian.dateBySettingUnit(.Weekday, value: weekday, ofDate: now, options: [])!
        fireDate = gregorian.dateBySettingUnit(.Hour, value: feeding.info.hour, ofDate: fireDate, options: [])!
        fireDate = gregorian.dateBySettingUnit(.Minute, value: feeding.info.minute, ofDate: fireDate, options: [])!
        
        
        let feedNotification = UILocalNotification()
        let userInfoDictionary = [String(weekday) : feeding.info.animalName]
        
        feedNotification.fireDate = fireDate
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



