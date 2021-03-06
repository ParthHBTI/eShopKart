//
//  CategoryItemsVC.swift
//  eShopKart
//
//  Created by Apple on 22/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import UIKit

class CategoryItemListVC: BaseViewController,UITableViewDelegate{
    
    var categoryName: String!
    @IBOutlet var categoryNameLabel: UILabel!
    var subcategoryItemsArr: NSArray = ["Mobiles","Mobile Accessories","Televisions","Large Appliances","Networking & Peripherals","Kitchen Appliances","Healthcare Appliances","Audio & Videos","Gaming","Laptops"]

    @IBOutlet var cteagoryItemsTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryNameLabel!.text = categoryName!
        self.cteagoryItemsTblView.rowHeight = 50

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

      func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return subcategoryItemsArr.count
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CategoryItemsViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryItemsCell", forIndexPath: indexPath) as! CategoryItemsViewCell
        cell.subCategoryItemName?.text = subcategoryItemsArr.objectAtIndex(indexPath.row)as? String

        // Configure the cell...

        return cell
    }
    
    @IBAction func crossAction(sender: AnyObject) {
        
            self.navigationController?.popViewControllerAnimated(false)
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
