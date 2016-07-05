//
//  GeneralWebViewController.swift
//  eShopKart
//
//  Created by Apple on 09/03/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit
import Foundation

class GeneralWebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    var htmlString: String?
    var pageId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: htmlString!)!))
        self.navigationController?.navigationBarHidden = false
        if pageId == 1{
            self.navigationItem.title = "About Us"
        } else if pageId == 2 {
            self.navigationItem.title = "Privacy Policy"
        }
        else {
            self.navigationItem.title = "Customer Support"
        }
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
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
