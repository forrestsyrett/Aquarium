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
    
    
    fileprivate var memberNameKey = "memberName"
    fileprivate var memberIDNumberKey = "memberID"
    fileprivate var barcodeImageKey = "barcodeImage"
    fileprivate var expirationDateKey = "date"
    
    
    var memberID: String
    var memberName: String
    var barcodeImageString: String
    var expirationDate: Date
    
    
    init(memberID: String, memberName: String, barcodeImageString: String, expirationDate: Date) {
        
        self.memberID = memberID
        self.memberName = memberName
        self.barcodeImageString = barcodeImageString
        self.expirationDate = expirationDate
        
    }
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let memberID = dictionary[memberIDNumberKey],
            let memberName = dictionary[memberNameKey],
            let barcodeImage = dictionary[barcodeImageKey],
        let expirationDate = dictionary[expirationDateKey]
            else {
                self.barcodeImageKey = ""
                self.memberNameKey = ""
                self.memberID = ""
                self.expirationDate = Date(timeInterval: 1.0, since: Date())
                return nil
        }
        
        self.memberID = memberID as! String
        self.memberName = memberName as! String
        self.barcodeImageString = barcodeImage as! String
        self.expirationDate = expirationDate as! Date
        
    }
    
    func dictionaryCopy() -> Dictionary<String, AnyObject> {
        let dictionary = [
            memberIDNumberKey: memberID.self,
            memberNameKey: memberName.self,
            barcodeImageKey: barcodeImageString.self,
            expirationDateKey: expirationDate.self] as [String : Any]
        
        return dictionary as Dictionary<String, AnyObject>
    }
    
    
    
}

func ==(lhs: MembershipCard , rhs: MembershipCard ) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    
}
