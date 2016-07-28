//
//  MyOredrNumberVC.swift
//  BrillCreation
//
//  Created by mac on 27/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class MyOredrNumberVC: UITableViewController {

    var myOrderArray = NSArray()
    var total = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderNumberCell", forIndexPath: indexPath) as! MyOrderNumberCell
        cell.totalOrderedItems?.tintColor = UIColor.blueColor()
        cell.orderNumber.text = myOrderArray.objectAtIndex(indexPath.row)["order_number"] as? String
        cell.dateLbl.text = myOrderArray.objectAtIndex(indexPath.row)["orderdate"] as? String
        cell.status.text = myOrderArray.objectAtIndex(indexPath.row)["status"] as? String
        cell.totalOrderedItems!.text = myOrderArray.objectAtIndex(indexPath.row)["total_ordered_item"] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let userInfo = [
            "order_id" : self.myOrderArray.objectAtIndex(indexPath.row)["order_id"] as! String
            ]
        SigninOperaion.get_request_details(userInfo, completionClosure: { response in
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("MyOrdersIdentityID") as! MyOrdersViewController
            let total = self.myOrderArray.objectAtIndex(indexPath.row)["total_ordered_item"]
            let myInt = (total as! NSString).integerValue
            destinationVC.totalItems = myInt
            destinationVC.myOrders = response as! NSArray
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }

//        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        let destinationVC = storyboard.instantiateViewControllerWithIdentifier("MyOrdersIdentityID") as! MyOrdersViewController
//        let total = myOrderArray.objectAtIndex(indexPath.row)["total_ordered_item"]
//        let myInt = (total as! NSString).integerValue
//        destinationVC.totalItems = myInt
//        self.navigationController?.pushViewController(destinationVC, animated: true)

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
