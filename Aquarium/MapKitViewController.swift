//
//  MapKitViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 11/5/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import MapKit
import OneSignal
import CoreLocation


class MapKitViewController: UIViewController, MKMapViewDelegate, BottomSheetViewControllerDelegate, CLLocationManagerDelegate {
    
    
    static let shared = MapKitViewController()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var selectedFloor: UISegmentedControl!
    
    @IBOutlet weak var restroomButton: UIButton!
    @IBOutlet weak var cafeButton: UIButton!
    @IBOutlet weak var giftShopBUtton: UIButton!
    @IBOutlet weak var zoomGalleryView: UIView!
    @IBOutlet weak var zoomedGalleryImage: UIImageView!
    @IBOutlet weak var compassButton: UIButton!
    
    @IBOutlet weak var exitZoomButton: UIButton!
    
    let galleries = MapGalleryController.sharedController
    let bottomSheetViewController = BottomSheetViewController()
    
   // var locationManager: CLLocationManager!
    
    var aquarium = AquariumMap(filename: "Aquarium")
    var aquariumSecondFloor = AquariumMap(filename: "AquariumSecondFloor")
    var background = Background(filename: "BackgroundOverlay")
    var floorImage = UIImage(named: "mainFloor")
    var delta = 0.0
    var selectedPin: MKPlacemark? = nil
    var titleLabel: String = "Tap on a gallery to learn more!"
    var label = UILabel(frame: CGRect(x: 16, y: 20, width: 343, height: 21))
    var currentLocationAnnotation = Annotation(coordinate: CurrentLocationController.shared.coordinate, title: "Current Location", subtitle: "", type: AnnotationTypes.CurrentLocation)
    var manuallyChangingMapRect: Bool = true
    
    var route: MKPolyline? = nil
    var firstFloor: MKOverlay? = nil
    var secondFloor: MKOverlay? = nil
    
    var trackingSwitch = 2
    var trackingType = "user"
    
    enum TrackingTypes: String {
    
        case user = "user"
        case map = "map"
        case off = "off"
    }
    
    
    var galleryZoomed = false
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        
        
        tabBarTint(view: self)
        
        bottomSheetViewController.delegate = self
        
        currentLocationAnnotation.coordinate = CurrentLocationController.shared.coordinate
        
        mapView.mapType = .standard
        
        
        let latDelta = aquarium.topLeftMapCoordinate.latitude + 0.0009 - aquarium.bottomRightMapCoordinate.latitude + 0.0009
        
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        self.delta = latDelta
        
