//
//  BarcodeGeneratorViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/4/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import CoreImage
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


class AddNewMembershipViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var membershipNameTextField: UITextField!
    @IBOutlet var membershipIDTextField: UITextField!
    @IBOutlet weak var expirationDatePicker: UIDatePicker!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var membership: MembershipCard?
    var membershipCell = MembershipCardTableViewCell()
    
    
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
}
