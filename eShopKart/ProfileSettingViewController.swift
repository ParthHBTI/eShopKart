//
//  ProfileSettingViewController.swift
//  BrillCreation
//
//  Created by Hemendra Singh on 28/04/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit

class ProfileSettingViewController: TextFieldViewController {
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var mobNumberLbl: UILabel!
    @IBOutlet weak var mobNumberTxtField: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTxtField.delegate = self
        lastNameTxtField.delegate = self
        mobNumberTxtField.delegate = self
        emailTxtField.delegate = self
        
        //        let numberToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        //        numberToolbar.barStyle = .BlackTranslucent
        //        numberToolbar.items = [UIBarButtonItem(title: "Cancel", style: .Bordered, target: self, action: #selector(self.cancelNumberPad)), UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Apply", style: .Done, target: self, action: #selector(self.doneWithNumberPad))]
        //        numberToolbar.sizeToFit()
        //        mobNumberTxtField.inputAccessoryView = numberToolbar
        let barButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: mobNumberTxtField, action: #selector(self.resignFirstResponder))
        let toolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        toolbar.items = [barButton]
        mobNumberTxtField.inputAccessoryView = toolbar
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        self.title = "Update Profile"
        self.firstNameTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("firstname") as? String
        self.lastNameTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("lastname") as? String
        //        let userFullName = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
        //        var splitStrArr = userFullName!.componentsSeparatedByString(" ")
        //        firstNameTxtField.text = splitStrArr[0]
        //        lastNameTxtField.text = splitStrArr.count > 1 ? splitStrArr[splitStrArr.count - 1] : nil
        self.emailTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String
        self.mobNumberTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("mobile") as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    @IBAction func segmentControlAction(sender: AnyObject) {
    //        let userFullName = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
    //        var splitStrArr = userFullName!.componentsSeparatedByString(" ")
    //        if(segmentControl.selectedSegmentIndex == 0) {
    //            self.firstNameLbl.text = "First Name"
    //            self.lastNameLbl.text = "Last Name"
    //            self.firstNameTxtField.text = splitStrArr[0]
    //            self.lastNameTxtField.text = splitStrArr.count > 1 ? splitStrArr[splitStrArr.count - 1] : nil
    //
    //        }else {
    //            self.firstNameLbl.text = "Email Address"
    //            self.lastNameLbl.text = "Mobile Number"
    //            self.firstNameTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String
    //            self.lastNameTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("mobile") as? String
    //
    //        }
    //    }
    @IBAction func saveChangesBtnAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let firstNameStr = self.firstNameTxtField.text!
        let lastName = self.lastNameTxtField.text!
        let mobile = self.mobNumberTxtField.text!
        let charSet = NSCharacterSet.whitespaceCharacterSet()
        let firstNameWhiteSpaceSet = firstNameStr.stringByTrimmingCharactersInSet(charSet)
        let lastNameWhiteSpaceSet = lastName.stringByTrimmingCharactersInSet(charSet)
        let mobileWhiteSpaceSet = mobile.stringByTrimmingCharactersInSet(charSet)
        if firstNameTxtField.text!.isEmpty == true || lastNameTxtField.text!.isEmpty == true || mobNumberTxtField.text!.isEmpty == true || emailTxtField.text!.isEmpty == true {
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "please enter correct data!"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.animateBtnOnWrongSubmit()
            
        } else if mobNumberTxtField.text?.characters.count != 10 {
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "please enter a valid mobile number"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.animateBtnOnWrongSubmit()
            
        }else if firstNameWhiteSpaceSet == "" || lastNameWhiteSpaceSet == "" || mobileWhiteSpaceSet == "" {
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "Only white spaces can not be accepted"
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.animateBtnOnWrongSubmit()
        }
        else {
            if  emailTxtField.text!.isValidEmail() == true {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                loading.mode = MBProgressHUDModeIndeterminate
                var token =	appDelegate.deviceTokenString as? String
                if token == nil {
                    token = "786e246f17d1a0684d499b390b8c15e0"
                }
                let userInfo :[String : String] = [
                    "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
                    "firstname" : firstNameTxtField!.text!,
                    "lastname" : lastNameTxtField!.text!,
                    "mobile" : mobNumberTxtField!.text!,
                    "email" : emailTxtField!.text!
                ]
                SigninOperaion.editProfile(userInfo, completionClosure: { response in
                    let admin = NSArray(object: response.valueForKey("User") as! NSDictionary)
                    let user: User  = User.initWithArray(admin)[0] as! User
                    appDelegate.currentUser = user
                    appDelegate.saveCurrentUserDetails()
                    if let tokenId: AnyObject = response.valueForKey("User")?.valueForKey("token_id") {
                        let firstName = response.valueForKey("User")?.valueForKey("firstname") as! String
                        let lastName = response.valueForKey("User")?.valueForKey("lastname") as! String
                        let trimFirstNameStr = firstName.stringByTrimmingCharactersInSet(charSet) as String
                        let userFullName = trimFirstNameStr + " " + lastName
                        let email =	response.valueForKey("User")?.valueForKey("email") as! String
                        let mobile = response.valueForKey("User")?.valueForKey("mobile") as! String
                        let user_id =	response.valueForKey("User")?.valueForKey("id") as! String
                        NSUserDefaults.standardUserDefaults().setValue(firstName, forKey: "firstname")
                        NSUserDefaults.standardUserDefaults().setValue(lastName, forKey: "lastname")
                        NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                        NSUserDefaults.standardUserDefaults().setValue(userFullName, forKey: "username")
                        NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
                        NSUserDefaults.standardUserDefaults().setValue(mobile, forKey: "mobile")
                        NSUserDefaults.standardUserDefaults().setValue(user_id, forKey: "id")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        loading.hide(true)
                        //                            let storyboard = UIStoryboard(name: "Login", bundle: nil)
                        //                            let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as! UserProfileViewController
                        //                            self.navigationController?.pushViewController(vc, animated: true)
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
                loading.labelText = "Please give a valid email address"
                loading.hide(true, afterDelay: 2)
                self.animateBtnOnWrongSubmit()
            }
        }
    }
    //        let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
    //        let params = [
    //            "user_id" : userId!,
    //            "firstname" : self.firstNameTxtField.text!,
    //            "lastname" : self.lastNameTxtField.text!,
    //            ]
    //        SigninOperaion.editProfile(params, completionClosure: { response in
    //            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    //            loading.mode = MBProgressHUDModeText
    //            loading.detailsLabelText = response["message"] as! String
    //            loading.hide(true, afterDelay: 2)
    //            loading.removeFromSuperViewOnHide = true
    //        }) {(error: NSError) -> () in
    //            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    //            loading.mode = MBProgressHUDModeText
    //            loading.detailsLabelText = error.localizedDescription
    //            loading.hide(true, afterDelay: 2)
    //
    //        }
    //
    //    }
    func animateBtnOnWrongSubmit() {
        let bounds = self.saveBtn.bounds
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .CurveEaseOut, animations: {
            self.saveBtn.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.saveBtn.enabled = true
            }, completion: nil)
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
        case firstNameTxtField:
            return prospectiveText.characters.count <= 30
            
        case lastNameTxtField:
            return prospectiveText.characters.count <= 30
            
        case mobNumberTxtField:
            return prospectiveText.characters.count <= 10
            
        default:
            return true
        }
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        //textField.backgroundColor = UIColor.blueColor()
        return true
    }
}
