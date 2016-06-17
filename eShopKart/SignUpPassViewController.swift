//
//  SignUpPassViewController.swift
//  eShopKart
//
//  Created by mac on 03/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class SignUpPassViewController:TextFieldViewController {
    @IBOutlet var setPassTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setPassTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func finalAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        if setPassTextField.text!.isEmpty == true {
            loading.labelText = "Password can not be empty"
            loading.yOffset = -55.0
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("homePageViewIdentifier") as? HomeViewController
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
