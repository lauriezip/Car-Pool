//
//  RootViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
var events: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
        
    }

}

