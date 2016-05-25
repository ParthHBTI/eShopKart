//
//  ESKCategoryTableVC.swift
//  eShopKart
//
//  Created by mac on 12/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
class ESKCategoryTableVC: BaseViewController , UITableViewDelegate {
    
    @IBOutlet var categoryTblView: UITableView!
    @IBOutlet var categoryArray: NSArray! = ["ELECTRONICS" , "HOME & APPLIANCES" , "LIFESTYLE" , "AUTOMOTIVE" , "BOOKS & MORE" , " DAILY NEEDS", "SPORTS & OUTDOORS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.categoryTblView.rowHeight = 60

    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.leftItemsSupplementBackButton = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
   }
//
//    override func viewDidAppear(animated: Bool) {
//  
//        self.navigationItem.leftItemsSupplementBackButton = false
//    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categoryArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ESKCategoryCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Identifier", forIndexPath: indexPath) as! ESKCategoryCell
            cell.textLabel!.text = categoryArray.objectAtIndex(indexPath.row) as?  String
            //CategoryItemListVC.categoryNameLabel?.text
        

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as! CategoryItemListVC
        let cell = sender as! ESKCategoryCell
        print(cell.textLabel!.text)
        destinationVC.categoryName = cell.textLabel!.text
    }
    
    
    
//    optional func tableView(_ tableView: UITableView,
//                              didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//    
//        
//    }
//    

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
