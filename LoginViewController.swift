//
//  LoginViewController.swift
//  eShopKart
//
//  Created by mac on 25/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
import SinchVerification
class LoginViewController: UIViewController {
    
    var verification: Verification!
    var applicationKey = "a15ab125-a121-4dc9-b4d7-cbd6874262e2"

    @IBOutlet var phoneNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgetVerificationSend(sender: AnyObject) {
        verification = SMSVerification(applicationKey: applicationKey, phoneNumber: phoneNumber.text!);        verification.initiate { (success:Bool, error:NSError?) -> Void in
            print("\(success)")
           // self.disableUI(false);
           let text = (success ? "Verified" : error?.description);
              print("\(text)")
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
