//
//  AnimalFeedTableViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/2/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class AnimalFeedTableViewController: UITableViewController {
    
    var feeds = [AnimalFeed]()
    
    func addAnimalFeeds() {
    
        let sharkFeed = AnimalFeed(animalName: "Shark Feed", feedingTime: "1:30 PM", image: UIImage(named: "sharkFeed")!)
        let penguinFeed = AnimalFeed(animalName: "Penguin Feed", feedingTime: "4:00 PM", image: UIImage(named: "penguinFeed")!)
        let riverGiantFeed = AnimalFeed(animalName: "River Giant Feed", feedingTime: "2:30 PM", image: UIImage(named: "riverGiantsFeed")!)
        let piranhaFeed = AnimalFeed(animalName: "Piranha Feed", feedingTime: "11:00 AM", image: UIImage(named: "piranhaFeed")!)
        
        feeds += [piranhaFeed, sharkFeed, riverGiantFeed, penguinFeed]
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAnimalFeeds()
        
        gradient(tableView)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("animalFeedTableViewCell", forIndexPath: indexPath) as! AnimalFeedTableViewCell
        
        let feed = feeds[indexPath.row]
        cell.animalFeedNameLabel.text = feed.animalName
        cell.animalFeedTimeLabel.text = feed.feedingTime
        cell.animalFeedImage.image = feed.image
        cell.backgroundColor = UIColor.clearColor()

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
