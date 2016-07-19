//
//  SimillerProductDetailVC.swift
//  eShopKart
//
//  Created by mac on 12/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//
import UIKit
import AFNetworking
class SimillerProductDetailVC: BaseViewController , UITableViewDelegate {
    
    @IBOutlet var tableview: UITableView!
    var getsubCategoryId: String!
    var productsArr = NSArray()
    var galleryArr:AnyObject = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage (named: "memo-views")
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.view.backgroundColor = UIColor .blueColor()
        self.title = "Products List"
        
        let userInfo = [
            "category_id" : getsubCategoryId
        ]
        SigninOperaion.get_products(userInfo, completionClosure: { response in
            self.productsArr = (response as? NSArray)!
            self.tableview.reloadData()
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftItemsSupplementBackButton = false
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productsArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> SimillerProductViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as! SimillerProductViewCell
        let itemInfoDic  = productsArr.objectAtIndex(indexPath.row) as! Dictionary<String,AnyObject>
        let url = NSURL(string:("http://192.168.0.9/eshopkart/files/thumbs100x100/" + (itemInfoDic["Gallery"]?.objectAtIndex(0)["images"] as? String)!))
        cell.productname?.text = itemInfoDic["name"] as? String
        cell.amount?.text = itemInfoDic["material"] as? String
        cell.size?.text = itemInfoDic["size"] as? String
        cell.productImgView?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
        cell.getQuoteBtn.tag = indexPath.row
        cell.getQuoteBtn.addTarget(self, action: #selector(SimillerProductDetailVC.getQuoteAction),forControlEvents: .TouchUpInside
        )
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        for subViews in selectedCell.contentView.subviews {
            
            if subViews is UIButton {
                let button = subViews as! UIButton
                //selectedCell.bringSubviewToFront(button)
                button.backgroundColor = UIColor.init(colorLiteralRed: 238/255.0, green: 162.0/255, blue: 82.0/255, alpha: 1)
            }
        }
        let itemInfoDic  = productsArr.objectAtIndex(indexPath.row) as! Dictionary<String,AnyObject>
        let destinationVC = storyboard!.instantiateViewControllerWithIdentifier("ItemDetailVCIdentifier") as! ItemDetailVC
        destinationVC.getProductInfoDic = itemInfoDic
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func getQuoteAction(sender: AnyObject) {
        let userLogin = NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if userLogin != nil {
            let currentRow = sender.tag
            let productId = self.productsArr.objectAtIndex(currentRow)["id"] as! String
            let tokenId = (NSUserDefaults.standardUserDefaults().valueForKey("token_id"))
            let userInfo = [
                "token_id" : tokenId!,
                "product_id" : productId
            ]
            SigninOperaion.request_for_code(userInfo, completionClosure: { response in
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
        }else {
            self.makeLoginAlert()
        }
    }
}
