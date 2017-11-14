//
//  FriendsViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/13/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit

class FriendsViewController: UITableViewController {
    
    var friends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.observeFriends(sender: self) { (result) in
            switch result {
            case.success(let downloadedFriends):
                self.friends = downloadedFriends
                self.tableView.reloadData()
            case.failure(let error):
                print("Error getting friends", error)
                
            }
        }
    }
    
  
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Friends", for: indexPath) as! FriendCell
        
        cell.friendNameLabel.text = friends[indexPath.row].name
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        API.remove(friend: friends[indexPath.row])
        friends.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
}




class FriendCell: UITableViewCell {
    
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var friendNameLabel: UILabel!
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        friendView.layer.borderColor = UIColor.blue.cgColor
//        friendView.layer.cornerRadius = 5
//        friendView.layer.borderWidth = 1
//        
//        }
    
}
