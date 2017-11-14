//
//  CreateTripViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import MapKit
import CarpoolKit

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var eventTitleTextField: UITextField!
    
    @IBOutlet weak var childrenTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var showMapViewButton: UIButton!
    
    @IBOutlet weak var pickupDropoffSegmentedControll: UISegmentedControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapVC = segue.destination as? MapViewController, let mapView = sender as? UITextField {
//            mapVC.textfield = mapView
        }
    }
    
    var location = CLLocation()
    let locationManager = CLLocationManager()
    var locationSelected: [MKMapItem] = []
    var selectedDate = Date()
    var mapItems: [MKMapItem] = []
    var selectedMapItem: MKMapItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        datePicker.minimumDate = Date()
//        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
////            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
        
            locationManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        datePicker.setDate(selectedDate, animated: true)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    @IBAction func onLocationTextFieldPressed(_ sender: UITextField) {
        if locationTextField.text != nil {
            search(for: locationTextField.text!)
        }
    }
    
    func search(for query: String) {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else { return }
            print(response.mapItems)
            self.mapItems = response.mapItems
            self.performSegue(withIdentifier: "SegueToResultsTableVC", sender: self)
        }
    }
    
    
    @IBAction func onDatePicked(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        createTrip()
    }
    
    
    @IBAction func onShowMapViewButtonPressed(_ sender: UIButton) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewSegue") as! MapViewController
        mapVC.accessibilityActivate()
        mapVC.selectedMapItem = selectedMapItem
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: (Any?) {
//        if let locationsTableVC = segue.destination as? ResultsViewController {
//            locationsTableVC.mapItems = mapItems
//        }
//        if let mapVC = segue.destination as? MapViewController {
//            mapVC.selectedMapItem = selectedMapItem
//        }
//    }
    
    
    func createTrip() {
        let event = eventTitleTextField.text
        if (event?.isEmpty)!  {
            API.addChild(name: childrenTextField.text!, completion: { (result) in
                print(result)
            })
            
            if let selectedMapItem = selectedMapItem {
                
                let latitude = selectedMapItem.coordinate.latitude
                let longitude = selectedMapItem.coordinate.longitude
                let location = CLLocation(latitude: latitude, longitude: longitude)
                
                API.createTrip(eventDescription: eventTitleTextField.text!, eventTime: datePicker.date, eventLocation: location) { (result) in
                    print(result)
                    
                    switch result {
                    case .success(let createTrip):
                        if self.pickupDropoffSegmentedControll.selectedSegmentIndex == 0 {
                            API.claimDropOff(trip: createTrip, completion: { (error) in
                                print(error!)
                            })
                        } else if self.pickupDropoffSegmentedControll.selectedSegmentIndex == 1 {
                            API.claimPickUp(trip: createTrip, completion: { (error) in
                                print(error!)
                            })
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

extension CreateTripViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension CreateTripViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedAlways else { return }
        locationManager.requestLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}




