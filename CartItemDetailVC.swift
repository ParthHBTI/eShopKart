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
    
    @IBOutlet var tableView: UITableView!
    
    var cartDetailResponseArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        let emptyCellSeparatorLineView = UIView(frame: CGRectMake(0, 0, 320, 1))
        emptyCellSeparatorLineView.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = emptyCellSeparatorLineView
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
                //self.navigationItem.rightBarButtonItem!.badgeValue = String(self.cartDetailResponseArr.count)
                //self.badgeValCounter = self.cartDetailResponseArr.count
            }
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationItem.leftItemsSupplementBackButton = false
    }
    
    func goToHomeBtnAction() {
        //self.navigationController?.popToRootViewControllerAnimated(true)
        self.navigationController?.popViewControllerAnimated(true)
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
            DynamicView.center = view.center
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
        let productId = cartDetailResponseArr.objectAtIndex(currentRow)["id"] as! String
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
            self.myCartBarItem!.badgeValue = String(cartDetailResponseArr.count)
            //self.badgeValCounter = self.cartDetailResponseArr.count
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
            self.navigationItem.rightBarButtonItem!.badgeValue = nil
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = response["message"] as! String
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
        self.myCartBarItem!.badgeValue = nil
        cartDetailResponseArr.removeAllObjects()
        self.tableView.reloadData()
    }
    
    @IBAction func getQuoteForAllItems(sender: AnyObject) {
        var order_number = String()
        var myInt = Int()
        let tokenId = NSUserDefaults.standardUserDefaults().valueForKey("token_id")
        let userInfo = [
            "token_id" : tokenId!
        ]
        SigninOperaion.request_for_code(userInfo, completionClosure: { response in
            self.navigationItem.rightBarButtonItem!.badgeValue = nil
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            order_number = response.valueForKey("order_number") as! String
            myInt = (order_number as NSString).integerValue
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = response["message"] as! String
            loading.hide(true, afterDelay: 2)
            loading.removeFromSuperViewOnHide = true
            let userInfo1 = [
                "order_number" : myInt
            ]
            SigninOperaion.request_mail(userInfo1, completionClosure: { response in
                print(response)
            }) { (error: NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
            }
            
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
        self.cartDetailResponseArr.removeAllObjects()
        self.tableView.reloadData()
        self.myCartBarItem!.badgeValue = nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> cartItemCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cartcell", forIndexPath: indexPath) as! cartItemCell
        cell.contentView.backgroundColor = UIColor.whiteColor()
        cell.productName?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["name"] as? String
        cell.productColor?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["size"] as? String
        cell.productPrice?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["material"] as? String
        cell.productQuantity?.text = cartDetailResponseArr.objectAtIndex(indexPath.row)["quantity"] as? String
        let url = NSURL(string:(imageURL + (cartDetailResponseArr.objectAtIndex(indexPath.row)["image"] as? String)!))
        cell.productImg?.setImageWithURL(url!, placeholderImage: UIImage(named:"BC Logo"))
        cell.removBtn.tag = indexPath.row
        cell.removBtn.addTarget(self, action: #selector(CartItemDetailVC.removeItemFromCart),forControlEvents: .TouchUpInside)
        return cell
    }
}
