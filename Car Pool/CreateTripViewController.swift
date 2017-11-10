//
//  CreateTripViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit
import FirebaseCommunity
import PromiseKit
import CoreLocation

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //datePickerView.date = selectDate
      
    }
    
    @IBAction func onDatePickerButton(_ sender: Any) {
        let secondsSinceOriginDate = Date().timeIntervalSince(datePicker.minimumDate!)
        let day = arc4random_uniform(UInt32(secondsSinceOriginDate / 60 / 60 / 24))+1
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -Int(day - 1)
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        datePicker.date = randomDate!
        
    }
    
//    func createTrip(eventDescription: String, eventTime: Date, eventLocation: CLLocation?, completion: @escaping (Trip) -> Void) {
   
        }



