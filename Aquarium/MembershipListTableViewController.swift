//
//  MembershipCardTableViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 8/5/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit

class MembershipListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var membershipCardTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        gradient(self.view)
        membershipCardTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        membershipCardTableView.reloadData()
        gradient(self.view)
        membershipCardTableView.backgroundColor = UIColor.clearColor()
        transparentNavigationBar(self)
        
        
    }
    
    let membership = MembershipCardTableViewCell()
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MembershipCardController.sharedMembershipController.memberships.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath) as! MembershipCardTableViewCell
        
        let membership = MembershipCardController.sharedMembershipController.memberships[indexPath.row]
        
        
        func barcodefromString(string : String) -> UIImage? {
            
            guard let barcode = string.dataUsingEncoding(NSASCIIStringEncoding) else { return barcodefromString("1") }
            let filter = CIFilter(name: "CICode128BarcodeGenerator")
            filter!.setValue(barcode, forKey: "inputMessage")
            return UIImage(CIImage: filter!.outputImage!)
        }
        
        // Configure the cell...
        cell.memberNameLabel.text = membership.memberName
        cell.membershipIDLabel.text = membership.memberID
        cell.barcodeImage.image = barcodefromString(membership.memberID)
        cell.backgroundColor = UIColor.clearColor()
        roundCornerButtons(cell.barcodeImage)
        
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let membership = MembershipCardController.sharedMembershipController.memberships[indexPath.row]
            
            MembershipCardController.sharedMembershipController.removeMembership(membership)
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}