        let region = MKCoordinateRegionMake(aquarium.midCoordinate, span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = false
        mapView.showsBuildings = false
        mapView.showsCompass = true
        mapView.isRotateEnabled = false
        
        label.text = titleLabel
       
        
        addMainFloorAnnotations()
        addCurrentLocationAnnotation()
        addBottomSheetView()
        addOverlays()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapKitViewController.updateLocation), name: Notification.Name(rawValue: "jsa"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapKitViewController.updateLocation), name: Notification.Name(rawValue: "sharks"), object: nil)
        
        transparentNavigationBar(self)
        
        let mapCamera = MKMapCamera()
        
        mapView.setCamera(mapCamera, animated: false)
        
        
        self.zoomGalleryView.layer.cornerRadius = 5.0
        self.zoomedGalleryImage.layer.cornerRadius = 5.0
        self.zoomGalleryView.layer.shadowRadius = 5.0
        self.zoomGalleryView.layer.shadowColor = UIColor.white.cgColor
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
      locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingHeading()
        
        self.zoomGalleryView.isHidden = true
        
        self.zoomGalleryView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingHeading()
    }
    
    
    func addOverlays() {
    
//        let path = Bundle.main.path(forResource: "background", ofType: "png")
//        let fileURL = NSURL(fileURLWithPath: path!)
//        let colorOverlay = MKTileOverlay(urlTemplate: fileURL.absoluteString)
//        
//        
//        colorOverlay.canReplaceMapContent = true
//        
//        colorOverlay.tileSize = CGSize(width: 265, height: 265)
//       
//        mapView.add(colorOverlay)
        
        // MARK: -  Background Overlay
        let background = BackGroundOverlay(background: self.background)
        mapView.add(background, level: .aboveLabels)
        
        let firstFloorOverlay = AquariumMapOverlay(aquarium: aquarium)
        self.firstFloor = firstFloorOverlay
        
        let secondFloorOverlay = SecondFloorOverlay(aquarium: aquariumSecondFloor)
        self.secondFloor = secondFloorOverlay
        
        
        mapView.add(firstFloorOverlay)
        mapView.showsPointsOfInterest = false
        
    }
    
    
    func addMainFloorAnnotations() {
        let filePath = Bundle.main.path(forResource: "firstFloorExhibits", ofType: "plist")
        let exhibits = NSArray(contentsOfFile: filePath!)
        for exhibit in (exhibits as? [[String: AnyObject]])! {
            let point = CGPointFromString(exhibit["location"] as! String)
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
            let title = exhibit["name"] as! String
            let typeRawValue = Int((exhibit["type"] as! String))!
            let type = AnnotationTypes(rawValue: typeRawValue)!
            let subtitle = exhibit["subtitle"] as! String
            let firstFloorAnnotation = Annotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
            
            mapView.addAnnotation(firstFloorAnnotation)
            mapView.addAnnotation(self.currentLocationAnnotation)
            
        }
    }
    
    func addSecondFloorAnnotations() {
        let filePath = Bundle.main.path(forResource: "SecondFloorExhibits", ofType: "plist")
        let exhibits = NSArray(contentsOfFile: filePath!)
        
        for exhibit in (exhibits as? [[String: AnyObject]])! {
            let point = CGPointFromString(exhibit["location"] as! String)
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
            let title = exhibit["name"] as! String
            let typeRawValue = Int((exhibit["type"] as! String))!
            let type = AnnotationTypes(rawValue: typeRawValue)!
            let subtitle = exhibit["subtitle"] as! String
let secondFloorAnnotation = Annotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
            
            mapView.addAnnotation(secondFloorAnnotation)
            mapView.addAnnotation(self.currentLocationAnnotation)
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        
        ///// Sets Overlay and Overlay Image
        if overlay is AquariumMapOverlay {
            let overlayView = AquariumMapOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "mainFloor") )
            return overlayView
        }
        if overlay is SecondFloorOverlay {
            let overlayView = SecondFloorOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "secondFloor"))
            return overlayView
        }
        if overlay is BackGroundOverlay {
            let overlayView = BackgroundOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "background"))
            return overlayView
        }
            
        else if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.blue
            lineView.lineDashPattern = [1,5]
            lineView.lineDashPhase = 8.0
            lineView.lineWidth = 2.5
            
            return lineView

        }
        
        else if overlay is MKTileOverlay {
            let renderer = MKTileOverlayRenderer(overlay: overlay)
            renderer.alpha = 5.0
            return renderer
        }
        return MKOverlayRenderer()
    }
    
 
    
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let latDelta = aquarium.topLeftMapCoordinate.latitude + 0.0005 - aquarium.bottomRightMapCoordinate.latitude + 0.0005
        
        // 0.0003 sets correct zoom level when zoomed out bounce back
        
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        

        
            let mapContainsOverlay: Bool = MKMapRectContainsRect(mapView.visibleMapRect, aquarium.overlayBoundingMapRect)
            
            if mapContainsOverlay {
                
                let aquariumRegion: MKCoordinateRegion = MKCoordinateRegionMake(aquarium.midCoordinate, span)

                let widthRatio = aquarium.overlayBoundingMapRect.size.width / mapView.visibleMapRect.size.width
                let heightRatio = aquarium.overlayBoundingMapRect.size.height / mapView.visibleMapRect.size.height
                if (widthRatio < 5.0) || (heightRatio < 5.0) {
                    manuallyChangingMapRect = true
                    mapView.setRegion(aquariumRegion, animated: true)
                    manuallyChangingMapRect = false
                }
            } else if !MKMapRectIntersectsRect(aquarium.overlayBoundingMapRect, mapView.visibleMapRect) {
                mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
                let aquariumRegion: MKCoordinateRegion = MKCoordinateRegionMake(aquarium.midCoordinate, span)
                mapView.setRegion(aquariumRegion, animated: true)
        }
    }
    
    
    func addCurrentLocationAnnotation() {
        
        
        mapView.addAnnotation(self.currentLocationAnnotation)
        
        print("New Location Added")
    }
    
    func updateLocation() {
        
        print("Updating Location For \(CurrentLocationController.shared.exhibitName)")
        UIView.animate(withDuration: 1.5) {
            
            switch CurrentLocationController.shared.exhibitName {
            case "jsa":
                self.currentLocationAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(40.5321), longitude: CLLocationDegrees(-111.8934))
            case "sharks":
                self.currentLocationAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(40.5325), longitude: CLLocationDegrees(-111.8940))
                
            default: break
            }
        }
    }
    
    // MARK: - Zoom Gallery
    
    func zoomGallery() {
    
        
//        UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 0.50, initialSpringVelocity: 9.0, options: .allowUserInteraction, animations: {
//            
//            self.zoomGalleryView.isHidden = false
//            self.zoomGalleryView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//            self.mapView.alpha = 0.05
//        }, completion: nil)
//        
//        self.galleryZoomed = true
//        
//        if self.galleryZoomed == true {
//            self.mapView.isScrollEnabled = false
//        }
//        
    }
    
    func dismissZoomedGallery() {
//        UIView.animate(withDuration: 0.30, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 7.0, options: .allowUserInteraction, animations: {
//            
//            self.zoomGalleryView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
//            self.mapView.alpha = 1.0
//        }, completion: { (true) in
//            self.zoomGalleryView.isHidden = true
//        })
//        
//        self.galleryZoomed = false
//        
//        if self.galleryZoomed == false {
//            self.mapView.isScrollEnabled = true
//        }

    }
    

    @IBAction func dismissZoomGalleryButtonTapped(_ sender: Any) {
        
        dismissZoomedGallery()
        
           }
    
    
    
    func centerMap() {
        
        if mapView.selectedAnnotations.count > 0 {
      let annotation = mapView.selectedAnnotations[0]
        
        self.mapView.setCenter(annotation.coordinate, animated: true)
        }
    }
    
    
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //        if annotation is MKUserLocation {
        //            return nil
        //        }
        
        if annotation.isEqual(mapView.userLocation) {
            let userLocationAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation3")
            userLocationAnnotation.image = UIImage(named: "userLocation3")
            return userLocationAnnotation
        }
        else {
            
            
            
            let annotationView = AnnotationViews(annotation: annotation, reuseIdentifier: "Exhibit")
            
            
            annotationView.canShowCallout = true
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
        
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
        if let annotation = view.annotation {
            
            
//             Zoom To Selected Annotation
            let span = MKCoordinateSpanMake(0.0001, 0.0001)
            let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            if let title = annotation.title {
                if let newTitle = title {
                    self.titleLabel = newTitle
                }
            }
        }
        
        
        
        switch self.titleLabel {
        case "Discover Utah":
            postNotificationWithGalleryName(gallery: galleries.discoverUtah)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "mainFloorDU")
            zoomGallery()
            
        case "Journey to South America":
            postNotificationWithGalleryName(gallery: galleries.jsa)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "mainFloorJSA")
            zoomGallery()
            
        case "Gift Shop":
            postNotificationWithGalleryName(gallery: galleries.amenities)
            
        case "Banquet Hall":
            postNotificationWithGalleryName(gallery: galleries.banquetHall)
            
        case "Ocean Explorer":
            postNotificationWithGalleryName(gallery: galleries.oceanExplorer)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "mainFloorOE")
            zoomGallery()
            
        case "Antarctic Adventure":
            postNotificationWithGalleryName(gallery: galleries.antarcticAdventure)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "secondFloorAA")
            zoomGallery()
            
        case "Restrooms":
            postNotificationWithGalleryName(gallery: galleries.amenities)
            
        case "Jellyfish":
            postNotificationWithGalleryName(gallery: galleries.jellyFish)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "mainFloorAA")
            zoomGallery()
            
        case "Elevator":
            postNotificationWithGalleryName(gallery: galleries.amenities)
            
        case "Deep Sea Lab":
            postNotificationWithGalleryName(gallery: galleries.deepSeaLab)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "mainFloorAA")
            zoomGallery()
            
        case "40' Shark Tunnel":
            postNotificationWithGalleryName(gallery: galleries.oceanExplorer)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "mainFloorOE")
            zoomGallery()
            
        case "4D Theater":
            postNotificationWithGalleryName(gallery: galleries.theater)
            
        case "Expedition Asia":
            postNotificationWithGalleryName(gallery: galleries.expeditionAsia)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "secondFloorAsia")
            zoomGallery()
            
        case "Tuki's Island":
            postNotificationWithGalleryName(gallery: galleries.tukis)
            
        case "Education Center":
            postNotificationWithGalleryName(gallery: galleries.educationCenter)
            
        case "Journey to South America - Aviary":
            postNotificationWithGalleryName(gallery: galleries.jsa)
            self.zoomedGalleryImage.image = #imageLiteral(resourceName: "secondFloorJSA")
            zoomGallery()

        case "Cafe":
            postNotificationWithGalleryName(gallery: galleries.amenities)
            
        case "Mother's Room":
            postNotificationWithGalleryName(gallery: galleries.amenities)
        default:
            break
        }
    }
    
    
    func postNotificationWithGalleryName(gallery: MapGalleries) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: gallery.name), object: self)
        
    }
    
    
    // MARK: - Segmented Control
    
    @IBAction func mapTypeChanged(Sender: AnyObject) {
        
       switchFloors()
        
    }
    
    
    func switchFloors() {
        
         // changes floor image
        if self.selectedFloor.selectedSegmentIndex == 0 {
            
            mapView.remove(self.secondFloor!)
            mapView.add(self.firstFloor!)
            
            mapView.removeAnnotations(mapView.annotations)
            addMainFloorAnnotations()
            
        } else if self.selectedFloor.selectedSegmentIndex == 1 {
            
            mapView.remove(self.firstFloor!)
            mapView.add(self.secondFloor!)
            
            mapView.removeAnnotations(mapView.annotations)
            addSecondFloorAnnotations()
            
        }
        }
    
    
    @IBAction func tapDismiss(_ sender: AnyObject) {
        
        dismissZoomedGallery()
        
    }
    
    
    func addBottomSheetView() {
        
        // Sets child view as storyboard file to enable storyboard editing
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
        
        // adds storyboard file as child view
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        controller.delegate = self
        
        let height = view.frame.height
        let width = view.frame.width
        
        controller.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
        
    }
    
    func selectRestroomAnnotation() {
        var ann = mapView.annotations[0]
        
        for annotation in mapView.annotations {
            
            if let title = annotation.title {
                if title == "Restrooms" {
                    ann = annotation
                }
            }
        }
        
        mapView.selectAnnotation(ann, animated: true)
        
    }
    
    func selectCafeAnnotation() {
        if self.selectedFloor.selectedSegmentIndex == 0 {
        var ann = mapView.annotations[0]
        
        for annotation in mapView.annotations {
            
            if let title = annotation.title {
                if title == "Cafe" {
                    ann = annotation
                }
            }
        }
        
        mapView.selectAnnotation(ann, animated: true)
        
        } else {
            self.selectedFloor.selectedSegmentIndex = 0
            switchFloors()
            var ann = mapView.annotations[0]
            
            for annotation in mapView.annotations {
                
                if let title = annotation.title {
                    if title == "Cafe" {
                        ann = annotation
                    }
                }
            }
            
            mapView.selectAnnotation(ann, animated: true)
            

        }
    }
    
    func selectGiftShopAnnotation() {
        if self.selectedFloor.selectedSegmentIndex == 0 {
        var ann = mapView.annotations[0]
        
        for annotation in mapView.annotations {
            
            if let title = annotation.title {
                if title == "Gift Shop" {
                    ann = annotation
                }
            }
        }
    
        
        mapView.selectAnnotation(ann, animated: true)
        
        } else {
            self.selectedFloor.selectedSegmentIndex = 0
            switchFloors()
            
            var ann = mapView.annotations[0]
            
            for annotation in mapView.annotations {
                
                if let title = annotation.title {
                    if title == "Gift Shop" {
                        ann = annotation
                    }
                }
            }
            mapView.selectAnnotation(ann, animated: true)
        }
}
    
    // MARK: Quick Icons
    
    @IBAction func restroomButtonTapped(_ sender: Any) {
        selectRestroomAnnotation()
    }
    
    @IBAction func cafeButtonTapped(_ sender: Any) {
        selectCafeAnnotation()
    }
    
    @IBAction func giftshopButtonTapped(_ sender: Any) {
        selectGiftShopAnnotation()
    }
    
    
    // MARK: Compass Button
    @IBAction func compassModeButtonTapped(_ sender: Any) {
        
        
        
        switch self.trackingType {
        case TrackingTypes.map.rawValue:
            self.trackingSwitch = 2
            self.trackingType = TrackingTypes.user.rawValue
        UIView.animate(withDuration: 0.3, animations: { 
            self.mapView.transform = CGAffineTransform.identity
            self.compassButton.setImage(#imageLiteral(resourceName: "compass"), for: .normal)
        })
        case TrackingTypes.user.rawValue:
            self.trackingSwitch = 1
            self.trackingType = TrackingTypes.map.rawValue
            self.compassButton.setImage(#imageLiteral(resourceName: "compassFilled"), for: .normal)
        default: break
    }

}
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
           let userRotation = newHeading.magneticHeading * .pi / 180
        let mapRotation = newHeading.magneticHeading * .pi / 180
     
        if self.trackingType == TrackingTypes.user.rawValue {
            for anotation in self.mapView.annotations {
                if let title = anotation.title {
                    if title == "Current Location" {
                        let view = mapView.view(for: anotation)
                        UIView.animate(withDuration: 0.3, animations: { 
                            view?.transform = CGAffineTransform(rotationAngle: (CGFloat)(userRotation))

                        })
                    }
                }
            }
        }
                
        if self.trackingType == TrackingTypes.map.rawValue {
            UIView.animate(withDuration: 0.3, animations: { 
                self.mapView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(mapRotation))
                for anotation in self.mapView.annotations {
                    if let title = anotation.title {
                        if title == "Current Location" {
                            let view = self.mapView.view(for: anotation)
                            UIView.animate(withDuration: 0.3, animations: {
                                view?.transform = CGAffineTransform(rotationAngle: (CGFloat)(userRotation))
                                
                            })
                        }
                    }
                }


            })
        }
    }
    

    
    func getDirectionsButtonTapped(_ bottomSheetViewController: BottomSheetViewController) {
        
        bottomSheetViewController.delegate = self
        
        
            // Sets MKPolyLine Based off of Plist Coordinate Map
        
//        let thePath = Bundle.main.path(forResource: "EntranceToSharksRoute", ofType: "plist")
//        let pointsArray = NSArray(contentsOfFile: thePath!)
//        
//        let pointsCount = pointsArray!.count
//        
//        var pointsToUse: [CLLocationCoordinate2D] = []
//        
//        for point in 0...pointsCount - 1 {
//            let p = CGPointFromString(pointsArray![point] as! String)
//            pointsToUse += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]
//        }
//        
//        let routeLine = MKPolyline(coordinates: &pointsToUse, count: pointsCount)
//        
//        self.route = routeLine
//        clearDirectionsButton.isHidden = false
//        
//        UIView.animate(withDuration: 5.0, animations: {
//            self.mapView.add(self.route!)
//        })
    }
    
    
  }
