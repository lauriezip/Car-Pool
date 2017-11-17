//
//  MapViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/8/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,UISearchControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var selectedMapItem: MKMapItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            locationManager.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        let region = MKCoordinateRegionMakeWithDistance(selectedMapItem!.coordinate, 10000, 10000)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(selectedMapItem!)
    }

    
//    @IBAction func onDirectionsPressed(_ sender: UIBarButtonItem) {
//        let longitude = selectedMapItem?.placemark.coordinate.longitude
//        let latitude = selectedMapItem?.placemark.coordinate.latitude
//        let regionDistance: CLLocationDistance = 10000
//        let coordinates = CLLocationCoordinate2DMake(latitude!, longitude!)
//        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
//        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "Place Name"
//        mapItem.openInMaps(launchOptions: options)
//
//}
    
    func search(for query: String) {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let response = response {
                //                print(response.mapItems)
                self.mapView.addAnnotations(response.mapItems)
                for mapItem in response.mapItems{
                    print(mapItem.placemark.title!, mapItem.placemark.subtitle) // as Any
                    self.mapView.addAnnotation(mapItem.placemark)
                }
            }
        }
    }
    
    func search() {
        self.mapView.addAnnotation((self.selectedMapItem?.placemark)!)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
    }
}
extension MKMapItem: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return placemark.coordinate
    }
    public var title: String? {
        return name
    }
    public var subtitle: String? {
        return phoneNumber
    }
}

