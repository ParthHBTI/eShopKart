//
//  userRegisterViewController.swift
//  eShopKart
//
//  Created by Apple on 22/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import UIKit
import Foundation

class UserRegistrationVC: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var contactNumberTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPassTextField: UITextField!
    @IBOutlet var DoneBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.setLeftImage(UIImage(named: "person_icon.png")!)
       self.lastNameTextField.setLeftImage(UIImage(named: "person_icon.png")!)
        self.mailTextField.setLeftImage(UIImage(named: "mail")!)
        self.contactNumberTextField.setLeftImage(UIImage(named: "contact_img2.png")!)
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
     //   let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        if firstNameTextField.text!.isEmpty == true || lastNameTextField.text!.isEmpty == true || mailTextField.text!.isEmpty == true || contactNumberTextField.text!.isEmpty == true || passwordTextField.text!.isEmpty == true || confirmPassTextField.text!.isEmpty == true {
        
          //      loading.mode = MBProgressHUDMode .Text
             //   loading.detailsLabelText = "please enter all values here!"
             //   loading.hide(true, afterDelay: 2)
             //   loading.removeFromSuperViewOnHide = true
        }
        else if (passwordTextField.text!.characters.count) < 5 {
        
            // loading.mode = MBProgressHUDMode.Text
            //loading.detailsLabelText = "password length must be of 5 characters!"
            //loading.hide(true, afterDelay: 2)
            //  loading.removeFromSuperViewOnHide = true
            
        
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

}
