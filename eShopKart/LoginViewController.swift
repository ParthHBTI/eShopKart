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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailMobileTextField.setLeftImage(UIImage(named: "icon_user.png")!)
        self.passwordTextField.setLeftImage(UIImage(named: "icon_password.png")!)
        emailMobileTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginACtion(sender: UIButton) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if emailMobileTextField.text!.isEmpty == true {
            loading.labelText = "Email can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else if passwordTextField.text!.isEmpty == true {
            loading.labelText = "Password can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else {
            if emailMobileTextField.text!.isValidEmail() == true {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                var token = appDelegate.deviceTokenString as? String
                if token == nil {
                    token = "786e246f17d1a0684d499b390b8"
                }
                print("\n\(token)\n")
                let userInfo = [
                    "email" : emailMobileTextField!.text!,
                    "password" : passwordTextField!.text!,
                    "token_id" : token!
                ]
                loading.mode = MBProgressHUDModeIndeterminate
                loading.yOffset = -55.0
                SigninOperaion.signin(userInfo, completionClosure: { (response: AnyObject) -> () in
                    let admin = NSArray(object: response.valueForKey("User") as! NSDictionary)
                    let user: User  = User.initWithArray(admin)[0] as! User
                    appDelegate.currentUser = user
                    appDelegate.saveCurrentUserDetails()
                    if let tokenId: AnyObject = response.valueForKey("User")?.valueForKey("token_id") {
                        let username =	response.valueForKey("User")?.valueForKey("username") as! String
                        let email =	response.valueForKey("User")?.valueForKey("email") as! String
                        let mobile = response.valueForKey("User")?.valueForKey("mobile") as! String
                        let user_id =	response.valueForKey("User")?.valueForKey("id") as! String
                        NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                        NSUserDefaults.standardUserDefaults().setValue(username, forKey: "username")
                        NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
                        NSUserDefaults.standardUserDefaults().setValue(mobile, forKey: "mobile")
                        NSUserDefaults.standardUserDefaults().setValue(user_id, forKey: "id")
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
                loading.detailsLabelText = "Please enter valid email id"
                loading.yOffset = -55.0
                loading.hide(true, afterDelay: 2)
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
                SigninOperaion.verification(userInfo, completionClosure: { (response: AnyObject) -> () in
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
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func crossBtnAction(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(false, completion: nil)
        
    }
 
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailMobileTextField{
            self.passwordTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if (segue.identifier == "forgotSegue") {
     let detailVC = segue.destinationViewController as! VerificationCodeViewController
     detailVC.emailText = emailMobileTextField.text! as String
     }
     }*/
}

