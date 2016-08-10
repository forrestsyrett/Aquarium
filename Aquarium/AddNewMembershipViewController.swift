//
//  BarcodeGeneratorViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/4/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import CoreImage

class AddNewMembershipViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var membershipNameTextField: UITextField!
    @IBOutlet var membershipIDTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var membership: MembershipCard?
    var membershipCell = MembershipCardTableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient(self.view)
        
        membershipNameTextField.delegate = self
        membershipIDTextField.delegate = self
        transparentNavigationBar(self)
        
        if membershipNameTextField.text?.isEmpty == true {
            saveButton.enabled = false
        }
       
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
//        if membershipNameTextField.text == "" || membershipIDTextField.text == "" {
//            saveButton.enabled = false
//        } else {
//            saveButton.enabled = true
//        }
        membershipIDTextField.resignFirstResponder()
        membershipNameTextField.resignFirstResponder()
        return true
    }

    
    @IBAction func memberIDTextFieldEditingChanged(sender: AnyObject) {
        
        if membershipNameTextField.text?.characters.count <= 0 || membershipIDTextField.text?.characters.count <= 0 {
            saveButton.enabled = false
        } else if membershipIDTextField.text?.characters.count > 0 {
            saveButton.enabled = true
        }
    }
    
    
    @IBAction func memberNameTextFieldEditingChanged(sender: AnyObject) {
        
        if membershipNameTextField.text?.characters.count <= 0 || membershipIDTextField.text?.characters.count <= 0 {
            saveButton.enabled = false
        } else if membershipIDTextField.text?.characters.count > 0 {
            saveButton.enabled = true
        }

    }
    
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        if membership?.memberName == "" && membership?.memberID == "" { return }
        else {
            if let membership = self.membership {
                membership.memberName = self.membershipNameTextField.text!
                membership.memberID = self.membershipIDTextField.text!
                membership.barcodeImageString = self.membershipIDTextField.text!
                
            } else {
                let newMembership = MembershipCard(memberID: self.membershipIDTextField.text!, memberName: self.membershipNameTextField.text!, barcodeImageString: membershipIDTextField.text!)
                MembershipCardController.sharedMembershipController.addMembership(newMembership)
                self.membership = newMembership
            }
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    func updateWithMembership(membership: MembershipCard) {
        self.membership = membership
        
        self.membershipIDTextField.text = membership.memberID
        self.membershipNameTextField.text = membership.memberName
    }
}