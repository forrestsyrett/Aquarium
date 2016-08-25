//
//  ExhibitTableViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/11/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class ExhibitTableViewController: UIViewController, UITableViewDataSource  {
    
    
    @IBOutlet weak var animalTableView: UITableView!
    @IBOutlet weak var exhibitGalleryLabel: UILabel!
    
    
    var exhibitAnimals = [Animals]()
    var exhibitGalleryLabelMutable = "Exhibit Gallery"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exhibitGalleryLabel.text = exhibitGalleryLabelMutable
        animalTableView.reloadData()
        animalTableView.rowHeight = UITableViewAutomaticDimension
        animalTableView.estimatedRowHeight = 400
        
        gradient(self.view)
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        animalTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exhibitAnimals.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("animalCell", forIndexPath: indexPath) as! AnimalTableViewCell
        
        // Configure the cell...
        
        let animal = exhibitAnimals[indexPath.row]
        cell.animalNameLabel.text = animal.info.name
        cell.animalPreviewImage.image = animal.info.animalImage
        cell.backgroundColor = cell.contentView.backgroundColor
        roundCornerButtons(cell.animalPreviewImage)
        
        return cell
        
    }
}


extension ExhibitTableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? AnimalTableViewCell else { return }
        
        let animal = exhibitAnimals[indexPath.row]
        
        exhibitAnimals[indexPath.row] = animal
        
        cell.moreInfoTextField?.text = animal.info.description
        
        UIView.animateWithDuration(0.4) {
            cell.contentView.layoutIfNeeded()
        }
        
        animalTableView.beginUpdates()
        animalTableView.endUpdates()
        
        animalTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let moreInfoText = "Tap to learn more! >"
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? AnimalTableViewCell else { return }
        
        let animal = exhibitAnimals[indexPath.row]
        
        exhibitAnimals[indexPath.row] = animal
        
        cell.moreInfoTextField.text = moreInfoText
        
        UIView.animateWithDuration(0.4) {
            cell.contentView.layoutIfNeeded()
        }
        
        animalTableView.beginUpdates()
        animalTableView.endUpdates()
    }
    
}
