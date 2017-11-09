//
//  test.swift
//  Car Pool
//
//  Created by joshua dodd on 11/9/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager! = nil
    var currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    @IBOutlet var mapView : MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        showUserLocation(sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Showing the user location
    func showUserLocation(sender : AnyObject) {
        let status = CLLocationManager.authorizationStatus()
        
        //Asking for authorization to display current location
        if status == CLAuthorizationStatus.notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    // User authorized to show his current location
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        // Getting the user coordinates
        currentLocation = newLocation.coordinate
        
        // Setting the zoom region
        let zoomRegion : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(currentLocation, 500, 500)
        
        // Zoom the map to the current user location
        mapView!.setRegion(zoomRegion, animated: true)
    }
    
    
    // User changed the authorization to use location
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // Request user authorization
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Error locating the user
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // Printing the error to the logs
        print("Error locating the user: \(error)")
    }
    
    
    @IBAction func dropPinInCurrentLocation(sender: AnyObject) {
        // Creating new annotation (pin)
        let currentAnnotation : MKPointAnnotation = MKPointAnnotation()
        
        // Annotation coordinates
        currentAnnotation.coordinate = currentLocation
        
        // Annotation title
        currentAnnotation.title = "Your Are Here!"
        
        // Adding the annotation to the map
        mapView!.addAnnotation(currentAnnotation)
        
        // Displaying the pin title on drop
        mapView!.selectAnnotation(currentAnnotation, animated: true)
    }
}
