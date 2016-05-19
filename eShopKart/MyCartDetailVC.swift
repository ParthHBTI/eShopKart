//
//  MyCartDetailVC.swift
//  eShopKart
//
//  Created by mac on 16/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
class MyCartDetailVC: BaseViewController, UITableViewDelegate {

    @IBOutlet var tableview: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftItemsSupplementBackButton = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
 func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
 func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MyCartDetailCell{
     let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath) as! MyCartDetailCell
        
        return cell
    }

   

}