//
//  CartItemDetailVC.swift
//  eShopKart
//
//  Created by mac on 13/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
var cartItemArray: NSMutableArray = ["", ""]
class CartItemDetailVC: BaseViewController {

    @IBOutlet var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.leftItemsSupplementBackButton = true
       
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.leftItemsSupplementBackButton = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

    override func viewDidAppear(animated: Bool) {
        //self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.leftItemsSupplementBackButton = true
    }
    
 func numberOfSectionsInTableView(tableView: UITableView) -> Int {
 
        return 1
    }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cartItemArray.count
    }

    @IBAction func removeItemFromCart(sender: AnyObject) {
        
        let button = sender as! UIButton
        let tagValue : Int = button.tag
        
        if (cartItemArray.count > tagValue){
            cartItemArray.removeObjectAtIndex(tagValue)
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "Removed successfully from your cart"
            loading.hide(true, afterDelay:1)
        }
        self.tableView.reloadData()
    }
  
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//     print("You selected cell #\(indexPath.row)!")
//     
//     let indexPath = tableView.indexPathForSelectedRow!
//     let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
//     
//     }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("Cartcell", forIndexPath: indexPath) 
        return cell
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
