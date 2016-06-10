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
                let storyboard = UIStoryboard(name: "Main" , bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
                self.navigationController?.pushViewController(vc!, animated: true)
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
