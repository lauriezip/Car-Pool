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
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var friends: [CarpoolKit.User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.tableView.reloadSections([0], with: .bottom)
        
        myFriendsShown()
    }
    
    func myFriendsShown() {
        API.observeFriends(sender: self) { (result) in
            switch result {
            case .success(let myFriends):
                self.friends = myFriends
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriends", for: indexPath)
        cell.textLabel?.text = friends[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            API.remove(friend: friends[indexPath.row])
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Friends"
    }
}
