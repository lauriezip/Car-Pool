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
           //mapVC.textfield = mapView
        }
    }
    
    var selectedMapItem: MKMapItem?
    var mapItems: [MKMapItem] = []
    var location = CLLocation()
    let locationManager = CLLocationManager()
    var selectedDate = Date()
    var locationSelected: [MKMapItem] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        datePicker.minimumDate = Date()
        self.locationManager.requestAlwaysAuthorization()
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
    
    
    @IBAction func onDatePicked(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    
    @IBAction func onConfirmedPressed(_ sender: UIButton) {
        createTrip()
    }
    
    
    @IBAction func onShowMapViewButtonPressed(_ sender: UIButton) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapViewController
        mapVC.accessibilityActivate()
        mapVC.selectedMapItem = selectedMapItem
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
    
    @IBAction func unwindFromResultsVC(segue: UIStoryboardSegue) {
        selectedMapItem = (segue.source as! ResultsViewController).selectedMapItem
        locationTextField.text = selectedMapItem?.name
    }
    
    
    func createTrip() {
        let event = eventTitleTextField.text
        if (event?.isEmpty)!  {
            API.addChild(name: childrenTextField.text!, completion: { (result) in
              print(result)
          })
            
//            if desc != ""{
//                API.createTrip(eventDescription: desc, eventTime: time, eventLocation: locationFromMap) { result in
//                    switch result {
//                    case .success(let trip):
//                        if let child = self.child {
//                            do {
//                                try API.add(child: child, to: trip)
//                                self.performSegue(withIdentifier: "unwindCreateTrip", sender: self)
//                            } catch {
//                                //Error Handling
//                            }
//                        }
//                    case .failure(_):
//                        //Error Handling
//                    }
//                }
//            }
            
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




