//
//  MainExhibitViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 11/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import FlowingMenu

class MainExhibitViewController: UIViewController, FlowingMenuDelegate, UICollectionViewDelegate, UICollectionViewDataSource, MainExhibitTableViewControllerDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    var menu: UIViewController?
    var allAnimals: [Animals] = []
    var allAnimalsSorted: [Animals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        allAnimals = [Animals.arapaima, Animals.binturong, Animals.cloudedLeopards, Animals.eel, Animals.greenSeaTurtle, Animals.hornbill, Animals.otters, Animals.penguins, Animals.tortoise, Animals.toucan, Animals.zebraShark]
        allAnimalsSorted = allAnimals.sorted { $0.info.name < $1.info.name }
        
        allAnimals = allAnimalsSorted
        
        
        
        
        transparentNavigationBar(self)
        gradient(self.view)
        // Add the pan screen edge gesture to the current view //
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        
        
        // Add the delegate to respond to interactive transition events
        flowingMenuTransitionManager.delegate = self
        
       
        NotificationCenter.default.addObserver(self, selector: #selector(MainExhibitViewController.updateToAllAnimals), name: Notification.Name(rawValue: "allAnimals"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAnimals.count
    }
    
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnimalCollectionViewCell
        
        
        // Add animal data
        
        let animal = allAnimals[indexPath.row]
        
        cell.animalImage.image = animal.info.animalImage
        cell.animalNameLabel.text = animal.info.name
        
        cell.layer.cornerRadius = 5.0
        
        return cell
        
        
    }
    
    // MARK: - Delegate Methods
    
    func gallerySelected(indexPath: Int) {
        switch indexPath {
        case 0: allAnimals = [Animals.otters, Animals.tortoise]
        case 1: allAnimals = [Animals.arapaima, Animals.toucan]
        case 2: allAnimals = [Animals.eel, Animals.greenSeaTurtle, Animals.zebraShark]
        case 3: allAnimals = [Animals.penguins]
        case 4: allAnimals = [Animals.binturong, Animals.cloudedLeopards, Animals.hornbill]
        default: break
        }
        self.collectionView.reloadData()
        menu?.dismiss(animated: true, completion: nil)
    }
    
    ///////////////
    
    
    
    func updateToAllAnimals() {
        allAnimals = allAnimalsSorted
        self.collectionView.reloadData()
        menu?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController  = segue.destination as! MainExhibitTableViewController
        destinationViewController.transitioningDelegate = flowingMenuTransitionManager
        destinationViewController.delegate = self
        
        // Add the left pan gesture to the  menu
        flowingMenuTransitionManager.setInteractiveDismissView(destinationViewController.view)
        menu = destinationViewController
    }
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        performSegue(withIdentifier: "toExhibits", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        menu?.dismiss(animated: true, completion: nil)
    }
    
}
