//
//  SignUpCodeViewController.swift
//  eShopKart
//
//  Created by mac on 03/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class SignUpCodeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textCode1: UITextField!
    @IBOutlet var textCode2: UITextField!
    @IBOutlet var textCode3: UITextField!
    @IBOutlet var textCode4: UITextField!
    @IBOutlet var textCode5: UITextField!
    @IBOutlet var textCode6: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textCode1.delegate = self
        textCode2.delegate = self
        textCode3.delegate = self
        textCode4.delegate = self
        textCode5.delegate = self
        textCode6.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.characters.count < 1 && string.characters.count > 0) {
            let nextTag = textField.tag + 1
            var nextResponder = textField.superview?.viewWithTag(nextTag)
            if (nextResponder == nil) {
                nextResponder = textField.superview?.viewWithTag(1)
            }
            textField.text = string
            nextResponder?.becomeFirstResponder()
            return false
        } else if (textField.text?.characters.count >= 1 && string.characters.count == 0) {
            let previousTag = textField.tag - 1
            var previousResponder = textField.superview?.viewWithTag(previousTag)
            if (previousResponder == nil) {
                previousResponder = textField.superview?.viewWithTag(1)
            }
            textField.text = ""
            previousResponder?.becomeFirstResponder()
            return false
        }
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == textCode1) {
            textField.resignFirstResponder()
            textCode2.becomeFirstResponder()
        } else if (textField == textCode2) {
            textField.resignFirstResponder()
            textCode3.becomeFirstResponder()
        } else if (textField == textCode3) {
            textField.resignFirstResponder()
            textCode4.becomeFirstResponder()
        } else if (textField == textCode4) {
            textField.resignFirstResponder()
            textCode5.becomeFirstResponder()
        } else if (textField == textCode5) {
            textField.resignFirstResponder()
            textCode6.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            textCode6.becomeFirstResponder()
            self.view.endEditing(true)
        }
        return true
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
