//
//  CreateTripViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit
import MapKit
import PromiseKit

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var eventTitleTextField: UITextField!
    
    @IBOutlet weak var childrenTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var showMapViewButton: UIButton!
    
    @IBOutlet weak var pickupDropoffSegmentedControll: UISegmentedControl!
    
    let trips: [Trip] = []
    var eventDescription: String?
    var location = CLLocation()
    let locationManager = CLLocationManager()
    var locationSelected: [MKMapItem] = []
    var selectedDate = Date()
    var selectedMapItem: MKMapItem?
    var mapItems: [MKMapItem] = []
    var child: Child?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
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
    
    
    @IBAction func onLocationTextEntered(_ sender: UITextField) {
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
    
    
    //TODO: Add @IBAction for childrenTextField (onChildrenTextEntered)
    
    @IBAction func onDatePicked(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    //TODO: Add @IBAction for locationTextField (onLocationTextEntered)
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        if eventDescription != ""{
            API.createTrip(eventDescription: description, eventTime: datePicker.date, eventLocation: location) { result in
                switch result {
                case .success(let trip):
                    if let child = self.child {
                        do {
                            try API.add(child: child, to: trip)
                            self.performSegue(withIdentifier: "unwindCreateTrip", sender: self)
                        } catch {
                            print("Child Not Added")
                        }
                    }
                case .failure(_):
                    print("Trip unsuccessfully created")
                }
            }
        }
    }
    
    
    @IBAction func onShowMapViewButtonPressed(_ sender: UIButton) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewSegue") as! MapViewController
        mapVC.accessibilityActivate()
        mapVC.selectedMapItem = selectedMapItem
    }
    
    //     API.createTrip(eventDescription: eventTitleTextField!, eventTime: datePicker.date, eventLocation: location) { (result) in
    
    func createTrip() {
        if eventTitleTextField.text != nil {
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
                        API.addChild(name: self.childrenTextField.text!, completion: { (result) in
                            switch result {
                            case .success(let child):
                                print(child)
                            case .failure(let error):
                                print(error)
                            }
                        })
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let  ResultsTableVC = segue.destination as? ResultsViewController {
            ResultsTableVC.mapItems = mapItems
        }
        if let mapVC = segue.destination as? MapViewController {
           mapVC.selectedMapItem = selectedMapItem
        }
    }
    
    @IBAction func unwindFromLocationsTableVC(segue: UIStoryboardSegue) {
        selectedMapItem = (segue.source as! ResultsViewController).selectedMapItem
        locationTextField.text = selectedMapItem?.name
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
        guard status == .authorizedWhenInUse else { return }
        //mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}



