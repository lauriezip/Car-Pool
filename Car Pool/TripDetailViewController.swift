//
//  EventDetailViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit

class TripDetailViewController: UIViewController {
    var trip: Trip!
    var labelText: String?
    var firstVCtext = ""
    
    
    
    @IBOutlet weak var eventInfoLabel: UILabel!
    
    @IBOutlet weak var eventInfo1Label: UILabel!
    
    @IBOutlet weak var eventInfo2Label: UILabel!
    
    @IBOutlet weak var eventInfo3Label: UILabel!
    
    @IBOutlet weak var eventInfo4Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventInfoLabel.text = trip.event.description
        eventInfo1Label.text = trip.dropOff?.driver?.name
        eventInfo2Label.text = trip.pickUp?.driver?.name

    }
 
    func showTripDetails() {
        
    }
   
}
