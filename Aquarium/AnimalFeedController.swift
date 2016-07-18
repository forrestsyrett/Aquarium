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
    }}
        var feeds = [AnimalFeed]()
        
        let sharkFeed = AnimalFeed(animalName: "Shark Feed", feedingTime: "1:30 PM", image: UIImage(named: "sharkFeed")!)
        let penguinFeed = AnimalFeed(animalName: "Penguin Feed", feedingTime: "4:00 PM", image: UIImage(named: "penguinFeed")!)
        let riverGiantFeed = AnimalFeed(animalName: "River Giants Feed", feedingTime: "2:30 PM", image: UIImage(named: "riverGiantsFeed")!)
        let piranhaFeed = AnimalFeed(animalName: "Piranha Feed", feedingTime: "11:00 AM", image: UIImage(named: "piranhaFeed")!)
        let archerfishFeed = AnimalFeed(animalName: "Archerfish Feed", feedingTime: "2:30 PM", image: UIImage(named: "archerfishFeed")!)




