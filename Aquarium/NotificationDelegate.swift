//
//  NotificationDelegate.swift
//  Aquarium
//
//  Created by TLPAAdmin on 3/14/17.
//  Copyright © 2017 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("received notification")
    }
    
}
