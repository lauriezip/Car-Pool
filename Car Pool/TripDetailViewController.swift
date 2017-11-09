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
    
//    @IBAction func acceptButtonTapped(_ sender: UIButton) {
//         let alert = UIAlertController(title: "Claim Trip", message: "Would you like to claim this trip ?", preferredStyle: .Alert)
//        let claimAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
//        myAlert.addAction(claimAction)
//        self.presentViewController(myAlert, animated: true, completion: nil);
//    }


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

