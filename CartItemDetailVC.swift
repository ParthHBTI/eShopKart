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
        self.title = "Cart Detail"
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
        let userInfo = [
            "user_id" : userId!,
            ]
        SigninOperaion.view_cart(userInfo, completionClosure: { response in
            print(response)
            for var obj in response as! NSArray
            {
                self.cartDetailResponseArr.addObject(obj)
            }
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.leftItemsSupplementBackButton = false
    }
    
    func goToHomeBtnAction() {
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("homePageViewIdentifier") as! HomeViewController
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (cartDetailResponseArr.count == 0) {
            let DynamicView=UIView(frame: CGRectMake(0, 100, 420, 400))
            let goHomeAction = UIButton(frame: CGRect(x: 110, y: 250, width: 200, height: 60))
            let detailLBL = UILabel(frame: CGRect(x: 100, y: 210, width: 300, height: 60))
            let cartImage = UIImageView(frame: CGRectMake(120, 0, 200, 200))
            cartImage.image = UIImage(named: "market.png")
            detailLBL.textColor = UIColor.blackColor()
            goHomeAction.backgroundColor = UIColor.whiteColor()
            goHomeAction.setTitleColor(UIColor.blueColor() , forState: .Normal)
            goHomeAction.setTitle("CONTINUE SHOPPING", forState: .Normal)
            detailLBL.text = "Your Shopping Cart is Empty!"
            goHomeAction.layer.cornerRadius=10
            DynamicView.backgroundColor=UIColor.whiteColor()
            DynamicView.layer.cornerRadius=25
            DynamicView.layer.borderWidth=0
            DynamicView.addSubview(detailLBL)
            DynamicView.addSubview(cartImage)
            DynamicView.addSubview(goHomeAction)
            self.view.addSubview(DynamicView)
            goHomeAction.addTarget(self, action: #selector(goToHomeBtnAction), forControlEvents: .TouchUpInside)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartDetailResponseArr.count
    }
   
    
    @IBAction func removeItemFromCart(sender: AnyObject) {
        let currentRow = sender.tag
        let productId = self.cartDetailResponseArr.objectAtIndex(currentRow)["id"] as! String
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
        let userInfo = [
            "user_id" : userId!,
            "product_id" : productId
        ]
        SigninOperaion.clear_cart(userInfo, completionClosure: { response in
           //print(response)
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
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
    
    @IBAction func clearCartAction(sender: AnyObject) {
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
        let userInfo = [
            "user_id" : userId!,
            ]
        SigninOperaion.clear_cart(userInfo, completionClosure: { response in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = response["message"] as! String
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)        }
        cartDetailResponseArr.removeAllObjects()
        self.tableView.reloadData()
    }
    
    @IBAction func getQuoteForAllItems(sender: AnyObject) {
        let tokenId = NSUserDefaults.standardUserDefaults().valueForKey("token_id")
        let userInfo = [
            "token_id" : tokenId!
            ]
        SigninOperaion.request_for_code(userInfo, completionClosure: { response in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = response["message"] as! String
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            self.cartDetailResponseArr.removeAllObjects()
             self.tableView.reloadData()
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> cartItemCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cartcell", forIndexPath: indexPath) as! cartItemCell
        cell.contentView.backgroundColor = UIColor.whiteColor()
        cell.productName?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["name"] as? String
        cell.productColor?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["colour"] as? String
        cell.productPrice?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["unitprice"] as? String
        cell.productQuantity?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["quantity"] as? String
        let url = NSURL(string:("http://192.168.0.6/eshopkart/files/thumbs100x100/" + (cartDetailResponseArr.objectAtIndex(indexPath.row)["image"] as? String)!))
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
