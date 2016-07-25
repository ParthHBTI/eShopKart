//
//  FeedbackViewController.swift
//  eShopKart
//
//  Created by Hemendra Singh on 14/04/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit
import AFNetworking

class FeedbackViewController: TextFieldViewController {
    
    @IBOutlet weak var subTxtField: UITextField!
    @IBOutlet weak var feedbackTxtView: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        subTxtField.delegate = self
        feedbackTxtView.delegate = self
        //        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = "Feedback"
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        submitBtn.addBorderWithColor(UIColor.whiteColor(), borderWidth: 1.0)
        submitBtn.layer.cornerRadius = 5.0
        feedbackTxtView.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.view .endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitAction(sender: AnyObject) {
        if subTxtField.text!.isEmpty == true || feedbackTxtView.text!.isEmpty == true {
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            loading.detailsLabelText = "please give all values"
            self.animateSubmitBtnOnWrongSubmit()
        }
        else {
            let isRegisteredUser = NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
            if isRegisteredUser != nil {
                let feedabackInfo :[String : String] = [
                    "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
                    "subject" : subTxtField.text!,
                    "message" : feedbackTxtView.text!
                ]
                SigninOperaion.userFeedback(feedabackInfo, completionClosure: { (response: AnyObject) -> () in
                    print(response)
                }) { (error:NSError) -> () in
                    let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    loading.mode = MBProgressHUDModeText
                    loading.detailsLabelText = error.localizedDescription
                    loading.hide(true, afterDelay: 2)
                }
                self.subTxtField.text = ""
                self.feedbackTxtView.text = ""
            } else {
                self.makeLoginAlert()
            }
        }
    }
    
    //    func backAction() {
    //
    //        self.navigationController?.popViewControllerAnimated(true)
    //    }
    
    func animateSubmitBtnOnWrongSubmit(){
        let bounds = self.submitBtn.bounds
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .CurveEaseOut, animations: {
            self.submitBtn.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.submitBtn.enabled = true
            }, completion: nil)
    }
    
    func makeLoginAlert()
    {
        let refreshAlert = UIAlertController(title: "Please Login", message: "To make this action, please login first.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            let storyboard = UIStoryboard(name: "Login" , bundle:  nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
            let navController = UINavigationController(rootViewController: vc!)
            self.navigationController?.presentViewController(navController, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
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
