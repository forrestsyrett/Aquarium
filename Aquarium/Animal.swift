//
//  Animal.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/23/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit


class Animal {
    
    var name: String
    var description: String?
    var animalImage: UIImage
    
    
    init(name: String, description: String?, animalImage: UIImage) {
        
        self.name = name
        self.description = description
        self.animalImage = animalImage
    }
    

    
}

//enum Animals {
//    case otters
//    case tortoise
//    case arapaima
//    case toucan
//    case zebraShark
//    case greenSeaTurtle
//    case eel
//    case penguins
//    case cloudedLeopards
//    case hornbill
//    case binturong
//    
//    struct Info {
//        var animalName: String
//        var notificationTitle: String
//        var time: NSDate
//        var hour: Int
//        var minute: Int
//        var timeString: String
//        var weekdays: [Int: Bool]
//        var image: UIImage?
//    }
//    
//    var info: Info {
//        let now = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        
//        switch self {
//        case .otters:
//             let otters = Animal(name: "North American River Otters", description: "A desert tortoise", animalImage: UIImage(named: "otters")!)
//        case .tortoise:
//            let tortoise = Animal(name: "Desert Tortoise", description: nil, animalImage: UIImage(named: "tortoise")!)
//        case .archerfish:
//            let time = calendar.dateBySettingHour(14, minute: 30, second: 0, ofDate: now, options: .MatchStrictly)!
//            return Info(animalName: "Archerfish Feed", notificationTitle: "Archerfish feeding at \(Feeding.dateFormatter.stringFromDate(time))!", time: time, hour: 14, minute: 15, timeString: Feeding.dateFormatter.stringFromDate(time), weekdays: [2: true, 5: true, 7: true], image: UIImage(named: "archerfishFeed")!)
//        case .riverGiant:
//            let time = calendar.dateBySettingHour(14, minute: 30, second: 0, ofDate: now, options: .MatchStrictly)!
//            return Info(animalName: "River Giants Feed", notificationTitle: "River Giants feeding at \(Feeding.dateFormatter.stringFromDate(time))!", time: time, hour: 14, minute: 15, timeString: Feeding.dateFormatter.stringFromDate(time), weekdays: [3: true, 5: true, 7: true], image: UIImage(named: "riverGiantsFeed")!)
//        case .piranha:
//            let time = calendar.dateBySettingHour(11, minute: 00, second: 0, ofDate: now, options: .MatchStrictly)!
//            return Info(animalName: "Piranha Feed", notificationTitle: "Piranha feeding at \(Feeding.dateFormatter.stringFromDate(time))!", time: time, hour: 10, minute: 45, timeString: Feeding.dateFormatter.stringFromDate(time), weekdays: [3: true, 5: true], image: UIImage(named: "piranhaFeed")!)
//        }
//}
