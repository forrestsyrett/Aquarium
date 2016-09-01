//
//  AnimalFeedTableViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class AnimalFeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnimalFeedTableViewCellDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var animalFeedTableView: UITableView!
    @IBOutlet weak var weekdaySegmentedControl: UISegmentedControl!
    @IBOutlet var rightSwipeGesture: UISwipeGestureRecognizer!
    
    
    var selectedWeekday: Int {
        return weekdaySegmentedControl.selectedSegmentIndex + 1
    }
    
    
    private let reuseIdentifier = "feedCell"
    
    var notificationController = NotificationController()
    var feeds = [Feeding]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient(self.view)
        animalFeedTableView.backgroundColor = UIColor.clearColor()
        weekdaySegmentedControl.tintColor = .whiteColor()

 
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Weekday], fromDate: date)
        let dayOfWeek = components.weekday - 1
        
        weekdaySegmentedControl.selectedSegmentIndex = dayOfWeek

        if dayOfWeek == 0 {
            feeds = [.shark, .penguin]
        }
        else if dayOfWeek == 1 {
            feeds = [.archerfish, .penguin]
        }
        else if dayOfWeek == 2 {
            feeds = [.piranha, .shark, .riverGiant, .penguin]
        }
        else if dayOfWeek == 3 {
            feeds = [.penguin]
        }
        else if dayOfWeek == 4 {
            feeds = [.piranha, .shark, .archerfish, .riverGiant, .penguin]
        }
        else if dayOfWeek == 5 {
            feeds = [.penguin]
        }
        else if dayOfWeek == 6 {
            feeds = [.shark, .archerfish, .riverGiant, .penguin]
        }
        
    }
    
    func swipeAction(swipe: UISwipeGestureRecognizer) {

    }

    
    override func viewWillAppear(animated: Bool) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
        
        cell.delegate = self
        
        let feed = feeds[indexPath.row]
        cell.animalFeedLabel.text = feed.info.animalName
        cell.animalFeedImage.image = feed.info.image
        cell.animalFeedTimeLabel.text = feed.info.timeString
        cell.backgroundColor = UIColor.clearColor()
        cell.notificationScheduled = notificationCheck(feed.info.animalName, weekday: selectedWeekday)
        
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
        
        roundCornerButtons(cell.notifyMeButtonLabel)
        roundCornerButtons(cell.animalFeedImage)
        
        
        func animate(cellView: UIView) {
            
            view.addSubview(cellView)
            let basicAnimation = CABasicAnimation()
            basicAnimation.keyPath = "position.x"
            basicAnimation.fromValue = cellView.center.x + 350
            basicAnimation.toValue = cellView.center.x + -30
            basicAnimation.duration = 0.25
            cellView.layer.addAnimation(basicAnimation, forKey: "slide")
            cellView.center.x += -30
        }
        
        animate(cell)
    
        return cell
    }
    
    
    //                check notifications to see which are scheduled. access .userinfo
    func notificationCheck(animalName: String, weekday: Int) -> Bool {
        guard let scheduledLocalNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return false }
        var found = false
        for notification in scheduledLocalNotifications {
            guard let userInfo = notification.userInfo as? [String: String] else { return false }
            if userInfo[String(weekday)] == animalName {
                found = true
            }
        }
        return found
    }
    
    @IBAction func weekdaySegmentedControlSelected(sender: AnyObject) {
        feeds = Feeding.feeding(on: selectedWeekday)
        animalFeedTableView.reloadData()
        
    }
    
    //MARK: - AnimalFeedTableViewCellDelegate Methods
    
    func feedNotificationButtonTapped(animalFeedTableViewCell: AnimalFeedTableViewCell) {
        guard let indexPath = animalFeedTableView.indexPathForCell(animalFeedTableViewCell) else { return }
        let feed = feeds[indexPath.row]
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes:
            [.Alert, .Badge, .Sound], categories: nil))
        
        notificationController.scheduleNotification(for: feed, onWeekday: selectedWeekday, scheduled: animalFeedTableViewCell.notificationScheduled)
        
    }
    
    
    @IBAction func clearFeedingsButtonTapped(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Clear Notifications?", message: "This will cancel all scheduled feeding notifications", preferredStyle: .Alert)
        let clearAction = UIAlertAction(title: "Clear", style: .Default) { (action) in
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            self.animalFeedTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func swipeRecognition(sender: UISegmentedControl) {
        
//        
//        (weekdaySegmentedControl.selectedSegmentIndex) = self.weekdaySegmentedControl.selectedSegmentIndex - 1
//        animalFeedTableView.reloadData()
//        
    }
}
    




