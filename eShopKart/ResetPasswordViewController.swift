//
//  ResetPasswordViewController.swift
//  eShopKart
//
//  Created by mac on 25/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class ResetPasswordViewController:TextFieldViewController {
    @IBOutlet private var newPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPassTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPassAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if newPassTextField.text!.isEmpty == true {
            loading.labelText = "Password can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            var token =	appDelegate.deviceTokenString as? String
            if token == nil {
                token = "786e246f17d1a0684d499b390b8"
            }
            let userInfo  = [
                "password" : newPassTextField!.text!,
                "token_id" : token!
            ]
            loading.mode = MBProgressHUDModeIndeterminate
            loading.hide(true, afterDelay: 2)
            SigninOperaion.getOtp(userInfo, completionClosure: { (response: AnyObject) -> () in
                let admin = NSArray(object: response.valueForKey("User") as! NSDictionary)
                let user: User  = User.initWithArray(admin)[0] as! User
                appDelegate.currentUser = user
                appDelegate.saveCurrentUserDetails()
                if let tokenId: AnyObject = response.valueForKey("User")?.valueForKey("token_id") {
                    let userId =	response.valueForKey("User")?.valueForKey("id") as! String
                    NSUserDefaults.standardUserDefaults().setValue(userId, forKey: "User")
                    NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        // appDelegate.window?.rootViewController = appDelegate.baseView
                        //self.placeViewClosed()
                        //NSNotificationCenter.defaultCenter().postNotificationName("UINotificationLoginCalled", object: nil)
                        //NSNotificationCenter.defaultCenter().postNotificationName(Eboard_MemoRefresh_Notification, object: nil)
                        //NSNotificationCenter.defaultCenter().postNotificationName(Eboard_Login_Notification, object: nil)
                    })
                    
                    let storyboard = UIStoryboard(name: "Login" , bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("ResetPasswordIdentifire") as? ResetPasswordViewController
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
        }
    }
    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @IBAction func crossAction(sender: AnyObject) {
        
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
