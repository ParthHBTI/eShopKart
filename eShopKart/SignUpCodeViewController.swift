//
//  SignUpCodeViewController.swift
//  eShopKart
//
//  Created by mac on 03/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class SignUpCodeViewController: TextFieldViewController {
    @IBOutlet var codeTextField: UITextField!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(SignUpCodeViewController.crossBtnAction))
            self.navigationItem.setRightBarButtonItem(crossBtnItem, animated: true)
            codeTextField.delegate = self
    // Do any additional setup after loading the view.
    }
   
    @IBAction func submitAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if codeTextField.text!.isEmpty == true {
            loading.labelText = "Code can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else if (codeTextField.text != "123456") {
            loading.labelText = "You enter wrong code, Please try again"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else {
            let storyboard = UIStoryboard(name: "Login" , bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("SetPassID") as? SignUpPassViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    @IBAction func resendAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        loading.labelText = "Successfully send code in your Email ID"
        loading.yOffset = -55.0
        loading.hide(true, afterDelay: 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func crossBtnAction() {
    
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
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
