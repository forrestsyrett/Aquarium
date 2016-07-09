//
//  AnimalFeedCollectionViewCell.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/2/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class AnimalFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animalFeedImage: UIImageView!
    @IBOutlet weak var animalFeedLabel: UILabel!
    @IBOutlet weak var animalFeedTimeLabel: UILabel!
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var notifyMeButtonLabel: UIButton!
    
    
    
    @IBAction func notifyMeButtonTapped(sender: AnyObject){
        if notifyMeButtonLabel.titleLabel?.text == "Notify Me!" {
            
        notifyMeButtonLabel.setTitle("Cancel Notification", forState: .Normal)
        checkMarkImage.image = UIImage(named: "checkmarkSelected")
        }
        
        if notifyMeButtonLabel.titleLabel?.text == "Cancel Notification" {
            
            notifyMeButtonLabel.setTitle("Notify Me!", forState: .Normal)
            checkMarkImage.image = UIImage(named: "checkmark")

            
        }

            
    }
}


