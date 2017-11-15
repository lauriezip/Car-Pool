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
    
    
    @IBOutlet weak var allEventsSegmentedControl: UISegmentedControl!
    
   
    var trips: [Trip] = []
    var savedTrips: [Trip] = []
    var children: [Child] = []
    var user: User?
    @IBAction func onLoginPressed(_ sender: UIBarButtonItem) {
           let LoginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
    }
    
    @IBAction func onFriendsPressed(_ sender: UIBarButtonItem) {
        
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

    
//    @IBAction func onLoginPressed(_ sender: UIBarButtonItem) {
//        let LoginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
//    }
    

    
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
            API.observeTheTripsOfMyFriends(sender: self) { (result) in
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
        //        if allEventsSegmentedControl.selectedSegmentIndex == 0 {
        if trips[indexPath.row].event.description == "" {
            cell.textLabel?.text = "*_ Anonymous Event _*"
        } else {
            cell.textLabel?.text = trips[indexPath.row].event.description
        }
        //        } else if allEventsSegmentedControl.selectedSegmentIndex == 1 {
        //            if trips[indexPath.row].event.description == "" {
        //                cell.textLabel?.text = "* Anonymous Event *"
        //            } else {
        //                cell.textLabel?.text = trips[indexPath.row].event.description
        //            }
        //        }
        return cell
    }
}



