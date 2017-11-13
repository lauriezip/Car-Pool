//
//  SettingsViewController.swift
//  
//
//  Created by Laurie Zipperer on 11/13/17.
//

import UIKit
import CarpoolKit

class SettingsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 0 {
            API.fetchCurrentUser().value?.name
            let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginVC, animated: true, completion: nil)
        }
    }
}
