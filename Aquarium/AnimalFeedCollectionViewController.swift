//
//  AnimalFeedCollectionViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/2/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit

private let reuseIdentifier = "animalFeedCollectionViewCell"

class AnimalFeedCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var animalFeedImage: UIImageView!
    
    
    var feeds = [AnimalFeed]()
    
    func addAnimalFeeds() {
        
        let sharkFeed = AnimalFeed(animalName: "Shark Feed", feedingTime: "1:30 PM", image: UIImage(named: "sharkFeed")!)
        let penguinFeed = AnimalFeed(animalName: "Penguin Feed", feedingTime: "4:00 PM", image: UIImage(named: "penguinFeed")!)
        let riverGiantFeed = AnimalFeed(animalName: "River Giants Feed", feedingTime: "2:30 PM", image: UIImage(named: "riverGiantsFeed")!)
        let piranhaFeed = AnimalFeed(animalName: "Piranha Feed", feedingTime: "11:00 AM", image: UIImage(named: "piranhaFeed")!)
        let archerfishFeed = AnimalFeed(animalName: "Archerfish Feed", feedingTime: "2:30 PM", image: UIImage(named: "archerfishFeed")!)
        
        feeds += [piranhaFeed, sharkFeed, riverGiantFeed, archerfishFeed, penguinFeed]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAnimalFeeds()
        gradient(self.view)
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return feeds.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AnimalFeedCollectionViewCell
    
        let feed = feeds[indexPath.row]
        cell.animalFeedLabel.text = feed.animalName
        cell.animalFeedImage.image = feed.image
        cell.animalFeedTimeLabel.text = feed.feedingTime
        cell.backgroundColor = UIColor.clearColor()
        
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
