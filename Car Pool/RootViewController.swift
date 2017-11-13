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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                API.observeTrips(sender: self) { (result) in
                    switch result {
                    case .success(let trips):
                        self.trips = trips
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if let tripDetailVC = segue.destination as? TripDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow
            tripDetailVC.trip = trips[(indexPath?.row)!]
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath)
            if trips[indexPath.row].event.description == "" {
                cell.textLabel?.text = trips[indexPath.row].event.description
            }
         return cell //[indexPath.row].event.description
        }
    }

    
    //        @IBAction func unwindFromCreateTripVC(segue: UIStoryboardSegue) {
    //        }
    

extension RootViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        API.search(forUsersWithName: searchBar.text!) { (result) in
            print(result)
        }
    }
}


