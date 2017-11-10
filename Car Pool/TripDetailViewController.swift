//
//  EventDetailViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit
import FirebaseCommunity


class TripDetailViewController: UIViewController {
    var labelText: String?
    var firstVCtext = ""
    var event: Event?
    var eventDict: [String: Any] = [:]
    var trip: Trip!
    
    
    @IBOutlet weak var eventInfoLabel: UILabel!
    
    @IBOutlet weak var eventInfo1Label: UILabel!
    
    @IBOutlet weak var eventInfo2Label: UILabel!
    
    @IBOutlet weak var eventInfo4Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          showTripDetails()
        
        
        eventInfoLabel.text = trip.event.description
        eventInfo1Label.text = trip.dropOff?.driver.name
        eventInfo2Label.text = trip.pickUp?.driver.name
        eventInfo4Label.text = trip.event.key
        
    }
    
   
    func showTripDetails() {
        if let trip = trip {
            eventInfoLabel.text = trip.event.description
            eventInfo1Label.text = trip.dropOff?.driver.name
            eventInfo2Label.text = trip.pickUp?.driver.name
            eventInfo4Label.text = trip.event.key
        }
    
    }
    
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        claimAlertAction()
    }
    
    
    func claimAlertAction() {
        
        let claimAlertAction = UIAlertController(title: "Claim Trip", message: "Would you like to claim this trip ?", preferredStyle: .alert)
        claimAlertAction.addAction (UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        claimAlertAction.addAction (UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {
            (UIAlertController) -> Void in
            print ("handle Claim action...")
            self.present(claimAlertAction, animated: true, completion: nil);
        })
        )
    }
}
