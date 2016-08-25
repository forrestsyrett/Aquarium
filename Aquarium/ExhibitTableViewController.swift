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
    
//    @IBOutlet weak var animalImage: UIImageView!

    static let sharedAnimals = ExhibitTableViewController()
    
    var exhibitAnimals = [Animals]()
    
////    func discoverUtahAnimals() 
//        let otters = Animal(name: "North American River Otters", description: "Type: Mammal\nDiet: Carnivorous\nAverage Life Span: 14 – 25 years\nSize: 3.7 feet (males)\n3.2 feet (females) Weight: 11 – 30lbs\nConservation Status: Threatened", animalImage: UIImage(named: "otters")!, isExpanded: false)
//        
//        let tortoise = Animal(name: "Desert Tortoise", description: "Type: Reptile\nDiet: Herbivorous\nAverage Life Span: 50 - 80 years\nSize: 10-14 inches\nWeight: .04 - 11lbs\nConservation Status: Threatened", animalImage: UIImage(named: "tortoise")!, isExpanded: false)
////        exhibitAnimals = [otters, tortoise]
////    }
//    
////    func jsaAnimals() {
//        let arapaima = Animal(name: "Giant Arapaima", description: "Type: Fish\nDiet: Carnivorous\nAverage Life\nSpan: 15 – 20 years\nSize: 9 ft (2.75 m)\nWeight: 440 lbs\nConservation Status: Unknown", animalImage: UIImage(named: "arapaima")!, isExpanded: false)
//        
//        let toucan = Animal(name: "Swainson's Toucan", description: "Type: Bird\nDiet: Omnivorous\nAverage Life Span: 12- 20 Years\nSize: 11.5 in – 29 in\nWeight: 130 g – 680 g (4.6oz – 24oz)\nConservation Status: Stable", animalImage: UIImage(named: "toucan")!, isExpanded: false)
//        
////        exhibitAnimals = [arapaima, toucan]
////    }
////    func oceanExplorerAnimals() {
//        let zebraShark = Animal(name: "Zebra Shark", description: "Type: Fish\nDiet: Omnivorous\nAverage Life Span: 15 - 20 Years\nSize: 2 – 8.2ft\nWeight: 35 - 44 lbs\nConservation Status: Threatened", animalImage: UIImage(named: "zebraShark")!, isExpanded: false)
//        let greenSeaTurtle = Animal(name: "Green Sea Turtle", description: "Type: Reptile\nDiet: Juveniles are omnivorous, Adults are mainly herbivorous\nAverage Life Span: Over 80 years\nSize: Up to 5 ft in length\nWeight: 150 – 419lbs\nConservation Status: Endangered", animalImage: UIImage(named: "greenSeaTurtle")!, isExpanded: false)
//        let eel = Animal(name: "Green Moray Eel", description: "Type: Eel\nDiet: Carnivorous\nAverage Life Span: Estimated 8 - 30 years\nSize: Up to 5 ft in length\nWeight: Up to 65lbs\nConservation Status: Least Concern", animalImage: UIImage(named: "eel")!, isExpanded: false)
//        
////        exhibitAnimals = [zebraShark, greenSeaTurtle, eel]
////    }
////    func antarcticAdventureAnimals() {
//        let penguins = Animal(name: "Gentoo Penguins", description: "Type: Bird\nDiet: Carnivorous\nAverage Life Span: 15 – 20 years\nSize: 30 in\nWeight: 12 lbs (5.5 kg)\nGroup Name: Colony", animalImage: UIImage(named: "penguins")!, isExpanded: false)
//        
////        exhibitAnimals = [penguins]
////    }
////    func asiaAnimals() {
//        let cloudedLeopards = Animal(name: "Clouded Leopard", description: "Type: Mammal\nDiet: Carnivorous\nWing Span: Up to 17 years in captivity\nSize: 27 - 32in (Female), 32 - 43in (male)\nWeight: 25 - 51 lbs\nConservation: Vulnerable", animalImage: UIImage(named: "cloudedLeopard")!, isExpanded: false)
//        let hornbill = Animal(name: "Oriental Pied Hornbill", description: "Type: Bird\nDiet: Frugivore(Diet consists mainly of fruit)\nAverage Life Span: Wing Span: 23 - 32cm\nSize: 55 - 60cm in\nWeight: 600 - 1,050g\nConservation Status: Least Concern", animalImage: UIImage(named: "hornbill")!, isExpanded: false)
//        let binturong = Animal(name: "Binturong", description: "Type: Mammal\nDiet: Omnivorous\nLife Span: Up to 20 years\nSize: 2.3 - 2.8 feet\nWeight: 24 - 71 lbs\nConservation: Vulnerable", animalImage: UIImage(named: "binturong")!, isExpanded: false)
//        
////        exhibitAnimals = [cloudedLeopards, hornbill, binturong]
////    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        exhibitAnimals = [otters, tortoise, arapaima, toucan, zebraShark, greenSeaTurtle, eel, penguins, cloudedLeopards, hornbill, binturong]
        
//        exhibitAnimals = [otters, tortoise]
        animalTableView.reloadData()
        
        animalTableView.rowHeight = UITableViewAutomaticDimension
        animalTableView.estimatedRowHeight = 400
        
        gradient(self.view)
        
    }
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ExhibitTableViewController.reload), name: "test", object: nil)
        
//        let backgroundImage = UIImage(named: "discoverUtah")
//        let imageView = UIImageView(image: backgroundImage)
//        imageView.alpha = 0.75
//        animalTableView.backgroundView = imageView
    
    
    
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
        cell.animalNameLabel.text = animal.name
        cell.animalPreviewImage.image = animal.animalImage
        roundCornerButtons(cell.animalPreviewImage)
        
        return cell
        
    }
    
    
    
    func discoverUtahButtonTapped(exhibitGalleriesViewController: ExhibitGalleriesViewController) {
        
        animalTableView.reloadData()
        
    }
    

    
}

extension ExhibitTableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let moreInfoText = "Tap to learn more! >"
        // 1
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? AnimalTableViewCell else { return }
        
        let animal = exhibitAnimals[indexPath.row]
        
        // 2
        animal.isExpanded = true
        exhibitAnimals[indexPath.row] = animal
        
        // 3
        if animal.isExpanded == true {
            cell.moreInfoTextField?.text = animal.description }
        else {
            cell.moreInfoTextField.text = moreInfoText
        }
        
        // 4
        UIView.animateWithDuration(0.3) {
            cell.contentView.layoutIfNeeded()
        }
        
        // 5
        animalTableView.beginUpdates()
        animalTableView.endUpdates()
        
        // 6
        animalTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let moreInfoText = "Tap to learn more! >"
        // 1
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? AnimalTableViewCell else { return }
        
        let animal = exhibitAnimals[indexPath.row]
        
        // 2
        animal.isExpanded = false
        exhibitAnimals[indexPath.row] = animal
        
        // 3
                  cell.moreInfoTextField.text = moreInfoText
        
        
        // 4
        UIView.animateWithDuration(0.3) {
            cell.contentView.layoutIfNeeded()
        }
        
        // 5
        animalTableView.beginUpdates()
        animalTableView.endUpdates()
        
        // 6
        animalTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "discoverUtah", let destination = segue.destinationViewController as? ExhibitTableViewController {
            if let cell = sender as? UITableViewCell, let indexPath = animalTableView.indexPathForCell(cell) {
                
                exhibitAnimals = [otters, tortoise]
                let exhibitAnimal = exhibitAnimals[indexPath.row]
                destination.exhibitAnimals = [exhibitAnimal]
            }
        }
    }

}

