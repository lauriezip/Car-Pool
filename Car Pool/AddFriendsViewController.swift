//
//  AddFriendsViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/15/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//


import UIKit
import CarpoolKit

class AddFriendsViewController: UITableViewController, UISearchBarDelegate {
    var friendsList: [CarpoolKit.User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        API.search(forUsersWithName: searchBar.text!) { (result) in
            switch result {
            case .success(let friends):
                self.friendsList = friends
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        API.add(friend: friendsList[indexPath.row])
        friendsList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFriends", for: indexPath)
        cell.textLabel?.text = friendsList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select friends by tapping on the name"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
}
