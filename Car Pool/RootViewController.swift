//
//  RootViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/6/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit
import FirebaseCommunity


class RootViewController: UITableViewController {
    
    var trips: [Trip] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var allEventsSegmentedControl: UISegmentedControl!
    
    @IBAction func onCreateTripButtonPressed(_ sender: UIButton) {
        
    }
    
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
    
    @IBAction func unwindFromCreateTripVC(segue: UIStoryboardSegue) {
    }
    
    
    @IBAction func onEventsControlPressed(_ sender: UISegmentedControl) {
        switch allEventsSegmentedControl.selectedSegmentIndex {
        case 0:
            API.observeTrips(sender: self) { (result) in
                switch result {
                case .success(let trips):
                    self.trips = trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        case 1:
            API.observeMyTrips(sender: self, observer: { (result) in
                switch result {
                case .success(let trips):
                    self.trips = trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath)
        if allEventsSegmentedControl.selectedSegmentIndex == 0 {
            if trips[indexPath.row].event.description == "" {
                cell.textLabel?.text = "* no event description *"
            } else {
                cell.textLabel?.text = trips[indexPath.row].event.description
            }
        } else if allEventsSegmentedControl.selectedSegmentIndex == 1 {
            if trips[indexPath.row].event.description == "" {
                cell.textLabel?.text = "* no event description *"
            } else {
                cell.textLabel?.text = trips[indexPath.row].event.description
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
    }

    
    //        @IBAction func unwindFromCreateTripVC(segue: UIStoryboardSegue) {
    //        }
    
}
    

extension RootViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        API.search(forUsersWithName: searchBar.text!) { (result) in
            print(result)
        }
    }
}


