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
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
        manager.POST("http://192.168.0.13/eshopkart/webservices/login_user", parameters: nil, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
            print("Response: \(response!)")
            
        }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
            
            print("error: \(error!)")
            
        }

        self.emailMobileTextField.setLeftImage(UIImage(named: "icon_user.png")!)
        self.passwordTextField.setLeftImage(UIImage(named: "icon_password.png")!)
        emailMobileTextField.delegate = self
        passwordTextField.delegate = self
        navigationController?.navigationBarHidden = false
        let nav = navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        //if
        title = "Login"
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        //
        let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(crossBtnAction))
        //
        self.navigationItem.setRightBarButtonItem(crossBtnItem, animated: true)
        
    }
    
    @IBAction func loginACtion(sender: UIButton) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if emailMobileTextField.text!.isEmpty == true {
            loading.labelText = "Email can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        }
        else if passwordTextField.text!.isEmpty == true {
            loading.labelText = "Password can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else {
            if emailMobileTextField.text!.isValidEmail() == true {
                
            }
            let myUrl = NSURL(string: "http://192.168.0.13/eshopkart/webservices/login_user")
            let request = NSMutableURLRequest(URL:myUrl!);
            request.HTTPMethod = "POST";
            let emailID = emailMobileTextField.text! as String
            let pass = passwordTextField.text! as String
            let form1 = "email=\(emailID)&password=\(pass)"
            print(form1)
            request.HTTPBody = form1.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
                print("response = \(response)")
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
            }
            task.resume()
            
                }
    }
    
    @IBAction func forgetAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("VerificationCodeIdentifire") as? VerificationCodeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   
}

extension String {
    
    
    
    func isValidEmail() -> Bool {
        //  let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9._%+]+@(?:[A-Z0-9]+\\.)+[A-Z]{2,}$", options: .CaseInsensitive)
        return regex?.firstMatchInString(self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
    
}