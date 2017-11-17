//
//  CommentsViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/16/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit

extension Date {
    var dayHour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, h:mm a"
        return dateFormatter.string(from: self)
    }
}


class CommentsTableViewController: UITableViewController {

    var trip: Trip!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        guard let trip = trip else { return }
        API.observe(trip: trip, sender: self) { (result) in
            switch result {
                
            case .success(let trip):
                self.trip = trip
                self.tableView.reloadData()
            case .failure(_):
                print("error")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip.comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Comments" , for: indexPath) as? CommentsCell
        cell?.userNameLabel.text = trip.comments[indexPath.row].user.name
        cell?.commentLabel.text = trip.comments[indexPath.row].body
        cell?.dateLabel.text = trip.comments[indexPath.row].time.dayHour
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addSomeCommentsVC = segue.destination as! AddSomeCommentsViewController
        
        addSomeCommentsVC.trip = trip
        
    }
    
    @IBAction func unwindFromAddSomeComments(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
}

class CommentsCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
}
