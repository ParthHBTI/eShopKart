//
//  AddNewAddressVC.swift
//  BrillCreation
//
//  Created by mac on 15/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class AddNewAddressVC: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var landmark: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var alternateMoNo: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAndContinue(sender: AnyObject) {
        let userInfo = [
            "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
            "fullname" : userName.text! as String,
            "address" : address.text! as String,
            "city" : city.text! as String,
            "state" : state.text! as String,
            "zipcode" : zipCode!.text! as String,
            "contact_number" : mobileNo.text! as String,
            "landmark" : landmark.text! as String
        ]
        print(userInfo)
        SigninOperaion.add_address(userInfo, completionClosure: { response in
            print(response)
            if let _: AnyObject = response.valueForKey("User")?.valueForKey("token_id") {
                let noOfAddresses =	response.valueForKey("User")?.valueForKey("code") as! String
                NSUserDefaults.standardUserDefaults().setValue(noOfAddresses, forKey: "code")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
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
