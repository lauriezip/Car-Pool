//
//  LoginViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/9/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit
import FirebaseCommunity

let logMeInNotificationName = Notification.Name("LogMeInDidCompleteNotification")

class LoginViewController: UIViewController{
    
    var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    
    @IBOutlet weak var onLoginButton: UIButton!
    
    @IBOutlet weak var loginSignUpSegment: UISegmentedControl!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
        self.view.addSubview(activityIndicator)
        
    }
    
    @IBAction func loginSignupSegmentChanged(_ sender: UISegmentedControl) {
        switch loginSignUpSegment.selectedSegmentIndex {
            
        case 0: passwordTextField.isHidden = true
        onLoginButton.setTitle("Login", for: .normal)
            
        case 1: onLoginButton.setTitle("Sign up", for: .normal)
        passwordTextField.isHidden = false
            
            
        default:
            break
        }
    }
    
    
    @IBAction func onLoginPressed(_ sender: Any) {
        if emailTextField.text != nil, passwordTextField.text != nil {
            if loginSignUpSegment.selectedSegmentIndex == 0 {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    print(error)
                    NotificationCenter.default.post(name: logMeInNotificationName, object: nil)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                })
            }else{//user is signing up
                if passwordTextField.text == passwordTextField.text {
                    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                        print(error)
                        
                        NotificationCenter.default.post(name: logMeInNotificationName, object: nil)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    }
                }
            }
        }
    }
    
    
}
