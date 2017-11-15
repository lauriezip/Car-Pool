//
//  TabBarViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/9/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit
import FirebaseCommunity

let logMeInNotificationName = Notification.Name("LogMeInDidCompleteNotification")

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if API.isCurrentUserAnonymous == false {
            NotificationCenter.default.addObserver(forName: logMeinNotification, object: nil, queue: .main) { (_) in
                if let loginVC = self.presentedViewController as? LoginViewController {
                    loginVC.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        super.viewDidAppear(animated)
        
        if API.isCurrentUserAnonymous == true {
            let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(loginVC, animated: animated, completion: nil)
        }
    }
}
