//
//  MyOrdersTableVC.swift
//  BrillCreation
//
//  Created by mac on 08/08/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class MyOrdersTableVC: UITableViewController {
    var myOrders = NSArray()
    var totalItems = Int()
    var productsData = NSDictionary()
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(MyOrdersTableVC.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalItems
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myOrderCell", forIndexPath: indexPath) as! myOrdersCell
        let url = NSURL(string:(imageURL + (myOrders.objectAtIndex(indexPath.row)["image"] as? String)!))
        cell.productImage?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
        cell.productName.text = myOrders.objectAtIndex(indexPath.row)["product_name"] as? String
        cell.totalItems.text = myOrders.objectAtIndex(indexPath.row)["quantity"] as? String
        cell.grandTotal.text = "nil"
        cell.productStatusDate.text = myOrders.objectAtIndex(indexPath.row)["orderdate"] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        flag = true
        let userInfo = [
            "product_id" : myOrders.objectAtIndex(indexPath.row)["product_id"] as! String
            ] as NSDictionary
        SigninOperaion.get_product_details(userInfo, completionClosure: { response in
            self.productsData = (response as! NSDictionary)
            let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
            let itemInfoDic  = self.productsData as! Dictionary<String, AnyObject>
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("ImageID") as! ImageViewController
            destinationVC.getProductInfoDic = itemInfoDic
            destinationVC.productQnty = self.myOrders.objectAtIndex(indexPath.row)["quantity"] as! String
            destinationVC.checkFlag = self.flag
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
    }
    
    func backAction() {
        for controller: UIViewController in self.navigationController!.viewControllers {
            if (controller is UserProfileViewController) {
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }
    }
}
