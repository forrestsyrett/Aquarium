//
//  AnimalFeedTableViewCell.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/2/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class AnimalFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animalFeedNameLabel: UILabel!
    @IBOutlet weak var animalFeedTimeLabel: UILabel!
    @IBOutlet weak var animalFeedImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
