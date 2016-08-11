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
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        if pageId == 1{
            self.navigationItem.title = "About Us"
        } else if pageId == 2 {
            self.navigationItem.title = "Privacy Policy"
        } else {
            self.navigationItem.title = "Customer Support"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
