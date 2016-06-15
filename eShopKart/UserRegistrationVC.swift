//
//  userRegisterViewController.swift
//  eShopKart
//
//  Created by Apple on 22/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import UIKit
import Foundation
import AFNetworking

class UserRegistrationVC: TextFieldViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var contactNumberTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPassTextField: UITextField!
    @IBOutlet var DoneBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        mailTextField.delegate = self
        confirmPassTextField.delegate = self
        contactNumberTextField.delegate = self
        passwordTextField.delegate = self
        self.firstNameTextField.setLeftImage(UIImage(named: "person_icon.png")!)
        self.lastNameTextField.setLeftImage(UIImage(named: "person_icon.png")!)
        self.contactNumberTextField.setLeftImage(UIImage(named: "mobile.png")!)
        self.mailTextField.setLeftImage(UIImage(named: "mail")!)
        self.passwordTextField.setLeftImage(UIImage(named: "password_icon.png")!)
        self.confirmPassTextField.setLeftImage(UIImage(named: "password_icon.png")!)
        self.DoneBtn.layer.cornerRadius = 20
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        if firstNameTextField.text!.isEmpty == true || lastNameTextField.text!.isEmpty == true || mailTextField.text!.isEmpty == true || contactNumberTextField.text!.isEmpty == true || passwordTextField.text!.isEmpty == true || confirmPassTextField.text!.isEmpty == true {
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "please enter all values here!"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else if (passwordTextField.text!.characters.count) < 5 {
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "password length must be of 5 characters!"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else {
            if  mailTextField.text!.isValidEmail() == true {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                loading.mode = MBProgressHUDModeIndeterminate
                var token =	appDelegate.deviceTokenString as? String
                if token == nil {
                    token = "786e246f17d1a0684d499b390b8c15e0"
                }
                let userInfo :[String : String] = [
                    "firstname" : firstNameTextField!.text!,
                    "lastname" : lastNameTextField!.text!,
                    "email" : mailTextField!.text!,
                    "password" : passwordTextField!.text!,
                    "mobile" : contactNumberTextField!.text!,
                    "token_id" : token!
                ]
                if passwordTextField.text == confirmPassTextField.text{
                    SigninOperaion.signup(userInfo, completionClosure: { response in
                        let admin = NSArray(object: response.valueForKey("User") as! NSDictionary)
                        let user: User  = User.initWithArray(admin)[0] as! User
                        appDelegate.currentUser = user
                        appDelegate.saveCurrentUserDetails()
                        if let tokenId: AnyObject = response.valueForKey("User")?.valueForKey("token_id") {
                            let username =	response.valueForKey("User")?.valueForKey("username") as! String
                            let email =	response.valueForKey("User")?.valueForKey("email") as! String
                            let mobile = response.valueForKey("User")?.valueForKey("mobile") as! String
                            NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                            NSUserDefaults.standardUserDefaults().setValue(username, forKey: "username")
                            NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
                            NSUserDefaults.standardUserDefaults().setValue(mobile, forKey: "mobile")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            loading.hide(true)
                            let storyboard = UIStoryboard(name: "Login", bundle: nil)
                            let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as! UserProfileViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            loading.mode = MBProgressHUDModeText
                            loading.detailsLabelText = "Exceptional error occured. Please try again after some time"
                            loading.hide(true, afterDelay: 2)
                        }
                    }) { (error: NSError) -> () in
                        loading.mode = MBProgressHUDModeText
                        loading.detailsLabelText = error.localizedDescription
                        loading.hide(true, afterDelay: 2)
                    }
                } else {
                    loading.mode = MBProgressHUDModeText
                    loading.detailsLabelText = "Password and Confirm password does not match"
                    loading.hide(true, afterDelay: 2)
                }
            } else {
                loading.mode = MBProgressHUDModeText
                loading.labelText = "Please enter valid email id"
                loading.hide(true, afterDelay: 2)
            }
        }
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


