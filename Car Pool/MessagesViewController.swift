//
//  MessagesViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/16/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit
import MapKit
import MessageUI

class MessagesViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var addFriend: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    
    let composeVC = MFMessageComposeViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeVC.messageComposeDelegate = self
        
        API.fetchCurrentUser { (result) in
            switch result {
            case .success(let user):
                self.logoutLabel.text = "Logout \(user.name!)"
            case .failure(let error):
                self.logoutLabel.text = "Logout"
                print(error)
            }
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch (result) {
            
        case .cancelled:
            print("Message was cancelled")
        case .sent:
            print("Message was sent")
        case .failed:
            print("Message failed")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 3 {
            if MFMessageComposeViewController.canSendText() == true {
                let recipients: [String] = ["1500"]
                composeVC.recipients = recipients
                composeVC.body = "Would you like to join CarPool with me."
                self.present(composeVC, animated: true, completion: nil)
            }
        }
    }
}
