//
//  LoginViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/9/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit


let logMeInNotificationName = Notification.Name("LogMeInDidCompleteNotification")

class LoginViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    
    
    
    @IBOutlet weak var onLoginButton: UIButton!
    
    @IBOutlet weak var loginSignUpSegment: UISegmentedControl!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordConfirmTextField.isHidden = true
        userNameTextField.isHidden = true
        activityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
        self.view.addSubview(activityIndicator)
        
    }
    
//    @IBAction func actionSignup(_ sender: Any) {
//        let appDelegateTemp = UIApplication.shared.delegate as? AppDelegate
//        appDelegateTemp?.window?.rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
//    }
    
    
    @IBAction func loginSignupSegmentChanged(_ sender: UISegmentedControl) {
        switch loginSignUpSegment.selectedSegmentIndex {
            
        case 0:
            passwordConfirmTextField.isHidden = true
            userNameTextField.isHidden = true
            onLoginButton.setTitle("Login", for: .normal)
        case 1:
            passwordConfirmTextField.isHidden = false
            userNameTextField.isHidden = false
            onLoginButton.setTitle("Signup", for: .normal)
        default:
            break
        }
    }
    
    
    @IBAction func onLoginPressed(_ sender: Any) {
        if emailTextField.text != nil, passwordTextField.text != nil {
            if loginSignUpSegment.selectedSegmentIndex == 0 {
                API.signIn(email: emailTextField.text!, password: passwordTextField.text!, completion: { (result) in
                    switch result {
                    case .success(_):
                        NotificationCenter.default.post(name: logMeinNotification, object: nil)
                    case .failure(let error):
                        print(error)
                    }
                })
            }
            else if loginSignUpSegment.selectedSegmentIndex == 1 {
                if passwordTextField.text! == passwordConfirmTextField.text {
                    if userNameTextField != nil {
                        if emailTextField != nil {
                            API.signUp(email: emailTextField.text!, password: passwordTextField.text!, fullName: userNameTextField.text!, completion: { (result) in
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
