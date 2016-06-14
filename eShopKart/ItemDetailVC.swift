//
//  ItemDetailVC.swift
//  eShopKart
//
//  Created by Apple on 23/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//
import UIKit
import AFNetworking
class ItemDetailVC: BaseViewController    {
    
    @IBOutlet var ItemDetailTblView: UITableView!
    var getProductName: String!
    var productImgArr = NSArray()
    var getProductImg: UIImage!
    override func viewDidLoad() {
        
        print(productImgArr
        )
        super.viewDidLoad()
        self.ItemDetailTblView.rowHeight = 170
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
            cell2.productName?.text = getProductName as String!
            return cell2
        }
        let cell3 = tableView.dequeueReusableCellWithIdentifier("DetailViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
        return cell3
        
    }
    
    @IBAction func addToCart(sender: AnyObject) {
        
        cartItemArray.addObject("")
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeText
        loading.detailsLabelText = "Product has been added to your cart successfully!"
        loading.hide(true, afterDelay: 2)
        loading.removeFromSuperViewOnHide = true
        //self.navigationItem.rightBarButtonItem?.badgeValue = "1"
    }
}

extension ItemDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productImgArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! collectionCell
                //let imageview: UIImageView=UIImageView(frame: CGRectMake(50, 50, self.view.frame.width-200, 50))
        //        let image:UIImage = UIImage(named:"Kloudrac-Logo")!
               // imageview.image = image
                //cell.contentView.addSubview(imageview)
           //cell.imageView.image = getProductImg
        //cell.imageView.image = productImgArr.objectAtIndex(2)["images"] as? UIImage
        let url = NSURL(string:("http://192.168.0.13/eshopkart/files/thumbs100x100/" + (productImgArr.objectAtIndex(0)["images"] as? String)!))
        cell.imageView?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}




