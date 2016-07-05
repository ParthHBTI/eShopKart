//
//  PreSignUPVC.swift
//  eShopKart
//
//  Created by Hemendra Singh on 09/04/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit

class PreSignUPVC: UIViewController {

    @IBOutlet weak var privacyPolicyBtn: UIButton!
    @IBOutlet weak var aboutUsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attrs = [
            NSFontAttributeName : UIFont.systemFontOfSize(12.0),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue
        ]
        let attributedString = NSMutableAttributedString(string:"")
        let attributedString2 = NSMutableAttributedString(string:"")
        
        let aboutUsStr = NSMutableAttributedString(string:"Terms & Conditions", attributes:attrs)
        attributedString.appendAttributedString(aboutUsStr)
        aboutUsBtn!.setAttributedTitle(attributedString, forState: .Normal)
        
        let ppStr = NSMutableAttributedString(string:"Privacy Policy", attributes:attrs)
        attributedString2.appendAttributedString(ppStr)
        privacyPolicyBtn!.setAttributedTitle(attributedString2, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
            //self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func SigninWithFB(sender: AnyObject) {
        
        
        
    }
    
    @IBAction func SigninWithTwitter(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func aboutUsAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("GeneralWebVCIdentifier") as? GeneralWebViewController
        let	url = NSString(format: "%@/1", contentURL) as String
        vc?.htmlString = url
        vc?.pageId = 1
        //self.presentViewController(vc!, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @IBAction func privacyPolicyAction(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("GeneralWebVCIdentifier") as? GeneralWebViewController
        let	url = NSString(format: "%@/2", contentURL) as String
        vc?.htmlString = url
        vc?.pageId = 2
        //self.presentViewController(vc!, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc!, animated: false)
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
