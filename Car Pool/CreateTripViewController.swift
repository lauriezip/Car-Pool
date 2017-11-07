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
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    var selectDate = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.date = selectDate
        
//        API.createTrip(eventDescription: <#T##String#>, eventTime: <#T##Date#>, eventLocation: <#T##CLLocation#>, completion: <#T##(Result<Trip>) -> Void#>)
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
    
}
