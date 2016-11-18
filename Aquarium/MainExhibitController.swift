//
//  MainExhibitController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 11/18/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit


class MainExhibitController {
    
    
    static let shared = MainExhibitController()
    
    
    
    let discoverUtah = MainExhibit(exhibitName: "Discover Utah", exhibitImage: #imageLiteral(resourceName: "discoverUtah"))
    let oceanExplorer = MainExhibit(exhibitName: "Ocean Explorer", exhibitImage: #imageLiteral(resourceName: "OceanExplorer"))
    let journeyToSouthAmerica = MainExhibit(exhibitName: "Journey to South America", exhibitImage: #imageLiteral(resourceName: "journeyToSouthAmerica"))
    let antarcticAdventure = MainExhibit(exhibitName: "Antarctic Adventure", exhibitImage: #imageLiteral(resourceName: "antarcticAdventure"))
    let expeditionAsia = MainExhibit(exhibitName: "Expedition Asia", exhibitImage: #imageLiteral(resourceName: "asia"))
    
    
}
