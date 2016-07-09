//
//  FeedingTimesViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/25/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class FeedingTimesViewController: UIViewController {

    
    @IBOutlet weak var sharkFeedLabel: UILabel!
    @IBOutlet weak var sharkFeedImage: UIImageView!
    @IBOutlet weak var piranhaFeedLabel: UILabel!
    @IBOutlet weak var piranhaFeedImage: UIImageView!
    @IBOutlet weak var riverGiantFeedLabel: UILabel!
    @IBOutlet weak var riverGiantFeedImage: UIImageView!
    @IBOutlet weak var penguinFeedLabel: UILabel!
    @IBOutlet weak var penguinFeedImage: UIImageView!
    @IBOutlet weak var smallLogo: UIImageView!
    
    @IBOutlet weak var scrollViewoutlet: UIScrollView!
    
  
    func feedingTime(dayOfweek: Int, hour: Int, minute: Int, minuteEnd: Int, imageOutlet: UIImageView, imageString: String, selectedImageString: String) {
        let currentHour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        let currentMinute = NSCalendar.currentCalendar().component(.Minute, fromDate: NSDate())
        
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let myComponents = myCalendar?.components(.Weekday, fromDate: todayDate)
        let weekDay = myComponents?.weekday
        print(weekDay)
        print(hour)
        print(currentMinute)
        if weekDay == dayOfweek && currentHour == hour && (currentMinute >= minute && currentMinute <= minuteEnd) { imageOutlet.image = UIImage(named: selectedImageString )
        } else { imageOutlet.image = UIImage(named: imageString)
        
        }
     
    }
    /* 
     Sunday = 1
     Monday = 2
     Tuesday = 3
     Wednesday = 4
     Thursday = 5
     Friday = 6
     Saturday = 7
     */
    
    
    override func viewWillAppear(animated: Bool) {
//                ["Tuesday", "Thursday", "Saturday", "Sunday"]
    
//        if hour == 11 && minute == 00 { piranhaFeedLabel.backgroundColor = .whiteColor() }
        
        
    // Shark Feed //
        
        feedingTime(1, hour: 13, minute: 25, minuteEnd: 59, imageOutlet: sharkFeedImage, imageString: "sharkFeed", selectedImageString: "sharkFeedSelected")
        feedingTime(3, hour: 13, minute: 25, minuteEnd: 59, imageOutlet: sharkFeedImage, imageString: "sharkFeed", selectedImageString: "sharkFeedSelected")
        feedingTime(5, hour: 13, minute: 25, minuteEnd: 59, imageOutlet: sharkFeedImage, imageString: "sharkFeed", selectedImageString: "sharkFeedSelected")
        feedingTime(7, hour: 13, minute: 25, minuteEnd: 59, imageOutlet: sharkFeedImage, imageString: "sharkFeed", selectedImageString: "sharkFeedSelected")
        
    // River Giant Feed //
        
        feedingTime(3, hour: 14, minute: 25, minuteEnd: 59, imageOutlet: riverGiantFeedImage, imageString: "riverGiantsFeed", selectedImageString: "riverGiantsFeedSelected")
        feedingTime(5, hour: 14, minute: 25, minuteEnd: 59, imageOutlet: riverGiantFeedImage, imageString: "riverGiantsFeed", selectedImageString: "riverGiantsFeedSelected")
        feedingTime(7, hour: 14, minute: 25, minuteEnd: 59, imageOutlet: riverGiantFeedImage, imageString: "riverGiantsFeed", selectedImageString: "riverGiantsFeedSelected")
        
    // Piranha Feed //
        
        feedingTime(3, hour: 11, minute: 00, minuteEnd: 29, imageOutlet: piranhaFeedImage, imageString: "piranhaFeed", selectedImageString: "piranhaFeedSelected")
        feedingTime(5, hour: 11, minute: 00, minuteEnd: 29, imageOutlet: piranhaFeedImage, imageString: "piranhaFeed", selectedImageString: "piranhaFeedSelected")
        
    // Penguin Feed //
        
        feedingTime(1, hour: 15, minute: 50, minuteEnd: 29, imageOutlet: penguinFeedImage, imageString: "penguinFeed", selectedImageString: "penguinFeedSelected")
        feedingTime(2, hour: 15, minute: 50, minuteEnd: 29, imageOutlet: penguinFeedImage, imageString: "penguinFeed", selectedImageString: "penguinFeedSelected")
        feedingTime(3, hour: 15, minute: 50, minuteEnd: 29, imageOutlet: penguinFeedImage, imageString: "penguinFeed", selectedImageString: "penguinFeedSelected")
        feedingTime(4, hour: 15, minute: 50, minuteEnd: 29, imageOutlet: penguinFeedImage, imageString: "penguinFeed", selectedImageString: "penguinFeedSelected")
        feedingTime(5, hour: 15, minute: 50, minuteEnd: 29, imageOutlet: penguinFeedImage, imageString: "penguinFeed", selectedImageString: "penguinFeedSelected")
        feedingTime(6, hour: 15, minute: 50, minuteEnd: 29, imageOutlet: penguinFeedImage, imageString: "penguinFeed", selectedImageString: "penguinFeedSelected")
        feedingTime(7, hour: 15, minute: 50, minuteEnd: 29, imageOutlet: penguinFeedImage, imageString: "penguinFeed", selectedImageString: "penguinFeedSelected")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        gradient(self.view)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
