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
    
    
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventInfoLabel.text = labelText

        }
    
    
//    func onEventsDescription() {
//        if let trip = trips {
//            
//        }
//    }
    
}
