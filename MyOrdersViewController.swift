//
//  MyOrdersViewController.swift
//  BrillCreation
//
//  Created by mac on 27/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var orderTableView: UITableView!
    var myOrders = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> myOrdersCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myOrderCell", forIndexPath: indexPath) as! myOrdersCell
        if indexPath.row == 0 {
            
        }
               return cell
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
