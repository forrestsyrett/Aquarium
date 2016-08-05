//
//  AnimalFeedTableViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class AnimalFeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnimalFeedTableViewCellDelegate {

    @IBOutlet weak var animalFeedTableView: UITableView!
    @IBOutlet weak var weekdaySegmentedControl: UISegmentedControl!

    
    private let reuseIdentifier = "feedCell"
    static let key: NSObject = "key"
    
    var feeds = [Feeding]()
    var animal = AnimalFeedTableViewCell()
    let checkmark = UIImage(named: "checkmark")
    let checkmarkSelected = UIImage(named: "checkmarkSelected")
//    let penguinFeed = "Penguin Feed"
//    let sharkFeed = "Shark Feed"
//    let archerfishFeed = "Archerfish Feed"
//    let riverGiantFeed = "River Giant Feed"
//    let piranhaFeed = "Piranha Feed"
    
    let notifyMe = "Notify Me!"
    let cancel = "Cancel"
    
    
    
    enum weekdays: Int {
        case sunday = 0
        case monday = 1
        case tuesday = 2
        case wednesday = 3
        case thursday = 4
        case friday = 5
        case saturday = 6
        
    }
    
    
    //                check notifications to see which are scheduled. access .userinfo
    func notificationCheck(animalName: String, dayOfWeek: String, feeding: String) -> Bool {
        guard let scheduledLocalNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return false }
        var found = false
        for Notification in scheduledLocalNotifications {
            if (Notification.userInfo! as? Dictionary<String, String>)! == [dayOfWeek : feeding] {
               found = true
//                    animal.checkMarkImage.image = checkmarkSelected
                print("\(animalName) notification found!")
            } else {
//                    animal.checkMarkImage.image = checkmark
                print("No notification found")
            }
        }
        return found
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animalFeedTableView.reloadData()
        feeds = [.shark, .penguin]
        gradient(self.view)
        animalFeedTableView.backgroundColor = UIColor.clearColor()
        weekdaySegmentedControl.tintColor = .whiteColor()
        
//        notificationCheck(Feeding.penguin.info.animalName, dayOfWeek: "Sunday", feeding: penguinFeed)
        

    }
    
    
    override func viewWillAppear(animated: Bool) {
        print(UIApplication.sharedApplication().scheduledLocalNotifications)
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
        cell.delegate = self
        
        let feed = feeds[indexPath.row]
        cell.animalFeedLabel.text = feed.info.animalName
        cell.animalFeedImage.image = feed.info.image
        cell.animalFeedTimeLabel.text = feed.info.timeString
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
        feeds = Feeding.feeding(on: weekdaySegmentedControl.selectedSegmentIndex + 1)
        animalFeedTableView.reloadData()

    }
    
    //MARK: - AnimalFeedTableViewCellDelegate Methods
    
    func feedNotificationButtonTapped(animalFeedTableViewCell: AnimalFeedTableViewCell) {
        
        
        print("\(animalFeedTableViewCell.animalFeedLabel.text) button was tapped")
        print(UIApplication.sharedApplication().scheduledLocalNotifications)
        
        
//        let checkmark = UIImage(named: "checkmark")
//        let checkmarkSelected = UIImage(named: "checkmarkSelected")
//        let penguinFeed = "Penguin Feed"
//        let sharkFeed = "Shark Feed"
//        let archerfishFeed = "Archerfish Feed"
//        let riverGiantFeed = "River Giant Feed"
//        let piranhaFeed = "Piranha Feed"
//        
//        let notifyMe = "Notify Me!"
//        let cancel = "Cancel"
//        let weekday = weekdaySegmentedControl.selectedSegmentIndex
//
//        
//        
//        enum weekdays: Int {
//            case sunday = 0
//            case monday = 1
//            case tuesday = 2
//            case wednesday = 3
//            case thursday = 4
//            case friday = 5
//            case saturday = 6
//            
//        }
        
        
//                check notifications to see which are scheduled. access .userinfo
//        func notificationCheck(dayOfWeek: String, feeding: String) {
//            if let scheduledLocalNotifications = UIApplication.sharedApplication().scheduledLocalNotifications {
//                for Notification in scheduledLocalNotifications {
//                    if (Notification.userInfo! as? Dictionary<String, String>)! == [dayOfWeek : feeding] {
//                        animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//                        print("success!")
//                    } else {
//                        animalFeedTableViewCell.checkMarkImage.image = checkmark
//                        print("No notification found")
//                    }
//                }
//            }
//            
//        }
        
//        // MARK: - Sunday Notifications
//        
//        let sunday = "Sunday"
//        
//        // Penguin Feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.sunday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true, dayOfWeek: sunday)
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.sunday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false, dayOfWeek: sunday)
//        }
//        
//        // Shark Feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.sunday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == sharkFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: true, dayOfWeek: sunday)
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.sunday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == sharkFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: false, dayOfWeek: sunday)
//            notificationCheck(sunday, feeding: sharkFeed)
//        }
//
//    
//        
//        
//        // MARK: - Monday Notifications
//        
//        // Archerfish
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.monday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == archerfishFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.monday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == archerfishFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // Penguin Feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.monday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.monday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // MARK: - Tuesday Notifications
//        
//        
//        // Piranha Feed
//        
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == piranhaFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .piranha, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == piranhaFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .piranha, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // shark feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == sharkFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .shark, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == sharkFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // river giants feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == riverGiantFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == riverGiantFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // penguin feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        
//        // MARK: - Wednesday Notifications
//        
//        
//        // Penguin feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.wednesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.wednesday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // MARK: - Thursday Notifications
//        
//        
//        // Piranha Feed
//        
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == piranhaFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .piranha, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == piranhaFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .piranha, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // shark feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == sharkFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .shark, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == sharkFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // river giants feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == riverGiantFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == riverGiantFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // Archerfish feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == archerfishFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == archerfishFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // penguin feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        
//        // MARK: - Friday Notifications
//        
//        
//        
//        // penguin feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.friday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.friday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == penguinFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        
//        // MARK: - Saturday Notifications
//        
//        
//        // shark feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == sharkFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .shark, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == sharkFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        // river giants feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == riverGiantFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == riverGiantFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }
//        
//        // Archerfish feed
//        
//        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == archerfishFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == cancel {
//            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday , scheduled: true)
//            animalFeedTableViewCell.checkMarkImage.image = checkmarkSelected
//        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && animalFeedTableViewCell.animalFeedLabel.text == archerfishFeed && animalFeedTableViewCell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
//            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday, scheduled: false)
//            animalFeedTableViewCell.checkMarkImage.image = checkmark
//        }

        
        
        
        
        
        
    }
}



