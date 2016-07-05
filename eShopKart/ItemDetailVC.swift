//
//  ItemDetailVC.swift
//  eShopKart
//
//  Created by Apple on 23/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//
import UIKit
import AFNetworking
class ItemDetailVC: BaseViewController {
    
    @IBOutlet var ItemDetailTblView: UITableView!
    var productImageArr:AnyObject = []
    var productId: String!
    var getProductInfoDic = Dictionary<String,AnyObject>()
    //var productImgArr = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ItemDetailTblView.rowHeight = 170
        productImageArr = getProductInfoDic["Gallery"] as! Array<AnyObject>
        //print(productImageArr)
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            
            let cell1 = tableView.dequeueReusableCellWithIdentifier("ImageViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
            //cell1.productImg?.image = getProductImg as UIImage!
            cell1.collectionView.reloadData()
            
            return cell1
        }
        if(indexPath.row == 1) {
            let cell2 = tableView.dequeueReusableCellWithIdentifier("PriceViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
            cell2.productName?.text = getProductInfoDic["name"] as? String
            cell2.amount?.text = getProductInfoDic["price"] as? String
            return cell2
        }
        let cell3 = tableView.dequeueReusableCellWithIdentifier("DetailViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
        cell3.desTextView.layer.cornerRadius = 3
        cell3.desTextView.layer.borderWidth = 0.5
        cell3.desTextView?.text = getProductInfoDic["product_description"] as? String
        return cell3
        
    }
    
    @IBAction func addToCart(sender: AnyObject) {
        
        if (( NSUserDefaults.standardUserDefaults().valueForKey("User")) != nil) {
            
            productId = getProductInfoDic["id"] as! String
            let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
            let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
            manager.requestSerializer = requestSerializer
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
            let userId = (NSUserDefaults.standardUserDefaults().valueForKey("id"))
            let params: [NSObject : AnyObject] = ["user_id": userId!,"product_id": productId!,"quantity": 1]
            manager.POST("http://192.168.0.15/eshopkart/webservices/add_to_cart", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
                print("response: \(response!)")
                //self.subcatResponseArr = response
                self.ItemDetailTblView.reloadData()
                // cartItemArray.addObject("")
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = response["message"] as! String
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
                
            }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
                
                print("error: \(error!)")
                
            }
            //            if (self.navigationController?.topViewController?.isKindOfClass(CartItemDetailVC)) == false{
            //                let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
            //                let vc = storyboard.instantiateViewControllerWithIdentifier("MyCardDetailIdentifire") as? CartItemDetailVC
            //                self.navigationController?.pushViewController(vc!, animated: true)
            //            }
        } else {
            
            self.makeLoginAlert()
        }
        
        //self.navigationItem.rightBarButtonItem?.badgeValue = "1"
    }
    //
    @IBAction func getCodeAction(sender: AnyObject) {
        
        if(( NSUserDefaults.standardUserDefaults().valueForKey("User")) != nil) {
            productId = getProductInfoDic["id"] as! String
            let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
            let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
            manager.requestSerializer = requestSerializer
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
            let tokenId = (NSUserDefaults.standardUserDefaults().valueForKey("token_id"))
            let params: [NSObject : AnyObject] = ["token_id": tokenId!,"product_id": productId!]
            manager.POST("http://192.168.0.15/eshopkart/webservices/request_for_code", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
                print("response: \(response!)")
                //self.subcatResponseArr = response
                self.ItemDetailTblView.reloadData()
                // cartItemArray.addObject("")
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = response["msg"] as! String
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
                
            }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
                
                print("error: \(error!)")
                
            }
            
        }else {
            
            self.makeLoginAlert()
        }
    }
    
}

extension ItemDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productImageArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! collectionCell
        //let imageview: UIImageView=UIImageView(frame: CGRectMake(50, 50, self.view.frame.width-200, 50))
        //        let image:UIImage = UIImage(named:"Kloudrac-Logo")!
        // imageview.image = image
        //cell.contentView.addSubview(imageview)
        //cell.imageView.image = getProductImg
        //cell.imageView.image = productImgArr.objectAtIndex(2)["images"] as? UIImage
        // for i in 0 ..< productImageArr.count {
        //let url = NSURL(string:("http://192.168.0.14/eshopkart/files/thumbs100x100/" + (productImageArr.objectAtIndex(i)["images"] as? String)!))
        let url = NSURL(string:("http://192.168.0.15/eshopkart/files/thumbs100x100/" + (productImageArr[indexPath.row]["images"] as? String)!))
        cell.imageView?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
        //}
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath ind: NSIndexPath) -> CGSize {
        
        return collectionView.frame.size;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}








