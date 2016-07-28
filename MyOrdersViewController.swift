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
    var myOrders = NSArray()
    var totalItems = Int()
    var productsData = NSDictionary()
    var flag = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myOrders.count)
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
        return totalItems 
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> myOrdersCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myOrderCell", forIndexPath: indexPath) as! myOrdersCell
        let url = NSURL(string:(imageURL + (myOrders.objectAtIndex(indexPath.row)["image"] as? String)!))
        cell.productImage?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
        cell.productName.text = myOrders.objectAtIndex(indexPath.row)["product_name"] as? String
        cell.totalItems.text = myOrders.objectAtIndex(indexPath.row)["quantity"] as? String
        cell.grandTotal.text = "nil"//myOrders.objectAtIndex(indexPath.row)[""] as? String
        cell.productStatusDate.text = myOrders.objectAtIndex(indexPath.row)["orderdate"] as? String
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        flag = true
        let userInfo = [
            "product_id" : myOrders.objectAtIndex(indexPath.row)["product_id"] as! String
            ] as NSDictionary
        SigninOperaion.get_product_details(userInfo, completionClosure: { response in
            self.productsData = (response as! NSDictionary)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let itemInfoDic  = self.productsData as! Dictionary<String, AnyObject>
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("ItemDetailVCIdentifier") as! ItemDetailVC
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
