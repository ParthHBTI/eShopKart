//
//  ProfileSettingViewController.swift
//  BrillCreation
//
//  Created by Hemendra Singh on 28/04/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit

class ProfileSettingViewController: UIViewController {

    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var mobNumberLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userFullName = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
        var myStringArr = userFullName!.componentsSeparatedByString(" ")
            firstNameTxtField.text = myStringArr[0]
            lastNameTxtField.text = myStringArr.count > 1 ? myStringArr[myStringArr.count - 1] : nil
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlAction(sender: AnyObject) {
        let userFullName = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
        var myStringArr = userFullName!.componentsSeparatedByString(" ")
        if(segmentControl.selectedSegmentIndex == 0) {
            self.firstNameLbl.text = "First Name"
            self.lastNameLbl.text = "Last Name"
            self.firstNameTxtField.text = myStringArr[0]
            self.lastNameTxtField.text = myStringArr.count > 1 ? myStringArr[myStringArr.count - 1] : nil
            
        }else {
            self.firstNameLbl.text = "Email Address"
            self.lastNameLbl.text = "Mobile Number"
            self.firstNameTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String
            self.lastNameTxtField.text = NSUserDefaults.standardUserDefaults().valueForKey("mobile") as? String
        
        }
    }
    @IBAction func saveBtnAction(sender: AnyObject) {
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
            let params = [
                "user_id" : userId,
                "firstname" : self.firstNameTxtField.text,
                "lastname" : self.lastNameTxtField.text,
                ]
        
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
