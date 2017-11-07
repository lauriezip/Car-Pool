//
//  RootViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit

class RootViewController: UITableViewController {
    
    var trips: [Trip] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.fetchTripsOnce { (trips) in
            self.trips = trips
            self.tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let tripDetailVC = segue.destination as? TripDetailViewController
        let indexPath = tableView.indexPathForSelectedRow
        let trip = trips[(indexPath?.row)!]
            
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath)
       cell.textLabel?.text = trips[indexPath.row].event.description
        let trip = trips[indexPath.row]
        let isClaimed = trip.dropOff.isClaimed && trip.pickUp.isClaimed
        if isClaimed {
            cell.backgroundColor = .clear
        } else {
            cell.backgroundColor = .red
        }
        return cell
}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
       
    }

}

