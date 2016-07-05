//
//  FeedbackViewController.swift
//  eShopKart
//
//  Created by Hemendra Singh on 14/04/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit
import AFNetworking

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var subTxtField: UITextField!
    @IBOutlet weak var feedbackTxtView: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = "Feedback"
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        submitBtn.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitAction(sender: AnyObject) {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        loading.hide(true, afterDelay: 2)
        loading.removeFromSuperViewOnHide = true
        if subTxtField.text!.isEmpty == true || feedbackTxtView.text!.isEmpty == true {
            
            loading.detailsLabelText = "please enter all values here!"
        }else {
        
            let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
            let userInfo :[String : String] = [
                "user_id" : userId as! String,
                "subject" : subTxtField.text!,
                "message" : feedbackTxtView.text!
            ]
            let params: [NSObject : AnyObject] = userInfo
            let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
            let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
            manager.requestSerializer = requestSerializer
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
            manager.POST("http://192.168.0.15/eshopkart/webservices/user_feedback", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
                print("response: \(response!)")
                //self.cartDetailResponseArr = response
                //self.tableView.reloadData()
                loading.detailsLabelText = response["message"] as! String
                
            }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
                
                print("error: \(error!)")
                
            }
        }
    }
    
    func backAction(){
    
        self.navigationController?.popViewControllerAnimated(true)
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
