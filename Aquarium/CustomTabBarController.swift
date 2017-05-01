//
//  CustomTabBarController.swift
//  CustomTabBar
//
//  Created by Adam Bardon on 07/03/16.
//  Copyright © 2016 Swift Journey. All rights reserved.
//

import UIKit


class CustomTabBarController: UITabBarController, CustomTabBarDataSource, CustomTabBarDelegate, UITabBarControllerDelegate {
    
    static let shared = CustomTabBarController()
    var selectedTabIndex = 0
    var buttonColor = aquaLight
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true
        self.selectedIndex = 2
        self.selectedTabIndex = self.selectedIndex
        let customTabBar = CustomTabBar(frame: self.tabBar.frame)
       
        
        customTabBar.datasource = self
        customTabBar.delegate = self
        self.delegate = self
        customTabBar.setup()
        
         self.view.addSubview(customTabBar)
        setupHomeButton()
    }
    
 
    func tabBarItemsInCustomTabBar(_ tabBarView: CustomTabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
    
    
    func didSelectViewController(_ tabBarView: CustomTabBar, atIndex index: Int) {
       self.selectedIndex = index
        
    }
    
    // MARK: - TabBarTransition Delegate
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTabBarAnimatedTransition()
    }
 
    func setupHomeButton() {
        let homeButton = UIButton(frame: CGRect(x: 0, y: 2.0, width: 64, height: 64))
        var homeButtonFrame = homeButton.frame
        homeButtonFrame.origin.y = self.view.bounds.height - homeButtonFrame.height
        homeButtonFrame.origin.x = self.view.bounds.width/2 - homeButtonFrame.size.width/2
        homeButton.frame = homeButtonFrame
        
        
        homeButton.backgroundColor = buttonColor
        homeButton.layer.cornerRadius = homeButtonFrame.height/2
        homeButton.layer.borderColor = UIColor.white.cgColor
        homeButton.layer.borderWidth = 0.5
        self.view.addSubview(homeButton)
        homeButton.setImage(#imageLiteral(resourceName: "home"), for: .normal)
        homeButton.tintColor = .white
        homeButton.isUserInteractionEnabled = false
        self.view.layoutIfNeeded()
    }
    


}
