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

class CreateTripViewController: UIViewController, UITextFieldDelegate {
    var selectDate = Date()
    var delegate: DatePickerViewDelegate?
    var fields: [String] = []
    
    @IBAction func destinationTextTriggered(_ sender: Any) {
        print("return text field entered")
    }
    @IBOutlet weak var childNameTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var pickupDropoffSegmentedView: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var date: String?
    
    
    @IBAction func onDestinationTextField(_ sender: UITextField) {
        }
    
    
    
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
        datePicker.date = selectDate
        
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = selectDate
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapVC = segue.destination as? MapViewController, let mapView = sender as? UITextField {
            mapVC.textfield = mapView
        }
    }
    
    
}


