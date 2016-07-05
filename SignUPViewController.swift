//
//  SignUPViewController.swift
//  eShopKart
//
//  Created by mac on 03/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.

import UIKit
import AFNetworking

class SignUPViewController: TextFieldViewController {
    @IBOutlet var emailTextField: UITextField!
    var firstname = String()
    var lastname = String()
    var password = String()
    var mobile = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if emailTextField.text!.isEmpty == true {
            loading.labelText = "Email can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else {
            if emailTextField.text!.isValidEmail() == true {
                let emailID = emailTextField.text! as? String
                let myUrl = NSURL(string: "http://192.168.0.15/eshopkart/webservices/verification")
                let request = NSMutableURLRequest(URL:myUrl!);
                request.HTTPMethod = "POST";
                let form1 = "firstname=\(firstname)&lastname=\(lastname)&email=\(emailID)&password=\(password)&mobile=\(mobile)"
                //let form1 = "email=kamleshhbti@hotmail.com"
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
                let storyboard = UIStoryboard(name: "Login" , bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpCodeID") as? SignUpCodeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "Please enter valid email id"
                loading.yOffset = -55.0
                loading.hide(true, afterDelay: 2)
            }
            let emailID = emailTextField.text! as String
            let form1 = "email=\(emailID)"
            print(form1)
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


