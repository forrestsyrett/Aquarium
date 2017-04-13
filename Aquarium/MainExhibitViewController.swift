//
//  MainExhibitViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 11/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import FlowingMenu

class MainExhibitViewController: UIViewController, FlowingMenuDelegate, UICollectionViewDelegate, UICollectionViewDataSource, MainExhibitTableViewControllerDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    var menu: UIViewController?
    var allAnimals: [Animals] = []
    var allAnimalsSorted: [Animals] = []
    var dataSourceForSearchResult:[Animals]?
    var searchBarIsActive: Bool = false
    var searchBarBoundsY: CGFloat?
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        allAnimals = AnimalController.shared.allAnimals
        allAnimalsSorted = allAnimals.sorted { $0.info.name < $1.info.name }
        
        allAnimals = allAnimalsSorted
        
        dataSourceForSearchResult = [Animals]()
        
        
        tabBarTint(view: self)
        transparentNavigationBar(self)
        gradient(self.view)
        
        
        // Add the pan screen edge gesture to the current view //
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        
        
        // Add the delegate to respond to interactive transition events
        flowingMenuTransitionManager.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainExhibitViewController.updateToAllAnimals), name: Notification.Name(rawValue: "allAnimals"), object: nil)
        
        registerForKeyboardNotifications()
        
        
        
        
        let downGesture = UIPanGestureRecognizer.init(target: self,action: #selector(MainExhibitViewController.panGesture))
        searchBar.addGestureRecognizer(downGesture)
        
        downGesture.delegate = self
        
        
    }
    
    func panGesture(recognizer: UIPanGestureRecognizer) {
        
        if !recognizer.isUp(view: self.searchBar) {
            self.searchBar.resignFirstResponder()
        }
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
    }
   
    
    // MARK: - Search Bar Functions
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarIsActive = true
        allAnimals = allAnimalsSorted
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count > 0 {
            self.searchBarIsActive = true
            filterSearchResults(searchText: searchText)
            
        } else {
            self.searchBarIsActive = false
            self.collectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBarIsActive = false
        self.searchBar.text = ""
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarIsActive = false
        self.searchBar.resignFirstResponder()
        
    }
    
    
    
    ////////////////////////////////////////////////////////
    //          MARK: - Keyboard Functions                //
    ////////////////////////////////////////////////////////
    
    
    
    func resignKeyboard() {
        searchBar.resignFirstResponder()
        setSearchBarView()
        
    }
    func setSearchBarView() {
        searchBar.frame = CGRect(x: 0, y: 637, width: view.frame.width, height: 50)
        self.searchBar.isHidden = false
    }
    
    // Mark: - SearchBar Movement Response to Keyboard
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainExhibitViewController.resignKeyboard), name: Notification.Name(rawValue: "enteringBackground"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainExhibitViewController.setSearchBarView), name: Notification.Name(rawValue: "active"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainExhibitViewController.resignKeyboard), name: Notification.Name(rawValue: "exhibitsAppeared"), object: nil)
    }
    
    func removeObservers() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "enteringBackground" ), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "active" ), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "allAnimals" ), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "exhibitsAppeared"), object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight: CGFloat = (keyboardSize?.height)!
        
        UIView.animate(withDuration: 0.40, delay: 0.027, options: UIViewAnimationOptions.curveEaseIn, animations: {
            
            self.searchBar.frame = CGRect(x: 0, y: (self.searchBar.frame.origin.y - keyboardHeight + 50), width: self.view.bounds.width, height: 50)
        }, completion: nil)
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.searchBar {
            if (!aRect.contains(activeField.frame.origin)){
            }
        }
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification) {
        var info = notification.userInfo!
   //     let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
   //     let keyboardHeight: CGFloat = (keyboardSize?.height)!
        
        UIView.animate(withDuration: 0.20, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            
            
            self.searchBar.frame.origin.y = 637
        }, completion: nil)
        
        self.view.endEditing(true)
        
    }
    ///////////////////////////////////////////////////
    
    // Generate cells for animals
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.searchBarIsActive && (self.searchBar.text?.characters.count)! > 0 {
            return self.dataSourceForSearchResult!.count
        } else {
        return allAnimals.count
        }}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnimalCollectionViewCell
        
        if self.searchBarIsActive && (self.searchBar.text?.characters.count)! > 0 {
            cell.animalNameLabel.text = self.dataSourceForSearchResult?[indexPath.row].info.name
            cell.animalImage.image = self.dataSourceForSearchResult?[indexPath.row].info.animalImage
        } else {
            
            
            //         Default Animal Data When No Search Is Present
            
            let animal = allAnimals[indexPath.row]
            
            cell.animalImage.image = animal.info.animalImage
            cell.animalNameLabel.text = animal.info.name
        }
        // cell.alpha = 0.0
        
        //   UIView.animate(withDuration: 0.30, animations: {
        //       cell.alpha = 1.0
        //   }, completion: nil)
        
        cell.layer.cornerRadius = 5.0
        
        return cell
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchBarIsActive = false
        searchBar.resignFirstResponder()
    }
    
    
    
    // MARK: - Gallery Selected Delegate Methods
    
    func gallerySelected(indexPath: Int) {
        switch indexPath {
        case 0: allAnimals = [Animals.otters, Animals.tortoise]
        case 1: allAnimals = [Animals.arapaima, Animals.toucan]
        case 2: allAnimals = [Animals.eel, Animals.greenSeaTurtle, Animals.zebraShark, Animals.blacktipReef]
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
    
    func dimBackground() {
    /*   if searchBarIsActive {
            dimView.isHidden = false
        } else {
            dimView.isHidden = true
        } */
    }
    
    
    
    
    // MARK: - Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toExhibits" {
            let destinationViewController  = segue.destination as! MainExhibitTableViewController
            destinationViewController.transitioningDelegate = flowingMenuTransitionManager
        destinationViewController.delegate = self
        
            // Add the left pan gesture to the  menu
            flowingMenuTransitionManager.setInteractiveDismissView(destinationViewController.view)
            menu = destinationViewController
        }
        
        if segue.identifier == "toAnimalDetail" {
            
            if let destinationViewController = segue.destination as? AnimalDetailViewController {
                
                let indexPath = self.collectionView.indexPath(for: (sender as! UICollectionViewCell))
                if let selectedItem = (indexPath as NSIndexPath?)?.row {
                    
                    if (self.searchBar.text?.characters.count)! > 0 {
                        let animal = dataSourceForSearchResult?[selectedItem]
                        destinationViewController.updateInfo(animal: animal!)
                    }
                    else  {
                        let animal = allAnimals[selectedItem]
                        print(selectedItem)
                        destinationViewController.updateInfo(animal: animal)
                        destinationViewController.animal = animal.info.name
                    }
                }
            }
        }
    }
    
    
    // MARK: - Delegate Functions
    
        func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
            performSegue(withIdentifier: "toExhibits", sender: self)
        }
        
        func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
            menu?.dismiss(animated: true, completion: nil)
        }
        
        



    
    
    // MARK: - Search Filter
    
    func filterSearchResults(searchText: String) {
        
        let animals = allAnimals.filter { ( ($0.info.name.range(of: searchText) != nil))}
        dataSourceForSearchResult = animals
        self.collectionView.reloadData()
        
    }
    
    
    deinit {
        removeObservers()
    }
    
    
}
