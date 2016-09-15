//
//  LoginViewController.swift
//  eShopKart
//
//  Created by Apple on 11/03/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit
import AFNetworking

class LoginViewController: TextFieldViewController {
    
    @IBOutlet var emailMobileTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    var isLoginWithAlert:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoginWithAlert {
            navigationItem.leftBarButtonItem = nil
            //navigationItem.setHidesBackButton(true, animated: true)
        }
        self.title = "Log In"
        self.emailMobileTextField.setLeftImage(UIImage(named: "icon_user.png")!)
        self.passwordTextField.setLeftImage(UIImage(named: "icon_password.png")!)
        emailMobileTextField.delegate = self
        passwordTextField.delegate = self
        let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(LoginViewController.crossBtnAction))
        self.navigationItem.setRightBarButtonItem(crossBtnItem, animated: true)
    }
    
    @IBAction func loginACtion(sender: UIButton) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if emailMobileTextField.text!.isEmpty == true || passwordTextField.text!.isEmpty == true {
            loading.labelText = "Please give all values"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.animateLoginBtnOnWrongSubmit()
        } else {
            if emailMobileTextField.text!.isValidEmail() == true {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                var token = appDelegate.deviceTokenString as? String
                if token == nil {
                    token = "786e246f17d1a0684d499b390b8"
                }
                let userInfo = [
                    "email" : emailMobileTextField!.text!,
                    "password" : passwordTextField!.text!,
                    "token_id" : token!
                ]
                loading.mode = MBProgressHUDModeIndeterminate
                loading.yOffset = -55.0
                SigninOperation.signin(userInfo, completionClosure: { (response: AnyObject) -> () in
                    let admin = NSArray(object: response.valueForKey("User") as! NSDictionary)
                    let user: User  = User.initWithArray(admin)[0] as! User
                    appDelegate.currentUser = user
                    appDelegate.saveCurrentUserDetails()
                    if let tokenId: AnyObject = response.valueForKey("User")?.valueForKey("token_id") {
                        let firstName = response.valueForKey("User")?.valueForKey("firstname") as! String
                        let lastName  = response.valueForKey("User")?.valueForKey("lastname") as! String
                        let username =	response.valueForKey("User")?.valueForKey("username") as! String
                        let email =	response.valueForKey("User")?.valueForKey("email") as! String
                        let mobile = response.valueForKey("User")?.valueForKey("mobile") as! String
                        let user_id =	response.valueForKey("User")?.valueForKey("id") as! String
                        NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                        NSUserDefaults.standardUserDefaults().setValue(firstName, forKey: "firstname")
                        NSUserDefaults.standardUserDefaults().setValue(lastName, forKey: "lastname")
                        NSUserDefaults.standardUserDefaults().setValue(username, forKey: "username")
                        NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
                        NSUserDefaults.standardUserDefaults().setValue(mobile, forKey: "mobile")
                        NSUserDefaults.standardUserDefaults().setValue(user_id, forKey: "id")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        loading.hide(true)
                        self.navigationController?.dismissViewControllerAnimated(false, completion: nil)
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
                loading.detailsLabelText = "Please enter valid email id"
                loading.yOffset = -55.0
                loading.hide(true, afterDelay: 2)
                self.animateLoginBtnOnWrongSubmit()
            }
        }
    }
    
    @IBAction func forgetAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if emailMobileTextField.text!.isEmpty == true {
            loading.labelText = "Email can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.animateForgetBtnOnWrongSubmit()
        } else {
            if emailMobileTextField.text!.isValidEmail() == true {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                var token =	appDelegate.deviceTokenString as? String
                if token == nil {
                    token = "786e246f17d1a0684d499b390b8"
                }
                let userInfo  = [
                    "email" : emailMobileTextField!.text!,
                    "token_id" : token!
                ]
                loading.mode = MBProgressHUDModeIndeterminate
                loading.yOffset = -55.0
                SigninOperation.verification(userInfo, completionClosure: { (response: AnyObject) -> () in
                    let admin = NSArray(object: response.valueForKey("User") as! NSDictionary)
                    let user: User  = User.initWithArray(admin)[0] as! User
                    appDelegate.currentUser = user
                    appDelegate.saveCurrentUserDetails()
                    if let tokenId: AnyObject = response.valueForKey("User")?.valueForKey("token_id") {
                        let userId =	response.valueForKey("User")?.valueForKey("id") as! String
                        let email =	response.valueForKey("User")?.valueForKey("email") as! String
                        NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
                        NSUserDefaults.standardUserDefaults().setValue(userId, forKey: "User")
                        NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        })
                        loading.hide(true)
                        let storyboard = UIStoryboard(name: "Login" , bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("VerificationCodeIdentifire") as? VerificationCodeViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
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
                loading.detailsLabelText = "Please enter valid email id"
                loading.yOffset = -55.0
                loading.hide(true, afterDelay: 2)
                self.animateForgetBtnOnWrongSubmit()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func crossBtnAction() {
        self.navigationController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailMobileTextField{
            self.passwordTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func animateLoginBtnOnWrongSubmit() {
        let bounds = self.logInBtn.bounds
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .CurveEaseOut, animations: {
            self.logInBtn.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.logInBtn.enabled = true
            }, completion: nil)
    }
    
    func animateForgetBtnOnWrongSubmit(){
        let bounds = self.forgetBtn.bounds
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .CurveEaseOut, animations: {
            self.forgetBtn.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.forgetBtn.enabled = true
            }, completion: nil)
    }
}

