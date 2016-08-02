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
        let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(UserRegistrationVC.crossBtnAction))
        self.navigationItem.setRightBarButtonItem(crossBtnItem, animated: true)
        self.title = "Sign Up"
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        mailTextField.delegate = self
        confirmPassTextField.delegate = self
        contactNumberTextField.delegate = self
        passwordTextField.delegate = self
        self.firstNameTextField.setLeftImage(UIImage(named: "person_icon.png")!)
        self.lastNameTextField.setLeftImage(UIImage(named: "person_icon.png")!)
        self.contactNumberTextField.setLeftImage(UIImage(named: "person_icon.png")!)
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
        let firstNameStr = self.firstNameTextField.text!
        let lastNameStr = self.lastNameTextField.text!
        let mobileStr = self.contactNumberTextField.text!
        let charSet = NSCharacterSet.whitespaceCharacterSet()
        let firstNameWhiteSpaceSet = firstNameStr.stringByTrimmingCharactersInSet(charSet)
        let lastNameWhiteSpaceSet = lastNameStr.stringByTrimmingCharactersInSet(charSet)
        let mobileWhiteSpaceSet = mobileStr.stringByTrimmingCharactersInSet(charSet)
        if firstNameTextField.text!.isEmpty == true || lastNameTextField.text!.isEmpty == true || mailTextField.text!.isEmpty == true || contactNumberTextField.text!.isEmpty == true || passwordTextField.text!.isEmpty == true || confirmPassTextField.text!.isEmpty == true {
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "please enter all values here!"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.animateBtnOnWrongSubmit()
            
        } else  if  mailTextField.text!.isValidEmail() != true {
            loading.mode = MBProgressHUDModeText
            loading.labelText = "Please enter valid email id"
            loading.hide(true, afterDelay: 2)
            self.animateBtnOnWrongSubmit()
        } else if contactNumberTextField.text!.characters.count != 10 {
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "please enter a valid mobile number"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.animateBtnOnWrongSubmit()
        } else if (passwordTextField.text!.characters.count) < 6 {
                        loading.mode = MBProgressHUDModeText
                        loading.detailsLabelText = "password length must be of 6 characters!"
                        loading.hide(true, afterDelay: 2)
                        loading.removeFromSuperViewOnHide = true
                        self.animateBtnOnWrongSubmit()
        }else if passwordTextField.text != confirmPassTextField.text{
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "Password and Confirm Password does not match"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        }else if firstNameWhiteSpaceSet == "" || lastNameWhiteSpaceSet == "" || mobileWhiteSpaceSet == "" {
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "Only white spaces can not be accepted"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.animateBtnOnWrongSubmit()
            
        }else {
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
                            let firstName = response.valueForKey("User")?.valueForKey("firstname") as! String
                            let lastName = response.valueForKey("User")?.valueForKey("lastname") as! String
                            let trimFirstNameStr = firstName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) as String
                            let userFullNmae = trimFirstNameStr + " " + lastName
                            let email =	response.valueForKey("User")?.valueForKey("email") as! String
                            let mobile = response.valueForKey("User")?.valueForKey("mobile") as! String
                            let user_id = response.valueForKey("User")?.valueForKey("id") as! String
                            NSUserDefaults.standardUserDefaults().setValue(firstName, forKey:"firstname")
                            NSUserDefaults.standardUserDefaults().setValue(lastName , forKey: "lastname")
                            NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                            NSUserDefaults.standardUserDefaults().setValue(userFullNmae, forKey: "username")
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
                    loading.detailsLabelText = "Password and Confirm password does not match"
                    loading.hide(true, afterDelay: 2)
                    self.animateBtnOnWrongSubmit()
                }
            }
    }
    
    func animateBtnOnWrongSubmit(){
        let bounds = self.DoneBtn.bounds
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .CurveEaseOut, animations: {
            self.DoneBtn.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.DoneBtn.enabled = true
            }, completion: nil)
    }
    
    func crossBtnAction() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                                                 replacementString string: String)
        -> Bool
    {
        if string.characters.count == 0 {
            return true
        }
        // Check to see if the text field's contents still fit the constraints
        // with the new content added to it.
        // If the contents still fit the constraints, allow the change
        // by returning true; otherwise disallow the change by returning false.
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        switch textField {
        case  firstNameTextField:
            return prospectiveText.characters.count <= 30
            
        case lastNameTextField:
            return prospectiveText.characters.count <= 30
            
        case contactNumberTextField:
            return prospectiveText.characters.count <= 10
            
        default:
            return true
        }
    }

    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.firstNameTextField {
            self.lastNameTextField.becomeFirstResponder()
        }else if textField == self.lastNameTextField{
            self.mailTextField.becomeFirstResponder()
        }else if textField == self.mailTextField{
           if  mailTextField.text!.isValidEmail() == true {
            self.contactNumberTextField.becomeFirstResponder()
           } else {
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.labelText = "Please enter valid email id"
            loading.hide(true, afterDelay: 2)
            }
        } else if textField == self.contactNumberTextField{
            self.passwordTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField{
            self.confirmPassTextField.becomeFirstResponder()
        } else {
            //self.view.endEditing(true)
        }
        return true
    }
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


}