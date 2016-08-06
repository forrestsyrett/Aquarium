//
//  Membership.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/5/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit


class MembershipCard: Equatable {
    
    
    private var memberNameKey = "memberName"
    private let memberIDNumberKey = "memberID"
    private var barcodeImageKey = "barcodeImage"
    
    
    var memberID: String
    var memberName: String
    var barcodeImageString: String
    
    
    init(memberID: String, memberName: String, barcodeImageString: String) {
        
        self.memberID = memberID
        self.memberName = memberName
        self.barcodeImageString = barcodeImageString
        
    }
    init?(dictionary: Dictionary<String, String>) {
        guard let memberID = dictionary[memberIDNumberKey],
            let memberName = dictionary[memberNameKey],
            let barcodeImage = dictionary[barcodeImageKey]
            else {
                self.barcodeImageKey = ""
                self.memberNameKey = ""
                self.memberID = ""
                return nil
        }
        
        self.memberID = memberID
        self.memberName = memberName
        self.barcodeImageString = barcodeImage
        
    }
    
    func dictionaryCopy() -> Dictionary<String, AnyObject> {
        let dictionary = [
            memberIDNumberKey: memberID.self,
            memberNameKey: memberName.self,
            barcodeImageKey: barcodeImageString.self ]
        
        return dictionary
    }
    
    
    
}

func ==(lhs: MembershipCard , rhs: MembershipCard ) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    
}