//
//  AnimalFeedTableViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class AnimalFeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var animalFeedTableView: UITableView!
    @IBOutlet weak var weekdaySegmentedControl: UISegmentedControl!

    
    private let reuseIdentifier = "feedCell"
    
    var feeds = [AnimalFeed]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animalFeedTableView.reloadData()
        feeds = [sharkFeed, penguinFeed]
        gradient(self.view)
        animalFeedTableView.backgroundColor = UIColor.clearColor()
        weekdaySegmentedControl.tintColor = .whiteColor()
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AnimalFeedTableViewCell
        
        let feed = feeds[indexPath.row]
        cell.animalFeedLabel.text = feed.animalName
        cell.animalFeedImage.image = feed.image
        cell.animalFeedTimeLabel.text = feed.feedingTime
        cell.backgroundColor = UIColor.clearColor()
        
        cell.animalFeedImage.alpha = 0.0
        cell.animalFeedLabel.alpha = 0.0
        cell.animalFeedTimeLabel.alpha = 0.0
        cell.checkMarkImage.alpha = 0.0
        cell.notifyMeButtonLabel.alpha = 0.0
        
        animateLabel(cell.animalFeedLabel, animateTime: 0.75)
        animateImage(cell.animalFeedImage, animateTime: 0.75)
        animateLabel(cell.animalFeedTimeLabel, animateTime: 0.75)
        animateImage(cell.checkMarkImage, animateTime: 0.75)
        animateButton(cell.notifyMeButtonLabel, animateTime: 0.75)
        
        return cell
    }

    
    @IBAction func weekdaySegmentedControlSelected(sender: AnyObject) {
        
        switch weekdaySegmentedControl.selectedSegmentIndex {
            
        case 0:
            feeds = [sharkFeed, penguinFeed]
        case 1:
            feeds = [archerfishFeed, penguinFeed]
        case 2:
            feeds = [piranhaFeed, sharkFeed, riverGiantFeed, penguinFeed]
        case 3:
            feeds = [penguinFeed]
        case 4:
            feeds = [piranhaFeed, sharkFeed, riverGiantFeed, archerfishFeed, penguinFeed]
        case 5:
            feeds = [penguinFeed]
        case 6:
            feeds = [sharkFeed, riverGiantFeed, archerfishFeed]
            
        default: break
        }
        animalFeedTableView.reloadData()
    }
}


