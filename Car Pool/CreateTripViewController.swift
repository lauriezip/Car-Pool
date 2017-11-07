//
//  CreateTripViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var onDatePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func createTrip(_ trip: Trip){
        let ref = Database.database().reference().child("trips").childByAutoId()
        ref.updateChildValues(trip.asDictionary) { (error, ref) in
            //print(error, ref)
            self.performSegue(withIdentifier: "TripDetailVCUnwind", sender: self)
        }
    }
    
}
