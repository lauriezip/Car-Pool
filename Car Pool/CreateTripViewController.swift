//
//  CreateTripViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit



class CreateTripViewController: UIViewController{
    
    //    let datePicker: UDatePicker?
    //
    //    // ...
    //
    //    func showDatePicker() {
    //        if datePicker == nil {
    //            datePicker = datePicker(frame: view.frame, willDisappear: { date in
    //                if date != nil {
    //                    print("select date \(date)")
    //                }
    //            })
    //        }
    //
    //        datePicker.picker.date = NSDate()
    //        datePicker?.present(self)
    //    }
    
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    var selectDate = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.date = selectDate
        
        //        API.createTrip(eventDescription: String, eventTime: Date, eventLocation: CLLocation, completion: @escaping (Trip) -> Void)
    }
    
    @IBAction func onDatePickerButton(_ sender: Any) {
        let secondsSinceOriginDate = Date().timeIntervalSince(datePickerView.minimumDate!)
        let day = arc4random_uniform(UInt32(secondsSinceOriginDate / 60 / 60 / 24))+1
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -Int(day - 1)
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        datePickerView.date = randomDate!
        
    }
    
    func createTrip (eventDescription: String, eventTime: Date, eventLocation: CLLocation, completion: @escaping (Trip) -> Void) {
        
        let event = Event(id: UUID().uuidString, description: eventDescription, time: eventTime, location: eventLocation)
        let leg1 = Leg(id: UUID().uuidString, driver: User.current)
        let leg2 = Leg(id: UUID().uuidString, driver: nil)
        let trip = Trip(id: UUID().uuidString, event: event, pickUp: leg1, dropOff: leg2)
        fakeTrips.insert(trip, at: 0)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                completion(trip)
            }
            
        }
    }
    
    
}


