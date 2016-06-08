//
//  VerificationCodeViewController.swiftchangepassword//  eShopKart
//
//  Created by mac on 07/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class VerificationCodeViewController: TextFieldViewController {
    @IBOutlet var verificationTextField: UITextField!

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
        if (verificationTextField.text == "" || verificationTextField.text != "123456") {
            let alert = UIAlertView.init(title: "Oppss", message: "Please Enter Your Verify Code", delegate: self, cancelButtonTitle: "GO")
            alert.show()
        } else  {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("ResetPasswordIdentifire") as? ResetPasswordViewController
            self.navigationController?.pushViewController(vc!, animated: true)
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

