//
//  Animal.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/23/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit


class animal {
    
    var name: String = "Tortoise"
    var description: String
    var animalImage: UIImage
    
    
    init(name: String = "Tortoise", description: String, animalImage: UIImage) {
        
        self.name = name
        self.description = description
        self.animalImage = animalImage
    }
    

    
}

