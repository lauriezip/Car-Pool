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
    
    
    @IBOutlet weak var pickupDriverLabel: UILabel!
    
    
    @IBOutlet weak var dropoffDriverLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var claimPickupButton: UIButton!
    
    @IBOutlet weak var claimDropoffButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = trip.event.description
        showTripDetails()
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: “bg.png”)
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    func showTripDetails() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, YYYY h:mm a"
        dropoffDriverLabel.text = "Drop off driver: " + (trip.dropOff?.driver.name ?? "Unclaimed")
        dateLabel.text = "Date/time: " + formatter.string(from: trip.event.time)
        pickupDriverLabel.text = "Pick up driver: " + (trip.pickUp?.driver.name ?? "Unclaimed")
        
        
        if pickupDriverLabel.text == "PickUp Driver: Unclaimed" {
            claimPickupButton.backgroundColor = UIColor.red
        } else {
            claimPickupButton.backgroundColor = UIColor.white
        }
        
        if dropoffDriverLabel.text == "DropOff Driver: Unclaimed" {
            claimDropoffButton.backgroundColor = UIColor.red
        } else {
            claimDropoffButton.backgroundColor = UIColor.white
        }
    }
    
    
    @IBAction func onClaimPickupPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Are you claiming pickup?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.claimPickUp(trip: self.trip) { (error) in
                print("claim pickup error")
            }
        }))
        alert.addAction(UIAlertAction(title: "UnClaim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.unclaimPickUp(trip: self.trip, completion: { (error) in
                print("unclaim pickup error")
            })
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onClaimDropoffPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Are you claiming dropoff?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimDropoffButton.backgroundColor = UIColor.white
            API.claimDropOff(trip: self.trip) { (error) in
                print("claim dropoff error")
            }
        }))
        alert.addAction(UIAlertAction(title: "UnClaim", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.claimPickupButton.backgroundColor = UIColor.white
            API.unclaimDropOff(trip: self.trip, completion: { (error) in
                print("unclaim dropoff error")
            })
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}






