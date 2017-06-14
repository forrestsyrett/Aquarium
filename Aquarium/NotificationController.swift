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
    
    // Assign actions to the notification
    // Add a snooze action that schedules a new notification 5 min before the feeding
    
    
    func scheduleNotification(for feeding: Feeding, onWeekday weekday: Int, scheduled: Bool) {
        
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        
        let now = Date()
        var fireDate = (gregorian as NSCalendar).date(bySettingUnit: .weekday, value: weekday, of: now, options: [])!
        fireDate = (gregorian as NSCalendar).date(bySettingUnit: .hour, value: feeding.info.hour, of: fireDate, options: [])!
        fireDate = (gregorian as NSCalendar).date(bySettingUnit: .minute, value: feeding.info.minute, of: fireDate, options: [])!
        
        
        let feedNotification = UILocalNotification()
        let userInfoDictionary = [String(weekday) : feeding.info.animalName]
        
        feedNotification.fireDate = fireDate
        feedNotification.alertBody = feeding.info.notificationTitle
        feedNotification.timeZone = TimeZone.current
        feedNotification.repeatInterval = .weekOfYear
        feedNotification.userInfo = userInfoDictionary
        feedNotification.soundName = "fishFlop.m4r"
        
        
        if scheduled {
            UIApplication.shared.scheduleLocalNotification(feedNotification)
        }
        if scheduled == false {
            UIApplication.shared.cancelLocalNotification(feedNotification)
        }
    }
}



