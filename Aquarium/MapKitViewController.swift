//
//  MapKitViewController.swift
//  Aquarium
//
//  Created by Forrest Syrett on 11/5/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import MapKit



class MapKitViewController: UIViewController, MKMapViewDelegate, BottomSheetViewControllerDelegate {
    
    
    static let shared = MapKitViewController()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var selectedFloor: UISegmentedControl!
    
    
    
    let galleries = MapGalleryController.sharedController
    let bottomSheetViewController = BottomSheetViewController()
    
    var aquarium = AquariumMap(filename: "Aquarium")
    var floorImage = UIImage(named: "mainFloor")
    var delta = 0.0
    var selectedPin: MKPlacemark? = nil
    var titleLabel: String = "Tap on a gallery to learn more!"
    var label = UILabel(frame: CGRect(x: 16, y: 20, width: 343, height: 21))
    var currentLocationAnnotation = Annotation(coordinate: CurrentLocationController.shared.coordinate, title: "Current Location", subtitle: "", type: AnnotationTypes.CurrentLocation)
    
    @IBOutlet weak var clearDirectionsButton: UIButton!
    
    var route: MKPolyline? = nil
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomSheetViewController.delegate = self
        
        currentLocationAnnotation.coordinate = CurrentLocationController.shared.coordinate
        
        mapView.mapType = .satellite
        gradient(self.view)
        
        
        let latDelta = aquarium.topLeftMapCoordinate.latitude + 0.0009 - aquarium.bottomRightMapCoordinate.latitude + 0.0009
        
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        self.delta = latDelta
        
        let region = MKCoordinateRegionMake(aquarium.midCoordinate, span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = false
        mapView.showsBuildings = false
        mapView.showsCompass = true
        label.text = titleLabel
        clearDirectionsButton.isHidden = true
        
        addAnnotations()
        addCurrentLocationAnnotation()
        addBottomSheetView()
        addOverlays()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapKitViewController.updateLocation), name: Notification.Name(rawValue: "jsa"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapKitViewController.updateLocation), name: Notification.Name(rawValue: "sharks"), object: nil)
        
    }
    
    
    
    
    
    
    
    
    func addOverlays() {
        
        let worldRect = MKMapRectWorld
        let point1 = MKMapRectWorld.origin
        let point2 = MKMapPointMake(point1.x + worldRect.size.width, point1.y)
        let point3 = MKMapPointMake(point2.x, point2.y + worldRect.size.height)
        let point4 = MKMapPointMake(point1.x, point3.y)
        var points = [point1, point2, point3, point4]
        let polygon = MKPolygon(points: &points, count: points.count)
        mapView.add(polygon)
        
        let overlay = AquariumMapOverlay(aquarium: aquarium)
        mapView.add(overlay)
        mapView.showsPointsOfInterest = false
        
    }
    
    
    func addAnnotations() {
        let filePath = Bundle.main.path(forResource: "aquariumExhibits", ofType: "plist")
        let exhibits = NSArray(contentsOfFile: filePath!)
        for exhibit in (exhibits as? [[String: AnyObject]])! {
            let point = CGPointFromString(exhibit["location"] as! String)
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
            let title = exhibit["name"] as! String
            let typeRawValue = Int((exhibit["type"] as! String))!
            let type = AnnotationTypes(rawValue: typeRawValue)!
            let subtitle = exhibit["subtitle"] as! String
            let annotation = Annotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
            
            mapView.addAnnotation(annotation)
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is AquariumMapOverlay {
            let overlayView = AquariumMapOverlayView(overlay: overlay, overlayImage: self.floorImage!)
            return overlayView
        }
        else if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.blue
            lineView.lineDashPattern = [1,5]
            //            lineView.miterLimit = 1.0
            lineView.lineDashPhase = 8.0
            lineView.lineWidth = 2.5
            
            return lineView
        }
        return MKOverlayRenderer()
    }
    
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let latDelta = aquarium.topLeftMapCoordinate.latitude + 0.0007 - aquarium.bottomRightMapCoordinate.latitude + 0.0007
        
        // 0.0003 sets correct zoom level when zoomed out bounce back
        
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        
        if ((mapView.region.span.latitudeDelta > aquarium.topLeftMapCoordinate.latitude + 0.0005 - aquarium.bottomRightMapCoordinate.latitude + 0.0005 )) {
            
            let aquariumRegion: MKCoordinateRegion = MKCoordinateRegionMake(aquarium.midCoordinate, span);
            mapView.setRegion(aquariumRegion, animated: true);
            
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
            if let title = annotation.title {
                if let newTitle = title {
                    print("\(newTitle)")
                    self.titleLabel = newTitle
                }
            }
        }
        
        
        switch self.titleLabel {
        case "Discover Utah":
            postNotificationWithGalleryName(gallery: galleries.discoverUtah)
            
        case "Journey to South America":
            postNotificationWithGalleryName(gallery: galleries.jsa)
            
        case "Gift Shop":
            postNotificationWithGalleryName(gallery: galleries.amenities)
            
        case "Banquet Hall":
            postNotificationWithGalleryName(gallery: galleries.banquetHall)
            
        case "Ocean Explorer":
            postNotificationWithGalleryName(gallery: galleries.oceanExplorer)
            
        case "Antarctic Adventure":
            postNotificationWithGalleryName(gallery: galleries.antarcticAdventure)
            
        case "Restrooms":
            postNotificationWithGalleryName(gallery: galleries.amenities)
            
        case "Jellyfish":
            postNotificationWithGalleryName(gallery: galleries.antarcticAdventure)
            
        case "Elevator":
            postNotificationWithGalleryName(gallery: galleries.amenities)
            
        case "Deep Sea Lab":
            postNotificationWithGalleryName(gallery: galleries.antarcticAdventure)
            
        case "40' Shark Tunnel":
            postNotificationWithGalleryName(gallery: galleries.oceanExplorer)
        default:
            break
        }
    }
    
    
    func postNotificationWithGalleryName(gallery: MapGalleries) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: gallery.name), object: self)
        
    }
    
    
    
    @IBAction func mapTypeChanged(Sender: AnyObject) {
        
        // changes floor image
        
        if self.selectedFloor.selectedSegmentIndex == 0 {
            
            
            
        } else if self.selectedFloor.selectedSegmentIndex == 1 {
            self.floorImage = #imageLiteral(resourceName: "secondFloor")
            
        }
        
    }
    
    
    @IBAction func tapDismiss(_ sender: AnyObject) {
        
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
    
    
    
    func getDirectionsButtonTapped(_ bottomSheetViewController: BottomSheetViewController) {
        
        bottomSheetViewController.delegate = self
        
        print("Delegate Heard")
        
        let thePath = Bundle.main.path(forResource: "EntranceToSharksRoute", ofType: "plist")
        let pointsArray = NSArray(contentsOfFile: thePath!)
        
        let pointsCount = pointsArray!.count
        
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for point in 0...pointsCount - 1 {
            let p = CGPointFromString(pointsArray![point] as! String)
            pointsToUse += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]
        }
        
        let routeLine = MKPolyline(coordinates: &pointsToUse, count: pointsCount)
        
        self.route = routeLine
        clearDirectionsButton.isHidden = false
        
        UIView.animate(withDuration: 5.0, animations: {
            self.mapView.add(self.route!)
        })
    }
    
    
    @IBAction func clearDirectionsButtonTapped(_ sender: Any) {
        
        mapView.remove(self.route!)
        clearDirectionsButton.isHidden = true
        
        
    }
    
}
