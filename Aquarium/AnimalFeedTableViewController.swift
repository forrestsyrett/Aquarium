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
        animalFeedTableView.reloadData()
        feeds = [.shark, .penguin]
        gradient(self.view)
        animalFeedTableView.backgroundColor = UIColor.clearColor()
        weekdaySegmentedControl.tintColor = .whiteColor()
        
//        let leftSwipe = UISwipeGestureRecognizer(target: self, action: (#selector(AnimalFeedTableViewController.swipeAction(_:))))
//        let rightSwipe = UISwipeGestureRecognizer(target: self, action:(#selector(AnimalFeedTableViewController.swipeAction(_:))))
//        
//        leftSwipe.direction = .Left
//        rightSwipe.direction = .Right
//        
//        view.addGestureRecognizer(leftSwipe)
//        view.addGestureRecognizer(rightSwipe)
    }
    
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        if swipe.direction == .Left {
     
            if self.weekdaySegmentedControl.selectedSegmentIndex < 6 {
                self.weekdaySegmentedControl.selectedSegmentIndex + 1
            self.weekdaySegmentedControl.sendActionsForControlEvents(.ValueChanged)
                animalFeedTableView.reloadData()
            }
                print("Left swipe")
            print(weekdaySegmentedControl.selectedSegmentIndex)
//            else { return }
        }
        if swipe.direction == .Right {
            if self.weekdaySegmentedControl.selectedSegmentIndex > 0 {
                self.weekdaySegmentedControl.selectedSegmentIndex - 1
                self.weekdaySegmentedControl.sendActionsForControlEvents(.ValueChanged)
            }
                print("Right swipe")
                print(weekdaySegmentedControl.selectedSegmentIndex)
//            else { return }
        }
    }
//

    
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
    
    @IBAction func swipeRecognition(sender: UISegmentedControl) {
        
//        if sender.selectedSegmentIndex > 0 {
//            self.view.addGestureRecognizer(self.rightSwipeGesture)
//            weekdaySegmentedControl.selectedSegmentIndex + 1
//            print("right swipe")
//        } else {
//            self.view.removeGestureRecognizer(self.rightSwipeGesture)
//        }
    }
    
}



