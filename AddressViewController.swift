//
//  AddressViewController.swift
//  BrillCreation
//
//  Created by mac on 15/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
class AddressViewController: BaseViewController, UITableViewDelegate {
    var addressArray = NSMutableArray()
    var currentSelectedCell = -1
    var tempCell = AddressViewCell()
    var checkOption = false
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userInfo = [
            "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
        ]
        
        SigninOperaion.get_address(userInfo, completionClosure: { response in
            print(response)
            self.addressArray.removeAllObjects()
            var values: AnyObject = []
            //values = response
            for var dic in response as! NSArray{
          self.addressArray.addObject(dic)
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
         self.tableView.reloadData()
    }

    @IBAction func editAction(sender: AnyObject) {
        checkOption = true
        let id = addressArray.objectAtIndex(sender.tag)["id"] as? String
        let itemInfoDic  = addressArray.objectAtIndex(sender.tag) as! NSDictionary
        let destinationVC = storyboard!.instantiateViewControllerWithIdentifier("addNewAddID") as! AddNewAddressVC
        destinationVC.addressInfoDic = itemInfoDic
        destinationVC.flagPoint = checkOption
        destinationVC.address_id = id!
        print(itemInfoDic)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func deleteAction1 (sender: AnyObject) {
        let id = addressArray.objectAtIndex(sender.tag)["id"] as? String
              let userInfo = [
            "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id")!,
            "address_id" : id! as String
        ]
        SigninOperaion.delete_address(userInfo, completionClosure: { response in
            var values: AnyObject = []
            values = response as! NSArray
            print(sender.tag)
            self.addressArray.removeObjectAtIndex(sender.tag)
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
    }
    
    @IBAction func selectAddress(sender: AnyObject) {
        let cell: AddressViewCell = (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: sender.tag, inSection: 0)) as? AddressViewCell)!
        var temp = -1
        let buttonPress = sender.tag
        repeat {
            temp += 1
            cell.selectionBtn!.tintColor = UIColor.blackColor()
        } while (temp != buttonPress)
        if temp == buttonPress {
        cell.editButton.hidden = false
        cell.deleteButton.hidden = false
        cell.selectionBtn!.tintColor = UIColor.blueColor()
        }
        cell.editButton.hidden = false
        cell.deleteButton.hidden = false
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
        return  addressArray.count
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addressIdentity", forIndexPath: indexPath) as! AddressViewCell
        cell.deleteButton!.addTarget(self, action:  #selector(AddressViewController.deleteAction1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
         cell.selectionBtn!.addTarget(self, action:  #selector(AddressViewController.selectAddress(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.editButton!.addTarget(self, action:  #selector(AddressViewController.editAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.userName?.text = addressArray.objectAtIndex(indexPath.row)["fullname"] as? String
        cell.addressTextField.font = UIFont.boldSystemFontOfSize(18.0)
        cell.addressTextField.text = addressArray.objectAtIndex(indexPath.row)["fullAddress"] as? String
            cell.editButton.hidden = true
           cell.deleteButton.hidden = true
        cell.editButton!.tag = indexPath.row
        cell.selectionBtn!.tag = indexPath.row
        cell.deleteButton!.tag = indexPath.row
        tempCell = cell
      return cell
    }
    
  
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let addDic = addressArray.objectAtIndex(indexPath.row) as! NSDictionary
        print(addDic)
       
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.leftItemsSupplementBackButton = false
    }
    
    override func backAction() {
        for controller: UIViewController in self.navigationController!.viewControllers {
            if (controller is UserProfileViewController) {
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }
        }

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



