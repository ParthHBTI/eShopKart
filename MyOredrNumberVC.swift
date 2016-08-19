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
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(AddressViewController.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("MyOrdersIdentityID1") as! MyOrdersTableVC
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func backAction() {
        for controller: UIViewController in self.navigationController!.viewControllers {
            if (controller is UserProfileViewController) {
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }
    }
}
