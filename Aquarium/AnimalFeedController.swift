//
//  AnimalFeedController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/2/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit

class AnimalFeed {
    
    var animalName: String
    var feedingTime: String
    var image: UIImage
    
    
    init(animalName: String, feedingTime: String, image: UIImage) {
        self.animalName = animalName
        self.feedingTime = feedingTime
        self.image = image
    }
    
    func isFeedingTime() {
        func feedingTime(dayOfweek: Int, hour: Int, minute: Int, minuteEnd: Int) {
            let currentHour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
            let currentMinute = NSCalendar.currentCalendar().component(.Minute, fromDate: NSDate())
            
            let todayDate = NSDate()
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
            let myComponents = myCalendar?.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents?.weekday
            print(weekDay)
            print(hour)
            print(currentMinute)
            if weekDay == dayOfweek && currentHour == hour && (currentMinute >= minute && currentMinute <= minuteEnd) { 
            }}
            
        // Shark Feed //
        
        feedingTime(1, hour: 13, minute: 25, minuteEnd: 59)
        feedingTime(3, hour: 13, minute: 25, minuteEnd: 59)
        feedingTime(5, hour: 13, minute: 25, minuteEnd: 59)
        feedingTime(7, hour: 13, minute: 25, minuteEnd: 59)
        
        
        // River Giant Feed //
        
        feedingTime(3, hour: 14, minute: 25, minuteEnd: 59)
        feedingTime(5, hour: 14, minute: 25, minuteEnd: 59)
        feedingTime(7, hour: 14, minute: 25, minuteEnd: 59)
        
        // Piranha Feed //
        
        feedingTime(3, hour: 11, minute: 00, minuteEnd: 29)
        feedingTime(5, hour: 11, minute: 00, minuteEnd: 29)
        
        // Penguin Feed //
        
        feedingTime(1, hour: 15, minute: 50, minuteEnd: 29)
        feedingTime(2, hour: 15, minute: 50, minuteEnd: 29)
        feedingTime(3, hour: 15, minute: 50, minuteEnd: 29)
        feedingTime(4, hour: 15, minute: 50, minuteEnd: 29)
        feedingTime(5, hour: 15, minute: 50, minuteEnd: 29)
        feedingTime(6, hour: 15, minute: 50, minuteEnd: 29)
        feedingTime(7, hour: 15, minute: 50, minuteEnd: 29)
        }
}

