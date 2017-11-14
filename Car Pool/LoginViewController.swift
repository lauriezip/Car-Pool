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
        confirmPasswordTextField.isHidden = true
        fullNameTextField.isHidden = true
        activityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
        self.view.addSubview(activityIndicator)
        
    }
    
    @IBAction func loginSignupSegmentChanged(_ sender: UISegmentedControl) {
        switch loginSignUpSegment.selectedSegmentIndex {
            
        case 0:
            confirmPasswordTextField.isHidden = true
            fullNameTextField.isHidden = true
            loginSignupButton.setTitle("Login", for: .normal)
        case 1:
            confirmPasswordTextField.isHidden = false
            fullNameTextField.isHidden = false
            loginSignupButton.setTitle("Signup", for: .normal)
        default:
            break
        }
    }
    
    
    @IBAction func onLoginPressed(_ sender: Any) {
        if emailTextField.text != nil, passwordTextField.text != nil {
            if segmentedControlLoginSignup.selectedSegmentIndex == 0 {
                API.signIn(email: emailTextField.text!, password: passwordTextField.text!, completion: { (result) in
                    switch result {
                    case .success(_):
                        NotificationCenter.default.post(name: logMeinNotification, object: nil)
                    case .failure(let error):
                        print(error)
                    }
                })
            }
            else if segmentedControlLoginSignup.selectedSegmentIndex == 1 {
                if passwordTextField.text! == confirmPasswordTextField.text {
                    if fullNameTextField != nil {
                        if emailTextField != nil {
                            API.signUp(email: emailTextField.text!, password: passwordTextField.text!, fullName: fullNameTextField.text!, completion: { (result) in
                                switch result {
                                case .success(_):
                                    NotificationCenter.default.post(name: logMeinNotification, object: nil)
                                case .failure(let error):
                                    print(error)
                                }
                            })
                        }
                    }
                }
            }
            let loginVC = self.presentedViewController as? LoginViewController
            loginVC?.dismiss(animated: true, completion: nil)
        }
    }
    
}
