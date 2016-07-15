//
//  VerificationCodeViewController.swiftchangepassword//  eShopKart
//
//  Created by mac on 07/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class VerificationCodeViewController: TextFieldViewController {
    
    @IBOutlet var verificationTextField: UITextField!
    @IBOutlet weak var verifyAccBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationTextField.delegate = self
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        loading.yOffset = -47.0
        loading.detailsLabelText = "Verification Code has been send successfully in your Email ID"
        loading.hide(true, afterDelay: 3)
        loading.removeFromSuperViewOnHide = true
        let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(VerificationCodeViewController.crossBtnAction))
        self.navigationItem.setRightBarButtonItem(crossBtnItem, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verifyCodeAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        if (verificationTextField.text == "" ) {
            loading.mode = MBProgressHUDModeIndeterminate
            let alert = UIAlertView.init(title: "Oppss", message: "Please Enter Your Verify Code", delegate: self, cancelButtonTitle: "GO")
              //alert.dismissWithClickedButtonIndex(1, animated: true)
            alert.show()
            loading.hide(true)
            //self.makeVerifyAlert()
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
            print(userInfo["email"])
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
    
    func animateVerifyAccBtnOnWrongSubmit(){
        let bounds = self.verifyAccBtn.bounds
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .CurveEaseOut, animations: {
            self.verifyAccBtn.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.verifyAccBtn.enabled = true
            }, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func makeVerifyAlert()
    {
        let refreshAlert = UIAlertController(title: "Please Login", message: "To make this action, please login first.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            //let storyboard = UIStoryboard(name: "Login" , bundle:  nil)
            let vc = self//storyboard.instantiateViewControllerWithIdentifier("VerificationCodeIdentifire") as?
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func crossBtnAction() {
        self.navigationController?.dismissViewControllerAnimated(false, completion: nil)
        
    }

    
}

