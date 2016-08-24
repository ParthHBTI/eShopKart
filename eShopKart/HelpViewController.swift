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
}
