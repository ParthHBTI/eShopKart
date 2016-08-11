//
//  ItemDetailVC.swift
//  eShopKart
//
//  Created by Apple on 23/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//
import UIKit
import AFNetworking

class ItemDetailVC: BaseViewController,UITextFieldDelegate {
    
    struct MoveKeyboard {
        static let KEYBOARD_ANIMATION_DURATION : CGFloat = 0.3
        static let MINIMUM_SCROLL_FRACTION : CGFloat = 0.2;
        static let MAXIMUM_SCROLL_FRACTION : CGFloat = 1.2;
        static let PORTRAIT_KEYBOARD_HEIGHT : CGFloat = 216;
        static let LANDSCAPE_KEYBOARD_HEIGHT : CGFloat = 162;
    }
    var animateDistance: CGFloat = 0
    var flag: Bool! = false
    var checkFlag = false
    var indexPath: NSIndexPath = NSIndexPath(forRow: 1, inSection: 1)
    var cell = ItemDetailViewCell()
    @IBOutlet var ItemDetailTblView: UITableView!
    @IBOutlet weak var AddToCartBtn: UIButton!
    @IBOutlet weak var GetQuoteBtn: UIButton!
    var productQnty: String!
    var productImageArr:AnyObject = []
    var productId: String!
    var getProductInfoDic = Dictionary<String,AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkFlag {
            AddToCartBtn.hidden = true
            GetQuoteBtn.hidden = true
        }
        self.title = "Product Detail"
        self.ItemDetailTblView.rowHeight = 170
        productImageArr = getProductInfoDic["Gallery"] as! Array<AnyObject>
        AddToCartBtn.layer.borderWidth = 1.0
        AddToCartBtn.layer.borderColor = UIColor.init(colorLiteralRed: 6/255.0, green: 135/255.0, blue: 255/255.0, alpha: 1.0).CGColor
        AddToCartBtn.layer.cornerRadius = 5.0
        GetQuoteBtn.layer.borderWidth = 1.0
        GetQuoteBtn.layer.cornerRadius = 5.0
        GetQuoteBtn.layer.borderColor = UIColor.init(colorLiteralRed: 6/255.0, green: 135/255.0, blue: 255/255.0, alpha: 1.0).CGColor
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(ItemDetailVC.handleTap(_:)))
        self.view .addGestureRecognizer(tapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        if self.flag == true {
            self.cell.qtyTxtField.text = "1"
        }
        self.ItemDetailTblView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("ImageViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
            cell1.collectionView.reloadData()
            return cell1
        }
        if(indexPath.row == 1) {
            let cell2 = tableView.dequeueReusableCellWithIdentifier("PriceViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
            cell2.productName?.text = getProductInfoDic["name"] as? String
            cell2.amount?.text = getProductInfoDic["material"] as? String
            cell2.qtyTxtField.layer.borderColor = UIColor.grayColor().CGColor
            cell2.qtyTxtField.layer.cornerRadius = 5.0
            cell2.qtyTxtField.layer.borderWidth  = 1.0
            cell2.qtyTxtField.delegate = self
            if checkFlag {
                cell2.qtyTxtField.text = productQnty
                cell2.qtyTxtField.enabled = false
            } else {
                if self.flag == true {
                    self.productQnty = cell2.qtyTxtField!.text!
                } else {
                    cell2.qtyTxtField.text = "1"
                }
            }
            self.cell = cell2
            return cell2
        }
        let cell3 = tableView.dequeueReusableCellWithIdentifier("DetailViewCellIdentifier", forIndexPath: indexPath) as! ItemDetailViewCell
        cell3.desTextView.layer.cornerRadius = 3
        cell3.desTextView.layer.borderWidth = 0.5
        cell3.desTextView?.text = getProductInfoDic["product_description"] as? String
        return cell3
    }
    
    @IBAction func addToCart(sender: AnyObject) {
        let userData = NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        let productQty: String!
        if userData != nil {
            productId = getProductInfoDic["id"] as! String
            if self.flag == true {
                productQty = self.productQnty!
            } else {
                productQty = "1"
            }
            let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
            let userInfo = [
                "product_id" : productId,
                "quantity" : productQty,
                "user_id" : userId!,
                ]
            SigninOperaion.add_to_cart(userInfo, completionClosure: { response in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = response["message"] as! String
                loading.hide(true, afterDelay: 2)
                loading.removeFromSuperViewOnHide = true
                self.ItemDetailTblView.reloadData()
            }) {(error: NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
            }
        } else {
            //self.makeLoginAlert()
        }
    }
    
    @IBAction func getCodeAction(sender: AnyObject) {
        var order_number = String()
        var myInt = Int()
        let userData = NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if userData != nil {
            productId = getProductInfoDic["id"] as! String
            let tokenId = (NSUserDefaults.standardUserDefaults().valueForKey("token_id"))
            let userInfo = [
                "token_id" : tokenId!,
                "product_id" : productId!
            ]
            SigninOperaion.request_for_code(userInfo, completionClosure: { response in
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
                self.ItemDetailTblView.reloadData()
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
    
    func handleTap (tapGesture: UIGestureRecognizer) {
        self.view .endEditing(true)
        self.ItemDetailTblView.reloadData()
        self.flag = true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let textFieldRect : CGRect = self.view.window!.convertRect(textField.bounds, fromView: textField)
        let viewRect : CGRect = self.view.window!.convertRect(self.view.bounds, fromView: self.view)
        let midline : CGFloat = textFieldRect.origin.y + 0.1 * textFieldRect.size.height
        let numerator : CGFloat = midline - viewRect.origin.y - MoveKeyboard.MINIMUM_SCROLL_FRACTION * viewRect.size.height
        let denominator : CGFloat = (MoveKeyboard.MAXIMUM_SCROLL_FRACTION - MoveKeyboard.MINIMUM_SCROLL_FRACTION) * viewRect.size.height
        var heightFraction : CGFloat = numerator / denominator
        if heightFraction < 0.0 {
            heightFraction = 0.0
        } else if heightFraction > 1.0 {
            heightFraction = 1.0
        }
        let orientation : UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        if (orientation == UIInterfaceOrientation.Portrait || orientation == UIInterfaceOrientation.PortraitUpsideDown) {
            animateDistance = floor(MoveKeyboard.PORTRAIT_KEYBOARD_HEIGHT * heightFraction)
        } else {
            animateDistance = floor(MoveKeyboard.LANDSCAPE_KEYBOARD_HEIGHT * heightFraction)
        }
        var viewFrame : CGRect = self.view.frame
        viewFrame.origin.y -= animateDistance
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(NSTimeInterval(MoveKeyboard.KEYBOARD_ANIMATION_DURATION))
        self.view.frame = viewFrame
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var viewFrame : CGRect = self.view.frame
        viewFrame.origin.y += animateDistance
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(NSTimeInterval(MoveKeyboard.KEYBOARD_ANIMATION_DURATION))
        self.view.frame = viewFrame
        UIView.commitAnimations()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.ItemDetailTblView.reloadData()
        self.flag = true
        return true
    }
    
    override func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension ItemDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImageArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! collectionCell
        let url = NSURL(string:(imageURL + (productImageArr[indexPath.row]["images"] as? String)!))
        cell.imageView?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath ind: NSIndexPath) -> CGSize {
        return collectionView.frame.size;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}