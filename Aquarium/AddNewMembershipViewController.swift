//
//  BarcodeGeneratorViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/4/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import CoreImage
import UserNotifications
import SafariServices
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class AddNewMembershipViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    
    @IBOutlet var membershipNameTextField: UITextField!
    @IBOutlet var membershipIDTextField: UITextField!
    @IBOutlet weak var expirationDatePicker: UIDatePicker!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var expirationReminderSwitch: UISwitch!

    var membership: MembershipCard?
    var membershipCell = MembershipCardTableViewCell()
    var name = "first"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient(self.view)
        transparentNavigationBar(self)
        
        membershipNameTextField.delegate = self
        membershipIDTextField.delegate = self
        transparentNavigationBar(self)
        
        if membershipNameTextField.text?.isEmpty == true {
            saveButton.isEnabled = false
            
            dismissButton.layer.cornerRadius = 17.0
        }
       
    }

    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        if membershipNameTextField.text == "" || membershipIDTextField.text == "" {
//            saveButton.enabled = false
//        } else {
//            saveButton.enabled = true
//        }
        membershipIDTextField.resignFirstResponder()
        membershipNameTextField.resignFirstResponder()
        return true
    }

    
    @IBAction func memberIDTextFieldEditingChanged(_ sender: AnyObject) {
        
        if membershipNameTextField.text?.characters.count <= 0 || membershipIDTextField.text?.characters.count <= 0 {
            saveButton.isEnabled = false
        } else if membershipIDTextField.text?.characters.count > 0 {
            saveButton.isEnabled = true
        }
    }
    
    
    @IBAction func memberNameTextFieldEditingChanged(_ sender: AnyObject) {
        
        if membershipNameTextField.text?.characters.count <= 0 || membershipIDTextField.text?.characters.count <= 0 {
            saveButton.isEnabled = false
        } else if membershipIDTextField.text?.characters.count > 0 {
            saveButton.isEnabled = true
        }

    }
    
    
    
    @IBAction func saveButton(_ sender: AnyObject) {
        
        if membership?.memberName == "" && membership?.memberID == "" { return }
        else {
            if let membership = self.membership {
                membership.memberName = self.membershipNameTextField.text!
                membership.memberID = self.membershipIDTextField.text!
                membership.barcodeImageString = self.membershipIDTextField.text!
                let date = self.expirationDatePicker.date
                membership.expirationDate = self.expirationDatePicker.date
                print(self.expirationDatePicker.date)

            } else {
                let newMembership = MembershipCard(memberID: self.membershipIDTextField.text!, memberName: self.membershipNameTextField.text!, barcodeImageString: membershipIDTextField.text!, expirationDate: expirationDatePicker.date)
                MembershipCardController.sharedMembershipController.addMembership(newMembership)
                self.membership = newMembership
                print(self.expirationDatePicker.date)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "addedNewMembership"), object: nil)
        scheduleReminder()
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func updateWithMembership(_ membership: MembershipCard) {
        self.membership = membership
        
        self.membershipIDTextField.text = membership.memberID
        self.membershipNameTextField.text = membership.memberName
        self.expirationDatePicker.date = membership.expirationDate
    }
    
    
    func registerForNotificationCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let expirationDateReminder = UNNotificationAction(identifier: (self.name), title: "Renew Membership!", options: .foreground)
        let remindMeAction = UNNotificationAction(identifier: "reminder", title: "Remind me later", options: [])

        let category = UNNotificationCategory(identifier: "category", actions: [expirationDateReminder, remindMeAction], intentIdentifiers: [])
        
        center.setNotificationCategories([category])

    }
    
    
    
    func scheduleExpirationReminder(date: Date) {
        
        registerForNotificationCategories()
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        
        
        
        // Logic to schedule notification 2 weeks before expiration date
        var day = components.day
        var month = components.month
        
        if components.day < 14 {
            
            
            enum Months: Int {
                case Jan = 1
                case Feb
                case March
                case April
                case May
                case June
                case July
                case August
                case Sept
                case Oct
                case Nov
                case Dec
            }
            

            let dayDifference = components.day! - 14
            print("DayDifference = \(dayDifference)")
            month! -= 1
            day! = 30 + dayDifference

           /* switch components.month! {
                
            case Months.Feb.rawValue:
                day! = 29 + dayDifference
                
            case Months.April.rawValue, Months.June.rawValue, Months.Sept.rawValue, Months.Nov.rawValue:
            day! = 30 + dayDifference
                
            case Months.Jan.rawValue, Months.March.rawValue, Months.May.rawValue, Months.July.rawValue, Months.August.rawValue, Months.Oct.rawValue, Months.Dec.rawValue:
                day! = 31 + dayDifference

            default: break
            } */
            
            
        }
        
        let newComponents = DateComponents(
            
            
            calendar: calendar,
            timeZone: .current,
            year: components.year,
            month: month,
            day: day,
            hour: components.hour,
            minute: components.minute)
        
        
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        
        //Notification Content
        let content = UNMutableNotificationContent()
        if let name = self.membershipNameTextField.text {
            self.name = name
        content.title = "\(self.name), your Membership expires soon!"
        }
        content.body = "Press for more options"
        
        content.sound = UNNotificationSound(named: "fishFlop.m4r")
        content.categoryIdentifier = "category"
        content.userInfo = ["customData": "test"]
        
        
        // Notification Request
        
        let request = UNNotificationRequest(identifier: self.name, content: content, trigger: dateTrigger)
       // UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("There was an error \(error)")
            }
        }
    }
    
    func scheduleReminder() {
        if expirationReminderSwitch.isOn {
            scheduleExpirationReminder(date: self.expirationDatePicker.date)
    
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

        
        
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")
                
                
            case "\(self.name)":
                // User tapped Renew Button
                print("Renewing")
               let safariVC = SFSafariViewController(url: URL(string: "https://tickets.thelivingplanet.com/WebStore/shop/PassLookup.aspx?RedirectURL=Renewal&SalesChannelDetailID=120041")!)
                
                self.present(safariVC, animated: true, completion: nil)
    
            case "reminder":
                /// User Tapped Remind Me Later
                print("Remind me later")
                let newDate = Date(timeInterval: 10, since: Date())
                scheduleExpirationReminder(date: newDate)
//604800
                break
            default:
                break
            }
        
        }
        completionHandler()
    }

    
    
}
