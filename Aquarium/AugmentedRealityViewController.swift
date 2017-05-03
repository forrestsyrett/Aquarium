//
//  AugmentedRealityViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 5/2/17.
//  Copyright © 2017 Forrest Syrett. All rights reserved.
//



import UIKit



class AugmentedRealityViewController: UIViewController, CraftARContentEventsProtocol, CraftARSDKProtocol, SearchProtocol, CraftARTrackingEventsProtocol {
    
    @IBOutlet weak var videoPreview: UIView!
    
    @IBOutlet weak var scanButton: UIButton!
    
    @IBOutlet weak var aquaWave: UIImageView!
    
    var sdk = CraftARSDK()
    var craftARTracking: CraftARTracking!
    var cloudRecognition = CraftARCloudRecognition()
    var allARItems: [CraftARItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.sdk = CraftARSDK.shared()
        self.sdk.delegate = self
        
        
        self.cloudRecognition = CraftARCloudRecognition.sharedCloudImage()
        self.cloudRecognition.delegate = self
        
        self.craftARTracking = CraftARTracking.shared()
        self.craftARTracking.delegate = self
        
        self.scanButton.layer.cornerRadius = 15.0
        aquaWave.alpha = 0.9
        scanButton.backgroundColor = aquaLight
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        sdk.startCapture(with: self.videoPreview)
        IndexController.shared.index = (self.tabBarController?.selectedIndex)!

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        sdk.stopCapture()
        craftARTracking.removeAllARItems()
    }
    
    
    
    func didStartCapture() {
        
        self.sdk.searchControllerDelegate = self.cloudRecognition.mSearchController
        
        
        // Collection token defined on CraftAR Creator
        self.cloudRecognition.setCollectionWithToken("a1e70776a0be4b8c", onSuccess: { () -> Void in
            print("ready to search!")
            
            self.searchForObjects()
            
        }) { (error) -> Void in
            print("Error setting token: \(error?.localizedDescription ?? "No Error")")
        }
    }
    
    
    func searchForObjects() {
        
        //Start searching for recognizable objects
        self.sdk.startFinder()
        print("Finder Started")
    }
    
    
    
    
    func didGetSearchResults(_ results: [Any]) {
        
        var haveARItems: Bool = false
        var haveIRItems: Bool = false
        if results.count >= 1 {
            sdk.stopFinder()
            print("Got search result. Stopped Finder")
            
            //Found one result. Only showing AR Content for the item at index[0]
            // change this to loop through the array for each image for multiple scans
            
            let result = results[0]
            
            //Cast "Any" result to CraftARSearchResult to access .item property
            let newResult = result as! CraftARSearchResult
            
            // Each result has one item
            let item: CraftARItem = newResult.item
            if (item is CraftARItemAR) {
                let arItem: CraftARItemAR = (item as! CraftARItemAR)
                print("THIS IS THE ITEM \(arItem)")
                print("\(arItem.allContents())")
                
                self.cloudRecognition.embedCustomField = true
                
                //Add recognized item to Tracking array
                let err: Error? = craftARTracking.addARItem(arItem)
                
                if err != nil {
                    print("Error adding AR item: \(err?.localizedDescription ?? "No Error")")
                }
                haveARItems = true
            }
            
            if haveARItems {
                CraftARTracking.shared().delegate = self
                //Start AR experience
                self.craftARTracking.start()
                
                print("STARTING OBJECT TRACKING")
                
                
                // Following Code for Image Recognition Only
            } else if haveARItems == false && results.count >= 1 {
                print("found item but no AR scene")
                sdk.stopFinder()
                print(item.name)
                presentAlert(item: item)
                
            }
                
                //////////////////////////////////////
            else {
                sdk.startFinder()
                print("HIT ELSE STATEMENT")
            }
        }
    }
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        
        if scanButton.titleLabel?.text == "Scan!" {
            
            sdk.startFinder()
            self.craftARTracking.removeAllARItems()
            self.scanButton.setTitle("Scanning...", for: .normal)
            
            print("Finder Started")
            
            
        }
            
        else {
            
            
            self.scanButton.setTitle("Scan!", for: .normal)
            
            sdk.stopFinder()
            craftARTracking.stop()
            print("Finder Stopped")
            
        }
    }
    
    
    func presentAlert(item: CraftARItem) {
        
        if let name = item.name {
            let alert = UIAlertController(title: "You've found a \(name)", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Awesome!", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            self.sdk.stopFinder()
            
        }
    }
    
    
    
    func didFailSearchWithError(_ error: Error!) {
        sdk.stopFinder()
        print("Search Failed")
        self.scanButton.setTitle("Scan!", for: .normal)
    }
    
    
    
    func didStartTrackingItem(_ item: CraftARItemAR!) {
        print("Tracking started for: \(item.name)")
        
    }
    
    func didStopTrackingItem(_ item: CraftARItemAR!) {
        print("Tracking stopped for: \(item.name)")
    }
    
    
    func didGet(_ event: CraftARContentTouchEvent, for content: CraftARTrackingContent) {
        switch event {
            
        case .CRAFTAR_CONTENT_TOUCH_IN:
            print("Touch in: \(content.uuid)")
            
            
        case .CRAFTAR_CONTENT_TOUCH_OUT:
            print("Touch out: \(content.uuid)")
            
            
        case .CRAFTAR_CONTENT_TOUCH_UP:
            print("Touch up: \(content.uuid)")
            //Show animal facts here when object is tapped
            
            
        case .CRAFTAR_CONTENT_TOUCH_DOWN:
            print("Touch down: \(content.uuid)")
            
        }
        
    }
    
}
