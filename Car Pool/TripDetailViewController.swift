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
import PromiseKit

class TripDetailViewController: UIViewController {
    var labelText: String?
    var firstVCtext = ""
    
    
    
    @IBOutlet weak var eventInfoLabel: UILabel!
    
    @IBOutlet weak var eventInfo1Label: UILabel!
    
    @IBOutlet weak var eventInfo2Label: UILabel!
    
    @IBOutlet weak var eventInfo4Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventInfoLabel.text = labelText
        
        
    }
 
    func showTripDetails() {
        let userId = Auth.auth().currentUser?.uid
        let eventRef = Database.database().reference().child("events").childByAutoId()
//        eventRef.observe(of: .value, with: { (snapshot) in
//        let event = snapshot.value as? [String: Any] else { return }
//            eventInfoLabel.description
        
       
//        refHandle = eventRef.observe(DataEventType.value, with: { (snapshot) in
//            let event = snapshot.value as? [String : AnyObject] ?? [:]
        
         //let event = Event(key: eventRef.key, description: desc, owner: user, time: time, geohash: geohash)
    }
    
        


}
    
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
         let alert = UIAlertController(title: "Claim Trip", message: "Would you like to claim this trip ?", preferredStyle: .Alert)
        let claimAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(claimAction)
        self.presentViewController(myAlert, animated: true, completion: nil);
    }
    

//}

///// if there is no error, completes with nil
//public static func claimPickUp(trip: Trip, completion: @escaping (Swift.Error?) -> Void) {
//    claim("pickUp", trip: trip, completion: completion)
//}
//
///// if there is no error, completes with nil
//public static func claimDropOff(trip: Trip, completion: @escaping (Swift.Error?) -> Void) {
//    claim("dropOff", trip: trip, completion: completion)
//}
//
//static func claim(_ key: String, trip: Trip, completion: @escaping (Swift.Error?) -> Void) {
//    firstly {
//        auth()
//        }.then { _ -> Promise<User> in
//            guard let uid = Auth.auth().currentUser?.uid else {
//                throw Error.notAuthorized
//            }
//            return API.fetchUser(id: uid)
//        }.then { user -> Void in
//            Database.database().reference().child("trips").child(trip.key).updateChildValues([
//                key: [user.key: user.name ?? "Anonymous Parent"]
//                ])
//            completion(nil)
//        }.catch {
//            completion($0)
//    }
//}

