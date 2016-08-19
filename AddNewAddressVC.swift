//
//  AddNewAddressVC.swift
//  BrillCreation
//
//  Created by mac on 15/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI

class AddNewAddressVC: UIViewController, UIScrollViewDelegate, UITextViewDelegate,UITextFieldDelegate {
    
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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var guiView: UIView!
    
    var addressInfo = NSMutableArray()
    var addressInfoDic = NSDictionary()
    var address_id = NSString()
    var flagPoint = Bool()
    var checkdefault = false
    var addEdit = false
    
    override func viewDidLayoutSubviews()  {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: view.frame.size.height + 300);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(AddNewAddressVC.handleTap(_:)))
        self.view .addGestureRecognizer(tapRecognizer)
        landmark.delegate = self
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = "New Address"
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(AddNewAddressVC.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        zipCode.delegate = self
        city.delegate = self
        mobileNo.delegate = self
        alternateMoNo.delegate = self
        userName.delegate = self
        address.delegate = self
        state.delegate = self
        landmark.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: view.frame.size.height );
        scrollView.setNeedsDisplay()
        if flagPoint {
            userName.text = addressInfoDic.objectForKey("fullname") as? String
            zipCode.text  = addressInfoDic.objectForKey("zipcode") as? String
            city.text = addressInfoDic.objectForKey("city") as? String
            address.text = addressInfoDic.objectForKey("address") as? String
            landmark.text = addressInfoDic.objectForKey("landmark") as? String
            state.text = addressInfoDic.objectForKey("state") as? String
            mobileNo.text = addressInfoDic.objectForKey("contactnumber") as? String
            alternateMoNo.text = addressInfoDic.objectForKey("alternatenumber") as? String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAndContinue(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        addEdit = true
        if self.flagPoint {
            if zipCode.text!.isEmpty == true || userName.text!.isEmpty == true || address.text!.isEmpty == true || state.text!.isEmpty == true || city.text!.isEmpty == true || mobileNo.text!.isEmpty == true || landmark.text!.isEmpty == true {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "please enter all values here!"
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
            } else if (mobileNo.text!.characters.count) < 10 || (mobileNo.text!.characters.count) > 10 {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "Mobile Number is not valid !"
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
            } else if (zipCode.text!.characters.count) < 6 || (zipCode.text!.characters.count) > 6 {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "ZipCode is not valid !"
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
            }else {
                let userInfo = [
                    "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
                    "fullname" : userName!.text!,
                    "address" : address!.text!,
                    "city" : city!.text! ,
                    "state" : state.text! as String,
                    "zipcode" : zipCode!.text! as String,
                    "contact_number" : mobileNo.text! as String,
                    "landmark" : landmark.text! as String,
                    "address_id" : address_id
                ]
                SigninOperaion.add_address(userInfo, completionClosure: { response in
                    print(response)
                }) { (error: NSError) -> () in
                    let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    loading.mode = MBProgressHUDModeText
                    loading.detailsLabelText = error.localizedDescription
                    loading.hide(true, afterDelay: 2)
                }
                let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("AddressVCIdentifier") as? AddressViewController
                vc?.checkDefault = checkdefault
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        } else {
            if zipCode.text!.isEmpty == true || userName.text!.isEmpty == true || address.text!.isEmpty == true || state.text!.isEmpty == true || city.text!.isEmpty == true || mobileNo.text!.isEmpty == true  {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "please enter all values here!"
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
            } else if (mobileNo.text!.characters.count) < 10 || (mobileNo.text!.characters.count) > 10 {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "Mobile Number is not valid !"
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
            } else if (zipCode.text!.characters.count) < 6 || (zipCode.text!.characters.count) > 6 {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "ZipCode is not valid !"
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
            } else {
                let userInfo = [
                    "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
                    "fullname" : userName!.text!,
                    "address" : address!.text!,
                    "city" : city!.text! ,
                    "state" : state.text! as String,
                    "zipcode" : zipCode!.text! as String,
                    "contact_number" : mobileNo.text! as String,
                    "landmark" : landmark.text! as String,
                    ]
                SigninOperaion.add_address(userInfo, completionClosure: { response in
                    print(response)
                    
                }) { (error: NSError) -> () in
                    let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    loading.mode = MBProgressHUDModeText
                    loading.detailsLabelText = error.localizedDescription
                    loading.hide(true, afterDelay: 2)
                }
                let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("AddressVCIdentifier") as? AddressViewController
                vc?.checkDefault = checkdefault
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    
    func textFieldDidChange() {
        userName.text = userName.text
        city.text = city.text
        mobileNo.text = mobileNo.text
        landmark.text = landmark.text
        zipCode.text = zipCode.text
        address.text = address .text
        state.text = state.text
    }
    
    func handleTap(tapGesture: UIGestureRecognizer) {
        self.view .endEditing(true)
    }
    
    @IBAction func defaultAction(sender: UIButton) {
        checkdefault = true
        checkBtn.tintColor = UIColor.blueColor()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            address.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        userName.text = ""
        zipCode.text  = ""
        city.text = ""
        address.text = ""
        landmark.text = ""
        state.text = ""
        mobileNo.text = ""
        alternateMoNo.text = ""
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let keyboardDoneButtonShow = UIToolbar(frame: CGRectMake(0, 0,  self.view.frame.size.width, self.view.frame.size.height/17))
        keyboardDoneButtonShow.barStyle = UIBarStyle .BlackTranslucent
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(UITextFieldDelegate.textFieldShouldReturn(_:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let toolbarButton = [flexSpace,doneButton]
        keyboardDoneButtonShow.setItems(toolbarButton, animated: false)
        mobileNo.inputAccessoryView = keyboardDoneButtonShow
        alternateMoNo.inputAccessoryView = keyboardDoneButtonShow
        return true
        
    }
    
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count == 0 {
            return true
        }
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        switch textField {
            
        case mobileNo:
            return prospectiveText.characters.count <= 10
            
        case alternateMoNo:
            return prospectiveText.characters.count <= 10
            
        default:
            return true
        }
    }
    
    func backAction() {
        for controller: UIViewController in self.navigationController!.viewControllers {
            if (controller is AddressViewController) {
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }
    }
}
