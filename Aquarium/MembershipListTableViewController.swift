//
//  MembershipCardTableViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/5/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import UserNotifications

class MembershipListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var membershipCardTableView: UITableView!
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var becomeAMemberButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tabBarTint(view: self)
        
        membershipCardTableView.reloadData()
        roundCornerButtons(becomeAMemberButtonLabel)
        roundCornerButtons(welcomeView)
        roundCornerButtons(blurView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MembershipListTableViewController.reloadView), name: Notification.Name(rawValue: "addedNewMembership"), object: nil)
        
        self.membershipCardTableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0)
        
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared.delegate
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        membershipCardTableView.reloadData()
        gradient(self.view)
        membershipCardTableView.backgroundColor = UIColor.clear
        transparentNavigationBar(self)
        
        if MembershipCardController.sharedMembershipController.memberships.count != 0 {
            
            welcomeView.isHidden = true
            blurView.isHidden = true
        } else {
            welcomeView.isHidden = false
            blurView.isHidden = false
        }
        IndexController.shared.index = (self.tabBarController?.selectedIndex)!

    }
    
    
    func reloadView() {
        self.membershipCardTableView.reloadData()
        welcomeView.isHidden = true
    }
    
    
    @IBAction func becomeAMemberButtonTapped(_ sender: AnyObject) {
        
        let safariVC = SFSafariViewController(url: URL(string: "https://tickets.thelivingplanet.com/WebStore/Shop/ViewItems.aspx?CG=online&C=Memberships")!)
        safariVC.preferredControlTintColor = UIColor.white
        safariVC.preferredBarTintColor = UIColor(red:0.00, green:0.10, blue:0.20, alpha:1.00)
        present(safariVC, animated: true, completion: nil)
    }
    
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        
//        completionHandler([.alert, .sound])
//    }
    
    
    let membership = MembershipCardTableViewCell()
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MembershipCardController.sharedMembershipController.memberships.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MembershipCardTableViewCell
        
        let membership = MembershipCardController.sharedMembershipController.memberships[(indexPath as NSIndexPath).row]
        
        
        func barcodefromString(_ string : String) -> UIImage? {
            
            guard let barcode = string.data(using: String.Encoding.ascii) else { return barcodefromString("1") }
            let filter = CIFilter(name: "CICode128BarcodeGenerator")
            filter!.setValue(barcode, forKey: "inputMessage")
            return UIImage(ciImage: filter!.outputImage!)
        }
        
        // Configure the cell...
        cell.firstNameLabel.isHidden = true
        cell.lastNameLabel.isHidden = true
        cell.fullNameLabel.text = "\(membership.firstName) \(membership.lastName)"
        cell.membershipIDLabel.text = membership.memberID
        cell.barcodeImage.image = barcodefromString(membership.memberID)
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        
        cell.expirationDateLabel.text = "Expires: \((dateFormat.string(from: membership.expirationDate)))"
        cell.backgroundColor = UIColor.clear
        roundCornerButtons(cell.barcodeImage)
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let membership = MembershipCardController.sharedMembershipController.memberships[(indexPath as NSIndexPath).row]
            
            MembershipCardController.sharedMembershipController.removeMembership(membership)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "addedNewMembership"), object: nil)
        print("removed Notification")
    }
    
}






