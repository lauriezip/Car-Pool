//
//  AddFriendsViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/15/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import Foundation
import UIKit
import CarpoolKit

class AddFriendsViewController: UITableViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    var friends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    @IBAction func onSearchFieldReturn(_ sender: UITextField) {
        API.search(forUsersWithName: sender.text!) { (result) in
            switch result{
                
            case .success(let downloadedFriends):
                self.friends = downloadedFriends
                self.tableView.reloadData()
                print(self.friends)
            case .failure(let error):
                print("\nError getting Users:", error)
            }
        }
        searchTextField.text = ""
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendSearch", for: indexPath) as! AddFriendCell
        
        cell.friendNameLabel.text = friends[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        API.add(friend: friends[indexPath.row])
        performSegue(withIdentifier: "UnwindFromAddFriends", sender: self)
    }
    
}

class AddFriendCell: UITableViewCell {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var addFriendView: UIView!
    
}
