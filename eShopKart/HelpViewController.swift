//
//  HelpViewController.swift
//  eShopKart
//
//  Created by Hemendra Singh on 23/04/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController , UITableViewDelegate{
    
    var faqArr: NSArray = ["How do I change my password","How do I add to cart an Item"]
    var issuesArr:NSArray = ["App Stopped Working","App Crashes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = "Need Help"
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(AddressViewController.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        let screenSize:CGRect = UIScreen.mainScreen().bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return faqArr.count
    }
    
    func backAction() {
        for controller: UIViewController in self.navigationController!.viewControllers {
            if (controller is UserProfileViewController) {
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }
    }
}
