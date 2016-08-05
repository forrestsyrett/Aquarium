//
//  AnimalFeedTableViewCell.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

protocol AnimalFeedTableViewCellDelegate: class {
    func feedNotificationButtonTapped(animalFeedTableViewCell: AnimalFeedTableViewCell)
}

class AnimalFeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var animalFeedImage: UIImageView!
    @IBOutlet weak var animalFeedLabel: UILabel!
    @IBOutlet weak var animalFeedTimeLabel: UILabel!
    @IBOutlet weak var notifyMeButtonLabel: UIButton!
    @IBOutlet weak var checkMarkImage: UIImageView!
    weak var delegate: AnimalFeedTableViewCellDelegate?
    
    var notificationScheduled = false {
        didSet {
            notifyMeButtonLabel.setTitle(notificationScheduled ? AnimalFeedTableViewCell.cancelNotification : AnimalFeedTableViewCell.notifyMe, forState: .Normal)
            checkMarkImage.image = UIImage(named: notificationScheduled ? "checkmarkSelected" : "checkmark")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static let notifyMe = "Notify Me!"
    static let cancelNotification = "Cancel"
    static let IDKey = "ID"
    
    
    private let sunday = 0
    private let monday = 1
    private let tuesday = 2
    private let wednesday = 3
    private let thursday = 4
    private let friday = 5
    private let saturday = 6
    
    @IBAction func notifyMeButtonTapped(sender: AnyObject) {
        notificationScheduled = !notificationScheduled
        
        delegate?.feedNotificationButtonTapped(self)
    }
    
}


