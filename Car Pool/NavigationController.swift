//
//  NavigationController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/14/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit
import FirebaseCommunity

let logMeinNotification = Notification.Name("LogMeInDidCompleteNotification")

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if API.isCurrentUserAnonymous == false {
            NotificationCenter.default.addObserver(forName: logMeinNotification, object: nil, queue: .main) {
                (_) in
                let loginVC = self.presentedViewController as? NavigationController
                loginVC?.dismiss(animated: true, completion: nil)
            }
        }
    }


override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if API.isCurrentUserAnonymous == true {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginVC, animated: animated, completion: nil)
    }
}

}

