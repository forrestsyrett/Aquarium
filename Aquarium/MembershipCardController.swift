//
//  MembershipCardController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/5/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation


class MembershipCardController {
    
    private let membershipKey = "memberships"
    
    static let sharedMembershipController = MembershipCardController()
    
    var memberships = [MembershipCard]()
    
    init() {
        loadFromPersistentStorage()
    }
    
    
    func addMembership(membership: MembershipCard) {
        memberships.append(membership)
        saveToPersistentStorage()
    }
    
    func removeMembership(membership: MembershipCard) {
        if let index = memberships.indexOf(membership) {
            memberships.removeAtIndex(index)
            saveToPersistentStorage()
        }
    }
    
    func saveToPersistentStorage() {
        
        let membershipDictionaries = self.memberships.map({$0.dictionaryCopy()})
        NSUserDefaults.standardUserDefaults().setObject(membershipDictionaries, forKey: membershipKey)
        
    }
    
    func loadFromPersistentStorage() {
        if let membershipDictionariesFromDefaults = NSUserDefaults.standardUserDefaults().objectForKey(membershipKey) as? [Dictionary<String, String>] {
            self.memberships = membershipDictionariesFromDefaults.map({MembershipCard(dictionary: $0)!})
        }
    }
}