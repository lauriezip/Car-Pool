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

protocol DatePickerViewDelegate {
    func cancelPressed()
    func donePressed()
}

class CreateTripViewController: UIViewController{
    
    var delegate: DatePickerViewDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date: String?
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        delegate?.cancelPressed()
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let strDate = dateFormatter.string(from: self.datePicker.date)
        date = strDate
        delegate?.donePressed()
        
    }
    
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    var selectDate = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        API.createTrip(eventDescription: <#T##String#>, eventTime: <#T##Date#>, eventLocation: <#T##CLLocation#>, completion: <#T##(Result<Trip>) -> Void#>)
//    }
//
    }
}


