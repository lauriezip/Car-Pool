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
    var labelText: String?
    var firstVCtext = ""
    var trip: Trip!
    
    
    @IBOutlet weak var eventInfoLabel: UILabel!
    
    @IBOutlet weak var eventInfo1Label: UILabel!
    
    @IBOutlet weak var eventInfo2Label: UILabel!
    
    @IBOutlet weak var eventInfo4Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventInfoLabel.text = trip.event.description
        eventInfo1Label.text = trip.dropOff?.driver.name
        eventInfo2Label.text = trip.pickUp?.driver.name
        eventInfoLabel.text = trip.event.key
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createAlert(title: "Would you like to claim this?", message: "")
    }
 
    func createAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("YES")
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("NO")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
        


}

class Rider{
    
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var email = ""
    var password = ""
    var picture = ""
    //let uid: String
    
    // Initialize from Firebase(test)
//    init(authData: FAuth) {
//        //  uid = authData.uid
//        email = authData.providerData["email"] as! String
//        password = authData.providerData["provider"] as! String
//    }
    init(uidAddress: String)
    {
        //self.uid = uidAddress
    }
    
    init(firstName:String, lastName:String, phoneNumber:String, email:String, password:String, picture: String)//, uid: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.picture = picture
        // self.uid = uid
    }
    
}

class Trips{
    var driver:Rider?
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var email = ""
    var fromStreetAddress = ""
    var toStreetAddress = ""
    var pickUpTime = ""
    var notes = ""
    var postedTime = ""
    var capacity = ""
    var startingCapacity = ""
    var riders:[Rider]?
    var postId = ""
    
    init(rider:Rider, fromStreetAddress:String, toStreetAddress:String, pickUpTime: String, notes:String, postedTime: String, capacity: String, startingCapacity:String, postId:String)
    {
        self.driver = rider
        self.firstName = rider.firstName
        self.lastName = rider.lastName
        self.phoneNumber = rider.phoneNumber
        self.email = rider.email
        self.fromStreetAddress = fromStreetAddress
        
        self.toStreetAddress = toStreetAddress
        self.postedTime = postedTime
        self.pickUpTime = pickUpTime
        self.capacity = capacity
        self.startingCapacity = startingCapacity
        self.notes = notes
        self.postId = postId
        
    }
    
    func addRider(rider:Rider){
        self.riders?.append(rider)
    }
}
