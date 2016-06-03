//
//  SignUPViewController.swift
//  eShopKart
//
//  Created by Apple on 11/03/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit

class SignUPViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var mobileNumberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SignUP"
        mobileNumberTextField.delegate = self
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func alreadyHaveAccountAction(sender: AnyObject) {
        
        let storyboard  = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController
        //self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
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
