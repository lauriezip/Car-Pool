//
//  EventDetailViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit



class TripDetailViewController: UIViewController {
    var labelText: String?
    var firstVCtext = ""
    
    
    
    @IBOutlet weak var eventInfoLabel: UILabel!
    
    
    @IBOutlet weak var claimLegButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventInfoLabel.text = labelText
        
        
        
    }
    
        


}
