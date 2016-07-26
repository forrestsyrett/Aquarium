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
    
    var feeds = [Feeding]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animalFeedTableView.reloadData()
        feeds = [.shark, .penguin]
        gradient(self.view)
        animalFeedTableView.backgroundColor = UIColor.clearColor()
        weekdaySegmentedControl.tintColor = .whiteColor()

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
        
        let weekday = weekdaySegmentedControl.selectedSegmentIndex
        let checkmark = UIImage(named: "checkmark")
        let checkmarkSelected = UIImage(named: "checkmarkSelected")
        
         enum weekdays: Int {
            case sunday = 0
            case monday = 1
            case tuesday = 2
            case wednesday = 3
            case thursday = 4
            case friday = 5
            case saturday = 6
            
        }
        
        let penguinFeed = "Penguin Feed"
        let sharkFeed = "Shark Feed"
        let archerfishFeed = "Archerfish Feed"
        let riverGiantFeed = "River Giant Feed"
        let piranhaFeed = "Piranha Feed"
        
        let notifyMe = "Notify Me!"
        let cancel = "Cancel"
        
        
        let notify = UILocalNotification()
        notify.userInfo = ["Test": "Test"]
        
        
       
        
      //  MARK: - Sunday Notifications
        
        // Penguin Feed
    
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.sunday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.sunday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        // Shark Feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.sunday.rawValue && cell.animalFeedLabel.text == sharkFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.sunday.rawValue && cell.animalFeedLabel.text == sharkFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        
        
        // MARK: - Monday Notifications
        
        // Archerfish
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.monday.rawValue && cell.animalFeedLabel.text == archerfishFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.monday.rawValue && cell.animalFeedLabel.text == archerfishFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        
        // Penguin Feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.monday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.monday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }

        
        // MARK: - Tuesday Notifications
        
        
        // Piranha Feed
        
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && cell.animalFeedLabel.text == piranhaFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .piranha, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && cell.animalFeedLabel.text == piranhaFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .piranha, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }

        
        // shark feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && cell.animalFeedLabel.text == sharkFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .shark, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && cell.animalFeedLabel.text == sharkFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        
        // river giants feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && cell.animalFeedLabel.text == riverGiantFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && cell.animalFeedLabel.text == riverGiantFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }


        // penguin feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.tuesday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }

        
        
        // MARK: - Wednesday Notifications
        
        
        // Penguin feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.wednesday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
        notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
        cell.checkMarkImage.image = checkmarkSelected
    } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.wednesday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
    notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
    cell.checkMarkImage.image = checkmark
    }

        
        // MARK: - Thursday Notifications
        
        
        // Piranha Feed
        
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == piranhaFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .piranha, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == piranhaFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .piranha, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        
        // shark feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == sharkFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .shark, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == sharkFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        
        // river giants feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == riverGiantFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == riverGiantFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        
        // Archerfish feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == archerfishFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == archerfishFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        
        // penguin feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.thursday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }

    
        
    // MARK: - Friday Notifications
        
        
        
        // penguin feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.friday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.friday.rawValue && cell.animalFeedLabel.text == penguinFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .penguin, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }

    
    // MARK: - Saturday Notifications
        
        
        // shark feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && cell.animalFeedLabel.text == sharkFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .shark, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && cell.animalFeedLabel.text == sharkFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .shark, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }

        // river giants feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && cell.animalFeedLabel.text == riverGiantFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && cell.animalFeedLabel.text == riverGiantFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .riverGiant, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }

        // Archerfish feed
        
        if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && cell.animalFeedLabel.text == archerfishFeed && cell.notifyMeButtonLabel.titleLabel?.text == cancel {
            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday , scheduled: true)
            cell.checkMarkImage.image = checkmarkSelected
        } else if weekdaySegmentedControl.selectedSegmentIndex == weekdays.saturday.rawValue && cell.animalFeedLabel.text == archerfishFeed && cell.notifyMeButtonLabel.titleLabel?.text == notifyMe {
            notificationController().scheduleNotification(for: .archerfish, onWeekday: weekday, scheduled: false)
            cell.checkMarkImage.image = checkmark
        }
        
        
        return cell
    }

    @IBAction func weekdaySegmentedControlSelected(sender: AnyObject) {
        feeds = Feeding.feeding(on: weekdaySegmentedControl.selectedSegmentIndex + 1)
        animalFeedTableView.reloadData()

    }
}



