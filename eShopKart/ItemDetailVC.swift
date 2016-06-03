//
//  ItemDetailVC.swift
//  eShopKart
//
//  Created by Apple on 23/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//
import UIKit
class ItemDetailVC: BaseViewController{
    
    @IBOutlet var ItemDetailTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ItemDetailTblView.rowHeight = 170
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
//            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//            self.ItemDetailTblView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
            let cell1 = tableView.dequeueReusableCellWithIdentifier("ImageViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
            return cell1
        }
         if(indexPath.row == 1) {
            let cell2 = tableView.dequeueReusableCellWithIdentifier("PriceViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
            return cell2
        }
           let cell3 = tableView.dequeueReusableCellWithIdentifier("DetailViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
            return cell3
        
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
    @IBAction func addToCart(sender: AnyObject) {
     cartItemArray.addObject("")
       let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        loading.detailsLabelText = "Product has been added to your cart successfully!"
        loading.hide(true, afterDelay: 2)
        loading.removeFromSuperViewOnHide = true
        //self.navigationItem.rightBarButtonItem?.badgeValue = "1"
    }
    
//    func clearChatBadge() {
//        // Set bacdge for Chat
//        let navArray = self.navigationController?.navigationBar.items as NSArray!
//        let navItem = navArray.objectAtIndex(3) as! UINavigationItem
//         navItem.rightBarButtonItem?.badgeValue = nil
//    }

}
