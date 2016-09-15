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
    
    let button = UIButton(type: UIButtonType.Custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTxtField.delegate = self
        lastNameTxtField.delegate = self
        mobNumberTxtField.delegate = self
        emailTxtField.delegate = self
        /*button.setTitle("Done", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 163, 106, 53)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(self.doneBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)*/
        
        //        let numberToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        //        numberToolbar.barStyle = .BlackTranslucent
        //        numberToolbar.items = [UIBarButtonItem(title: "Cancel", style: .Bordered, target: self, action: #selector(self.cancelNumberPad)), UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Apply", style: .Done, target: self, action: #selector(self.doneWithNumberPad))]
        //        numberToolbar.sizeToFit()
        //        mobNumberTxtField.inputAccessoryView = numberToolbar
        //mobNumberTxtField.returnKeyType = .Done
        
        ////
        let barButton1: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: mobNumberTxtField, action: #selector(self.resignFirstResponder))
         
         //let barButton2: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: mobNumberTxtField, action: #selector(self.resignFirstResponder))
         let toolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
         //toolbar.barStyle = UIBarStyle.BlackTranslucent
         barButton1.accessibilityFrame = (frame: CGRectMake(250/255.0, 0/255.0, 106.0/255, 53.0/25))
         toolbar.items = [barButton1]
         mobNumberTxtField.inputAccessoryView = toolbar ////
        
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        self.title = "Update Profile"
        self.firstNameTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("firstname") as? String
        self.lastNameTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("lastname") as? String
        self.emailTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String
        self.mobNumberTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("mobile") as? String
        //        let userFullName = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
        //        var splitStrArr = userFullName!.componentsSeparatedByString(" ")
        //        firstNameTxtField.text = splitStrArr[0]
        //        lastNameTxtField.text = splitStrArr.count > 1 ? splitStrArr[splitStrArr.count - 1] : nil
        
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
        //        let firstNameStr = self.firstNameTxtField.text!
        //        let lastName = self.lastNameTxtField.text!
        //        let mobile = self.mobNumberTxtField.text!
        let charSet = NSCharacterSet.whitespaceCharacterSet()
        let firstNameWhiteSpaceSet = self.firstNameTxtField.text!.stringByTrimmingCharactersInSet(charSet)
        let lastNameWhiteSpaceSet = self.lastNameTxtField.text!.stringByTrimmingCharactersInSet(charSet)
        let mobileWhiteSpaceSet = self.mobNumberTxtField.text!.stringByTrimmingCharactersInSet(charSet)
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
                SigninOperation.editProfile(userInfo, completionClosure: { response in
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
                        let user_id = response.valueForKey("User")?.valueForKey("id") as! String
                        NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                        NSUserDefaults.standardUserDefaults().setValue(trimFirstNameStr, forKey: "firstname")
                        NSUserDefaults.standardUserDefaults().setValue(lastName, forKey: "lastname")
                        NSUserDefaults.standardUserDefaults().setValue(userFullName, forKey: "username")
                        NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
                        NSUserDefaults.standardUserDefaults().setValue(mobile, forKey: "mobile")
                        NSUserDefaults.standardUserDefaults().setValue(user_id, forKey: "id")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        loading.hide(true)
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
        -> Bool {
            if string.characters.count == 0 {
                return true
            }
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            switch textField {
            case firstNameTxtField:
                return prospectiveText.characters.count <= 30
                
            case lastNameTxtField:
                return prospectiveText.characters.count <= 30
                
            case mobNumberTxtField:
                //return prospectiveText.characters.count <= 10
                if prospectiveText.characters.count <= 10 {
                    mobNumberTxtField.addBorderWithColor(UIColor.clearColor(), borderWidth: 0.0)
                    return true
                }
                else {
                    mobNumberTxtField.addBorderWithColor(UIColor.redColor(), borderWidth: 1.0)
                    return true
                }
            default:
                return true
            }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
   /*override func textFieldDidBeginEditing(textField: UITextField) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProfileSettingViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }*/
    
    /*func keyboardWillShow(note : NSNotification) -> Void{
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.button.hidden = false
            let keyBoardWindow = UIApplication.sharedApplication().windows.last
            self.button.frame = CGRectMake(0, (keyBoardWindow?.frame.size.height)!-53, 106, 53)
            keyBoardWindow?.addSubview(self.button)
            keyBoardWindow?.bringSubviewToFront(self.button)
            UIView.animateWithDuration(((note.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.doubleValue)!, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.view.frame = CGRectOffset(self.view.frame, 0, 0)
                }, completion: { (complete) -> Void in
            })
        }
    }*/
    /*
    func doneBtnAction(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }*/
}
