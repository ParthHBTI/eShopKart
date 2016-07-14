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
        submitBtn.layer.cornerRadius = 5.0
        submitBtn.layer.borderWidth = 1.0
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
            let feedabackInfo :[String : String] = [
                "subject" : subTxtField.text!,
                "message" : feedbackTxtView.text!
            ]
           
            SigninOperaion.userFeedback(feedabackInfo, completionClosure: { (response: AnyObject) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.removeFromSuperViewOnHide = true
                loading.detailsLabelText = "Thanks for contacting us. We will get back to you shortly."
                loading.hide(true, afterDelay: 2)
                self.subTxtField.text = ""
                self.feedbackTxtView.text = ""
                print(response)
            }) { (error:NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
