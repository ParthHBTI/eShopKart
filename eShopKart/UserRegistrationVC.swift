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
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        mailTextField.delegate = self
        confirmPassTextField.delegate = self
        contactNumberTextField.delegate = self
        passwordTextField.delegate = self
        self.firstNameTextField.setLeftImage(UIImage(named: "person_icon.png")!)
       self.lastNameTextField.setLeftImage(UIImage(named: "person_icon.png")!)
        self.contactNumberTextField.setLeftImage(UIImage(named: "mobile.png")!)
        self.mailTextField.setLeftImage(UIImage(named: "mail")!)
//       self.contactNumberTextField.setLeftImage(UIImage(named: "contact_img.png")!)
        self.passwordTextField.setLeftImage(UIImage(named: "password_icon.png")!)
       self.confirmPassTextField.setLeftImage(UIImage(named: "password_icon.png")!)
        self.DoneBtn.layer.cornerRadius = 20
        //self.doneBtn.setCornerRadius(10.0, width: 0.0, color: UIColor.clearColor())
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitAction(sender: AnyObject) {
    let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        if firstNameTextField.text!.isEmpty == true || lastNameTextField.text!.isEmpty == true || mailTextField.text!.isEmpty == true || contactNumberTextField.text!.isEmpty == true || passwordTextField.text!.isEmpty == true || confirmPassTextField.text!.isEmpty == true {
        
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "please enter all values here!"
            loading.hide(true, afterDelay: 2)
             loading.removeFromSuperViewOnHide = true
        }
        else if (passwordTextField.text!.characters.count) < 5 {
        
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "password length must be of 5 characters!"
            loading.hide(true, afterDelay: 2)
             loading.removeFromSuperViewOnHide = true
        } else {
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeIndeterminate
            loading.hide(true, afterDelay: 2)
            if mailTextField.text!.isValidEmail() == true {
                    let firstname = firstNameTextField.text! as String
                    let lastname = lastNameTextField.text! as String
                    let emailID = mailTextField.text! as String
                    let password = passwordTextField.text! as String
                    let mobile = contactNumberTextField.text! as String
                        let myUrl = NSURL(string: "http://192.168.0.3/eshopkart/webservices/signup")
                    let request = NSMutableURLRequest(URL:myUrl!);
                    request.HTTPMethod = "POST";
                    let form1 = "firstname=\(firstname)&lastname=\(lastname)&email=\(emailID)&password=\(password)&mobile=\(mobile)"
                    //let form1 = "email=kamleshhbti@hotmail.com"
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
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                    print(form1)

            } else {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "Please Enter Valid Email ID!"
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
            }
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


