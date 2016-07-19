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
    var addressInfo = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userInfo = [
            "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
            ]
        SigninOperaion.get_address(userInfo, completionClosure: { response in
            print(response)
            var values: AnyObject = []
            values = response
            for var dic in values as! NSArray{
                self.addressInfo.addObject(dic)
            }
            print(self.addressInfo)
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }

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
        SigninOperaion.add_address(userInfo, completionClosure: { response in
           print(response)
            let storyboard = UIStoryboard(name: "Main" , bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AddressIdentity") as? AddressViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)

        }

        
    }
    @IBAction func cancelAction(sender: AnyObject) {
        if (self.navigationController?.topViewController?.isKindOfClass(AddNewAddressVC)) == false{
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AddressIdentity") as? AddressViewController
            let navController = UINavigationController(rootViewController: vc!)
            self.presentViewController(navController, animated: true, completion: nil)
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
