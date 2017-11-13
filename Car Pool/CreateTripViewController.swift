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
        locationManager.delegate = self as? CLLocationManagerDelegate //as! CLLocationManagerDelegate
      
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
//            self.performSegue(withIdentifier: "SegueToLocationsTableVC", sender: self)
        }
    }
    
    
    @IBAction func onDatePicked(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        createTrip()
    }
    
    
    @IBAction func onShowMapViewButtonPressed(_ sender: UIButton) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapView") as! MapViewController
       // mapVC.mapView = mapView
          mapVC.accessibilityActivate()
      //  mapVC.selectedMapItem = selectedMapItem
    }
    
    
    
    func createTrip() {
        if eventTitleTextField.text != nil {
            API.addChild(name: childrenTextField.text!, completion: { (result) in
                print(result)
            })
            API.createTrip(eventDescription: eventTitleTextField.text!, eventTime: datePicker.date, eventLocation: location) { (trip) in
                print(trip)
                
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
        guard status == .authorizedWhenInUse else { return }
        //mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}




