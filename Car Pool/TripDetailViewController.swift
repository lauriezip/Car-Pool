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
    }
    

//}

