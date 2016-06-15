//
//  VerificationCodeViewController.swiftchangepassword//  eShopKart
//
//  Created by mac on 07/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class VerificationCodeViewController: TextFieldViewController {
    @IBOutlet var verificationTextField: UITextField!
    var emailText: String = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationTextField.delegate = self
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        loading.yOffset = -47.0
        loading.detailsLabelText = "Verification Code has been send successfully in your Email ID"
        loading.hide(true, afterDelay: 3)
        loading.removeFromSuperViewOnHide = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verifyCodeAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if (verificationTextField.text == "" ) {
            let alert = UIAlertView.init(title: "Oppss", message: "Please Enter Your Verify Code", delegate: self, cancelButtonTitle: "GO")
            alert.show()
        } else  {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            var token =	appDelegate.deviceTokenString as? String
            if token == nil {
                token = "786e246f17d1a0684d499b390b8"
            }
            let userInfo  = [
                "email" : NSUserDefaults.standardUserDefaults().valueForKey("email") as! String,
                "otp" : verificationTextField!.text!,
                ]
            loading.mode = MBProgressHUDModeIndeterminate
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
                    })
                    loading.hide(true)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

