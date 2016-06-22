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
        self.title = ""
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
        let params: [NSObject : AnyObject] = ["category_id": getsubCategoryId]
        manager.POST("http://192.168.0.14/eshopkart/webservices/get_products", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
            print("response: \(response!)")
            self.productsArr = (response as? NSArray)!
            self.tableview.reloadData()
            
        }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
            
            print("error: \(error!)")
            
        }
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
        
        //galleryArr = itemInfoDic["Gallery"] as! Array<AnyObject>
        //let url = NSURL(string:("http://192.168.0.13/eshopkart/files/thumbs100x100/" + (galleryArr.objectAtIndex(0)["images"] as? String)!))
        
        let url = NSURL(string:("http://192.168.0.14/eshopkart/files/thumbs100x100/" + (itemInfoDic["Gallery"]?.objectAtIndex(0)["images"] as? String)!))
        cell.productname?.text = itemInfoDic["name"] as? String
        cell.productImgView?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let itemInfoDic  = productsArr.objectAtIndex(indexPath.row) as! Dictionary<String,AnyObject>
        let destinationVC = storyboard!.instantiateViewControllerWithIdentifier("ItemDetailVCIdentifier") as! ItemDetailVC
            destinationVC.getProductInfoDic = itemInfoDic
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if(segue.identifier == "ItemDetailVCIdentifier") {
//            
//            let destinationVC = segue.destinationViewController as! ItemDetailVC
//            let cell = sender as! SimillerProductViewCell
//            destinationVC.getProductName = cell.productname?.text
//            destinationVC.getProductImg = cell.productImgView?.image
//        }
//    }
    
}
