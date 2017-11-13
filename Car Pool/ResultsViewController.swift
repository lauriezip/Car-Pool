//
//  ResultsViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/10/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import CarpoolKit
import UIKit
import MapKit

class ResultsViewController: UITableViewController {
    var mapItems: [MKMapItem] = []
    var selectedMapItem: MKMapItem?

    var fields: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return fields.count
        return mapItems.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)
        cell.textLabel?.text = fields[indexPath.row].description
        cell.textLabel?.text = mapItems[indexPath.row].name
        cell.detailTextLabel?.text = mapItems[indexPath.row].placemark.title
        //let trip = fields[indexPath.row]
        return cell
    }

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMapItem = mapItems[indexPath.row]
        performSegue(withIdentifier: "UnwindToCreateTripVC", sender: nil)
    }

    
}
