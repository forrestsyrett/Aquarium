//
//  ExhibitTableViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 6/11/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

class ExhibitTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var animalTableView: UITableView!
    
    @IBOutlet weak var exhibitGalleryLabel: UILabel!
    

    static let sharedAnimals = ExhibitTableViewController()
    
    var animals = [Animal]()

    
    func discoverUtahAnimals() {
        
        self.exhibitGalleryLabel.text = "Discover Utah"
        let otters = Animal(name: "North American River Otters", description: "A desert tortoise", animalImage: UIImage(named: "otters")!)
        let tortoise = Animal(name: "Desert Tortoise", description: nil, animalImage: UIImage(named: "tortoise")!)
        
        let discoverUtahAnimals = [otters, tortoise]
        animals = discoverUtahAnimals
    }
    func jsaAnimals() {
        let arapaima = Animal(name: "Giant Arapaima", description: nil, animalImage: UIImage(named: "arapaima")!)
        let toucan = Animal(name: "Swainson's Toucan", description: nil, animalImage: UIImage(named: "toucan")!)
        
        animals = [arapaima, toucan]
    }
    func oceanExplorerAnimals() {
        let zebraShark = Animal(name: "Zebra Shark", description: nil, animalImage: UIImage(named: "zebraShark")!)
        let greenSeaTurtle = Animal(name: "Green Sea Turtle", description: nil, animalImage: UIImage(named: "greenSeaTurtle")!)
        let eel = Animal(name: "Green Moray Eel", description: nil, animalImage: UIImage(named: "eel")!)
        
        animals = [zebraShark, greenSeaTurtle, eel]
    }
    func antarcticAdventureAnimals() {
        let penguins = Animal(name: "Gentoo Penguins", description: nil, animalImage: UIImage(named: "penguins")!)
        
        animals = [penguins]
    }
    func asiaAnimals() {
        let cloudedLeopards = Animal(name: "Clouded Leopard", description: nil, animalImage: UIImage(named: "cloudedLeopard")!)
        let hornbill = Animal(name: "Oriental Pied Hornbill", description: nil, animalImage: UIImage(named: "hornbill")!)
        let binturong = Animal(name: "Binturong", description: nil, animalImage: UIImage(named: "binturong")!)
        
        animals = [cloudedLeopards, hornbill, binturong]
    }
    
    func reload() {
        
        animalTableView.reloadData()
        print("Notification Heard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discoverUtahAnimals()
        animalTableView.reloadData()
        
        print(animals)
        gradient(self.view)
        
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ExhibitTableViewController.reload), name: "test", object: nil)
        
//        let backgroundImage = UIImage(named: "discoverUtah")
//        let imageView = UIImageView(image: backgroundImage)
//        imageView.alpha = 0.75
//        animalTableView.backgroundView = imageView

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "discoverUtah" {
            
            animalTableView.reloadData()

        }
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
        return animals.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("animalCell", forIndexPath: indexPath) as! AnimalTableViewCell
        
        // Configure the cell...
        
        let animal = animals[indexPath.row]
        cell.animalNameLabel.text = animal.name
        cell.animalPreviewImage.image = animal.animalImage
        
        
        return cell
        
    }
    
    
    
    func discoverUtahButtonTapped(exhibitGalleriesViewController: ExhibitGalleriesViewController) {
        
        discoverUtahAnimals()
        animalTableView.reloadData()
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
