//
//  EventDetailViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit



class EventDetailViewController: UIViewController {
     var labelText: String?

    
    @IBOutlet weak var eventInfoLabel: UILabel!
    
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventInfoLabel.text = labelText

        
        
    }
    
}
