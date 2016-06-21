//
//  CartItemDetailVC.swift
//  eShopKart
//
//  Created by mac on 13/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//
import UIKit
import AFNetworking
class CartItemDetailVC: BaseViewController,UITableViewDelegate {
    //var cartDetailResponseArr:AnyObject = []
    var cartDetailResponseArr = NSMutableArray()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Cart"
        //self.navigationItem.leftItemsSupplementBackButton = true
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
        let userId = (NSUserDefaults.standardUserDefaults().valueForKey("id"))
        let params: [NSObject : AnyObject] = ["user_id": userId!]
        manager.POST("http://192.168.0.14/eshopkart/webservices/view_cart", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
            print("response: \(response!)")
            for var obj in response as! NSArray
            {
                self.cartDetailResponseArr.addObject(obj)
            }
            self.tableView.reloadData()
            //            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            //            loading.mode = MBProgressHUDModeText
            //            loading.detailsLabelText = response["message"] as! String
            //            loading.hide(true, afterDelay: 2)
            //            loading.removeFromSuperViewOnHide = true
            
        }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
            
            print("error: \(error!)")
            
        }
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
        
        return cartDetailResponseArr.count
    }
    
    @IBAction func removeItemFromCart(sender: AnyObject) {
        
        //       let button = sender as! UIButton
        //       let tagValue : Int = button.tag
        let currentRow = sender.tag
        let productId = self.cartDetailResponseArr.objectAtIndex(currentRow)["id"] as! String
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
        let userId = (NSUserDefaults.standardUserDefaults().valueForKey("id"))
        let params: [NSObject : AnyObject] = ["user_id": userId!, "product_id": productId]
        manager.POST("http://192.168.0.14/eshopkart/webservices/clear_cart", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
            print("response: \(response!)")
            //self.cartDetailResponseArr = response
            //self.tableView.reloadData()
            
        }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
            
            print("error: \(error!)")
            
        }
        if (cartDetailResponseArr.count > currentRow){
            cartDetailResponseArr.removeObjectAtIndex(currentRow)
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = "Removed successfully from your cart"
            loading.hide(true, afterDelay:1)
        }
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> cartItemCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cartcell", forIndexPath: indexPath) as! cartItemCell
        cell.contentView.backgroundColor = UIColor.whiteColor()
        cell.productName?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["name"] as? String
        cell.productColor?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["colour"] as? String
        cell.productPrice?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["unitprice"] as? String
        cell.productQuantity?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["quantity"] as? String
        let url = NSURL(string:("http://192.168.0.14/eshopkart/files/thumbs100x100/" + (cartDetailResponseArr.objectAtIndex(indexPath.row)["image"] as? String)!))
        cell.productImg?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
        cell.removBtn.tag = indexPath.row
        cell.removBtn.addTarget(self, action: #selector(CartItemDetailVC.removeItemFromCart),forControlEvents: .TouchUpInside)
        return cell
        
    }
    
    //func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    //        let productId = cartDetailResponseArr.objectAtIndex(indexPath.row)["id"] as! String
    //        getProductId(productId)
    
    
    //}
    
    //    func getProductId(productId: String) -> String {
    //        print(productId)
    //        return productId
    //    }
    
    
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
