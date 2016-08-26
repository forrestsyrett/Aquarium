//
//  Animal.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/23/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit

enum Animals {
    case otters
    case tortoise
    case arapaima
    case toucan
    case zebraShark
    case greenSeaTurtle
    case eel
    case penguins
    case cloudedLeopards
    case hornbill
    case binturong
    
    struct Info {
        var name: String
        var description: String?
        var animalImage: UIImage
 
    
    }
 
      var info: Info {
    
        switch self {
            
        case .otters:
            return
                Info(name: "North American River Otters", description: "Type: Mammal\nDiet: Carnivorous\nAverage Life Span: 14 – 25 years\nSize: 3.7 feet (males)\n3.2 feet (females) Weight: 11 – 30lbs\nConservation Status: Threatened", animalImage: UIImage(named: "otters")!)
        case .tortoise:
            return
                Info(name: "Desert Tortoise", description: "Type: Reptile\nDiet: Herbivorous\nAverage Life Span: 50 - 80 years\nSize: 10 - 14 inches\nWeight: .04 - 11lbs\nConservation Status: Threatened", animalImage: UIImage(named: "tortoise")!)
        case .arapaima:
            return
                Info(name: "Giant Arapaima", description: "Type: Fish\nDiet: Carnivorous\nAverage Life\nSpan: 15 – 20 years\nSize: 9 ft (2.75 m)\nWeight: Up to 440 lbs\nConservation Status: Unknown", animalImage: UIImage(named: "arapaima")!)
        case .toucan:
            return
                Info(name: "Swainson's Toucan", description: "Type: Bird\nDiet: Omnivorous\nAverage Life Span: 12 - 20 Years\nSize: 11.5 – 29 in\nWeight: 130 – 680g (4.6oz – 24oz)\nConservation Status: Stable", animalImage: UIImage(named: "toucan")!)
        case .zebraShark:
            return
                Info(name: "Zebra Shark", description: "Type: Fish\nDiet: Omnivorous\nAverage Life Span: 15 - 20 Years\nSize: 2 – 8.2ft\nWeight: 35 - 44 lbs\nConservation Status: Threatened", animalImage: UIImage(named: "zebraShark")!)
        case .greenSeaTurtle:
            return
                Info(name: "Green Sea Turtle", description: "Type: Reptile\nDiet: Juveniles are omnivorous, Adults are mainly herbivorous\nAverage Life Span: Over 80 years\nSize: Up to 5 ft in length\nWeight: Up to 700 lbs\nConservation Status: Endangered", animalImage: UIImage(named: "greenSeaTurtle")!)
        case .eel:
            return
                Info(name: "Green Moray Eel", description: "Type: Eel\nDiet: Carnivorous\nAverage Life Span: Estimated 8 - 30 years\nSize: Up to 5 ft in length\nWeight: Up to 65lbs\nConservation Status: Least Concern", animalImage: UIImage(named: "eel")!)

        case .penguins:
            return
                Info(name: "Gentoo Penguins", description: "Type: Bird\nDiet: Carnivorous\nAverage Life Span: 15 – 20 years\nSize: 30 in\nWeight: 12 lbs (5.5 kg)\nGroup Name: Colony", animalImage: UIImage(named: "penguins")!)

        case .cloudedLeopards:
            return
                Info(name: "Clouded Leopard", description: "Type: Mammal\nDiet: Carnivorous\nWing Span: Up to 17 years in captivity\nSize: 27 - 32in (Female), 32 - 43in (male)\nWeight: 25 - 51 lbs\nConservation: Vulnerable", animalImage: UIImage(named: "cloudedLeopard")!)
        case .hornbill:
            return
                Info(name: "Oriental Pied Hornbill", description: "Type: Bird\nDiet: Frugivore(Diet consists mainly of fruit)\nAverage Life Span: Wing Span: 23 - 32cm\nSize: 55 - 60cm in\nWeight: 600 - 1,050g\nConservation Status: Least Concern", animalImage: UIImage(named: "hornbill")!)
        case .binturong:
            return
                Info(name: "Binturong", description: "Type: Mammal\nDiet: Omnivorous\nLife Span: Up to 20 years\nSize: 2.3 - 2.8 feet\nWeight: 24 - 71 lbs\nConservation: Vulnerable", animalImage: UIImage(named: "binturong")!)
        }
    }
    
    }
