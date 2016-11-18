//
//  MainExhibitViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 11/17/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import FlowingMenu

class MainExhibitViewController: UIViewController, FlowingMenuDelegate {


        let flowingMenuTransitionManager = FlowingMenuTransitionManager()
        var menu: UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavigationBar(self)
        gradient(self.view)
            // Add the pan screen edge gesture to the current view //
            flowingMenuTransitionManager.setInteractivePresentationView(view)
            
            
            // Add the delegate to respond to interactive transition events
            flowingMenuTransitionManager.delegate = self
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationViewController  = segue.destination as! MainExhibitTableViewController
            destinationViewController.transitioningDelegate = flowingMenuTransitionManager
            
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
