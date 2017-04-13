//
//  MapTableViewCell.swift
//  Aquarium
//
//  Created by TLPAAdmin on 3/25/17.
//  Copyright © 2017 Forrest Syrett. All rights reserved.
//

import UIKit


protocol AnimalActionsDelegate: class {
    func infoButtonAction(_ mapTableViewCell: MapTableViewCell)
    func locateButtonAction(_ mapTableViewCell: MapTableViewCell)
    func feedingButtonAction(_ mapTableViewCell: MapTableViewCell)
}

class MapTableViewCell: UITableViewCell {

    

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    weak var delegate: AnimalActionsDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func feedingButtonTapped(_ sender: Any) {
        delegate?.feedingButtonAction(self)
        print("Delegate Sent for feeding")
    }
    @IBAction func animalInfoButtonTapped(_ sender: Any) {
        delegate?.infoButtonAction(self)
        print("Delegate Sent for info")
    }
    @IBAction func locateButtonTapped(_ sender: Any) {
        delegate?.locateButtonAction(self)
        print("Delegate Sent for locate")
    }
}
