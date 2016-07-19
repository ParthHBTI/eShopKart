//
//  AddressViewController.swift
//  BrillCreation
//
//  Created by mac on 15/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
class AddressViewController: UITableViewController {
    var addressArray = NSMutableArray()
    var currentSelectedCell = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userInfo = [
            "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
        ]
        SigninOperaion.get_address(userInfo, completionClosure: { response in
            print(response)
            var values: AnyObject = []
            values = response
            for var dic in values as! NSArray{
                self.addressArray.addObject(dic)
            }
            self.tableView.reloadData()
            print("\n\n\n\n\n\n\(self.addressArray)")
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
            
        }
    }

    @IBAction func editAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main" , bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("addNewAddID") as? AddNewAddressVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func deleteAction1 (sender: AnyObject) {
              let userInfo = [
            "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id")!,
            "address_id" : ""
        ]
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        SigninOperaion.delete_address(userInfo, completionClosure: { [weak self] response in
            if let weakSelf = self {
                let  resp: NSDictionary = response as! NSDictionary
                if resp.valueForKey("message") as! String == "Success" {
                    loading.mode = MBProgressHUDModeText
                    loading.labelText = "Success!!!"
                    loading.detailsLabelText = "Address deleted successfully"
                    weakSelf.addressArray.removeObjectAtIndex(weakSelf.currentSelectedCell)
                    if weakSelf.addressArray.count==0 {
                        weakSelf.tableView.reloadData()
                    } else {
                        weakSelf.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: weakSelf.currentSelectedCell, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Right)
                    }
                } else {
                    loading.mode = MBProgressHUDModeText
                    loading.labelText = "Error!!!"
                    loading.detailsLabelText = resp.valueForKey("message") as! String
                }
            }
            loading.hide(true, afterDelay: 2)
            }, havingError: { [weak self] error in
                loading.mode = MBProgressHUDModeText
                loading.labelText = "Error!!!"
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
                print(error.localizedDescription)
            })
        
        SigninOperaion.delete_address(userInfo, completionClosure: { response in
            print(response)
            var values: AnyObject = []
            values = response
            for var dic in values as! NSArray{
                self.addressArray.addObject(dic)
            }
            self.tableView.reloadData()
            print("\n\n\n\n\n\n\(self.addressArray)")
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }

    }
    @IBAction func selectAddress(sender: AnyObject) {
        let isButtonClick = sender.tag
        if isButtonClick != nil {
            sender.tag
        }
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
        return  addressArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addressIdentity", forIndexPath: indexPath) as! AddressViewCell
        cell.addressTextField.font?.fontWithSize(15)
        cell.deleteButton.addTarget(self, action:  #selector(AddressViewController.deleteAction1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
         cell.selectionBtn.addTarget(self, action:  #selector(AddressViewController.selectAddress(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.editButton.addTarget(self, action:  #selector(AddressViewController.editAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.userName?.text = addressArray.objectAtIndex(indexPath.row)["fullname"] as? String
        cell.addressTextField.text = addressArray.objectAtIndex(indexPath.row)["fullAddress"] as? String
            cell.editButton.hidden = true
            cell.deleteButton.hidden = true
            cell.selectionBtn.tintColor = UIColor.blackColor()
      return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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


