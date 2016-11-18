//
//  BottomSheetViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 11/5/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import SafariServices


var galleryTest = ""

protocol BottomSheetViewControllerDelegate: class {
    func getDirectionsButtonTapped(_ bottomSheetViewController: BottomSheetViewController)
}

class BottomSheetViewController: UIViewController, UIGestureRecognizerDelegate  {
    
    
    static let shared = BottomSheetViewController()
    
    var titleLabel = "Test"
    
    // Info Variables
    weak var delegate: BottomSheetViewControllerDelegate?
    
    @IBOutlet var completeView: UIView!
    @IBOutlet weak var galleryTitleLabel: UILabel!
    @IBOutlet weak var galleryPhoto1: UIImageView!
    @IBOutlet weak var galleryInfo: UILabel!
    @IBOutlet weak var shadowView: UIImageView!
    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    var buttonAction = "Safari"
    
    
    let galleries = MapGalleryController.sharedController
    
    var galleryName = ""
    
    let fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 120
        
    }
    var urlString = "http://www.thelivingplanet.com/"
    
    
    enum ButtonActions: String {
       case Safari = "Safari"
         case WebView = "WebView"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        
        view.addGestureRecognizer(gesture)
        
        gesture.delegate = self
        
        roundedCorners(completeView, cornerRadius: 5.0)
        roundedCorners(galleryPhoto1, cornerRadius: 5.0)
        roundedCorners(handleView, cornerRadius: 5.0)
        roundedCorners(getDirectionsButton, cornerRadius: 5.0)
        postObservers()
        
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.50
        shadowView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        shadowView.layer.shadowRadius = 7.0
        
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            let yComponent = UIScreen.main.bounds.height - 120
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let frame = self.view.frame
        let yComponent = UIScreen.main.bounds.height - 120
        self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        
        self.view.transform = .identity
    }
    
    
    func animateTappedGallery() {
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 8.0, options: .allowUserInteraction, animations: {
            self.view.transform = CGAffineTransform(translationX: 0.0, y: -25.0)
        }, completion: nil)
        
    }
    
    
    func discoverUtah() {
        updateLabels(gallery: galleries.discoverUtah)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("More Info!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid_category/discover-utah/"
        
    }
    
    func antarcticAdventure() {
        updateLabels(gallery: galleries.antarcticAdventure)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("Penguin Cam", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid/penguin-live-cam/"
        
    }
    
    func ammenities() {
        updateLabels(gallery: galleries.amenities)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("More Info!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/"
    }
    
    func banquetHall() {
        updateLabels(gallery: galleries.banquetHall)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("Book an event!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid/wedding-proposals/"
    }
    
    func asia() {
        updateLabels(gallery: galleries.expeditionAsia)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("More Info!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid/expedition-asia/"
    }
    
    func jsa() {
        updateLabels(gallery: galleries.jsa)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("More Info!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid_category/south-america/"
    }
    
    func oceans() {
        updateLabels(gallery: galleries.oceanExplorer)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("More Info!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid_category/invertebrates/"
    }
    
    func tukis() {
        updateLabels(gallery: galleries.tukis)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("Book a party!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/home-4/parties/"
    }
    func jellies() {
        updateLabels(gallery: galleries.jellyFish)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("More Info!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid/ocean-explorer/"
    }
    func theater() {
        updateLabels(gallery: galleries.theater)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("Check schedule", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid/4d-theatre-showtimes/"
    }
    func educationCenter() {
        updateLabels(gallery: galleries.educationCenter)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("More Info!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/home-4/education/"
    }
    func deepSea() {
        updateLabels(gallery: galleries.deepSeaLab)
        animateTappedGallery()
        self.getDirectionsButton.setTitle("More Info!", for: .normal)
        self.urlString = "http://www.thelivingplanet.com/essential_grid/exhibit-updates/"
    }
    
    
    func postObservers() {
        
        //        let allGalleries = [galleries.amenities, galleries.discoverUtah, galleries.antarcticAdventure, galleries.banquetHall, galleries.expeditionAsia, galleries.jsa, galleries.oceanExplorer, galleries.tukis]
        //
        
        //        for galleryName in allGalleries {
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.discoverUtah), name: Notification.Name(rawValue: galleries.discoverUtah.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.antarcticAdventure), name: Notification.Name(rawValue: galleries.antarcticAdventure.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.ammenities), name: Notification.Name(rawValue: galleries.amenities.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.asia), name: Notification.Name(rawValue: galleries.expeditionAsia.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.jsa), name: Notification.Name(rawValue: galleries.jsa.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.oceans), name: Notification.Name(rawValue: galleries.oceanExplorer.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.tukis), name: Notification.Name(rawValue: galleries.tukis.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.banquetHall), name: Notification.Name(rawValue: galleries.banquetHall.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.jellies), name: Notification.Name(rawValue: galleries.jellyFish.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.theater), name: Notification.Name(rawValue: galleries.theater.name), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.educationCenter), name: Notification.Name(rawValue: galleries.educationCenter.name), object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(BottomSheetViewController.deepSea), name: Notification.Name(rawValue: galleries.deepSeaLab.name), object: nil)
    }
    
    
    
    func updateLabels(gallery: MapGalleries) {
        
        self.galleryTitleLabel.text = gallery.name
        self.galleryPhoto1.image = gallery.image1
        self.galleryInfo.text = gallery.info
        
    }
    
    
    func panGesture(recognizer: UIPanGestureRecognizer) {
        
        
        //        self.view.transform = CGAffineTransform.identity
        
        let translation = recognizer.translation(in: self.view)
        
        let velocity = recognizer.velocity(in: self.view)
        
        
        
        
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.0 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: .allowUserInteraction, animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            })
        }
        
        if recognizer.isUp(view: self.view) == false {
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8.0, options: .allowUserInteraction, animations: {
                self.view.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            }, completion: nil)
            
            
        }
        
        
    }
    
    
    
    @IBAction func getDirectionsButtonTapped(_ sender: AnyObject) {
        
        
        switch self.buttonAction {
        case ButtonActions.Safari.rawValue:
        delegate?.getDirectionsButtonTapped(self)
        
        animateDown()
        
        let url = URL(string: self.urlString)!
        let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        safariViewController.preferredBarTintColor = UIColor(red:0.00, green:0.10, blue:0.20, alpha:1.00)
        safariViewController.preferredControlTintColor = UIColor.white
        
        self.present(safariViewController, animated: true, completion: nil)
            
            
        case ButtonActions.WebView.rawValue:
            storyboard?.instantiateViewController(withIdentifier: "webview")
        default: break
    }
        
    }
    
    func animateDown() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
            UIView.animate(withDuration: 0.5) {
                let frame = self.view.frame
                let yComponent = UIScreen.main.bounds.height - 145
                self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
            }
            
        }, completion: { (true) in
            UIView.animate(withDuration: 0.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8.0, options: .allowUserInteraction, animations: {
                self.view.transform = .identity
            }, completion: nil)
        })
    }
    
    
    }



extension UIPanGestureRecognizer {
    
    func isUp(view: UIView) -> Bool {
        
        let direction: CGPoint = velocity(in: view)
        if direction.y < 0 {
            // Panning up
            return true
        } else {
            // Panning Down
            return false
        }
    }
}

