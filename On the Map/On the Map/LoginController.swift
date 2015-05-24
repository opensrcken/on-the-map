//
//  LoginController.swift
//  On the Map
//
//  Created by Ken Hahn on 5/14/15.
//  Copyright (c) 2015 Ken Hahn. All rights reserved.
//

import UIKit

public final class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        loginButton.setTitle("Submit", forState: UIControlState.Normal)
        loginButton.setTitle("Authenticating...", forState: UIControlState.Disabled)
    }
    
    internal func onLogin() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPressLogin(sender: AnyObject) {
        loginButton.enabled = false
        
        UdacityClient.sharedInstance().login(emailField.text, password: passwordField.text) { JSONResult, error in
            if let error = error {
                self.showAlert("Network Error", message: error.localizedDescription)
            } else {
                if let session = JSONResult.valueForKey("session") as? [String : AnyObject] {
                    if let account = JSONResult.valueForKey("account") as? [String : AnyObject] {
                        let object = UIApplication.sharedApplication().delegate
                        let appDelegate = object as! AppDelegate
                        
                        println(session["expiration"] as! String)
                        
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSSSS'Z"
                        let date = dateFormatter.dateFromString(session["expiration"] as! String)
                        let key = account["key"] as! NSString
                        
                        appDelegate.sessionExpiration = date
                        appDelegate.accountId = key.longLongValue
                        
                        self.onLogin()
                    } else {
                        self.showAlert("Invalid Data", message: "Expected a user property in the response.")
                    }
                } else {
                    self.showAlert("Invalid Credentials", message: "Double-check your username and password.")
                }
            }
            self.loginButton.enabled = true
        }
    }
    
    @IBAction func onPressSignUp(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
    }
    
    func showAlert(title: String, message: String) {
        dispatch_async(dispatch_get_main_queue(), {
            var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
}
