//
//  VerificationCodeViewController.swift
//  eShopKart
//
//  Created by mac on 25/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class VerificationCodeViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet var verifyCodeField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.verifyCodeField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
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
