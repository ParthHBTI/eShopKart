//
//  HomeViewController.swift
//  eShopKart
//
//  Created by Apple on 02/03/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit
import AFNetworking

class HomeViewController: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UISearchControllerDelegate, UISearchDisplayDelegate, UITableViewDataSource {
    
    @IBOutlet weak var barSearchItem: UISearchBar!
    @IBOutlet weak var dynamicImageView: UIImageView!
    var searchController: UISearchController!
    var filteredData = NSMutableArray()
    var productsArr = NSArray()
    var productsData = NSDictionary()
    @IBOutlet weak var upArrowImgView: UIImageView?
    @IBOutlet weak var searchProducts: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Eliminate separator line of empty table Cells
        let emptyCellSeparatorLineView = UIView(frame: CGRectMake(0, 0, 320, 1))
        emptyCellSeparatorLineView.backgroundColor = UIColor.clearColor()
        self.searchDisplayController?.searchResultsTableView.tableFooterView = emptyCellSeparatorLineView
        //
        searchController = UISearchController(searchResultsController: nil)
        searchController!.searchBar.sizeToFit()
        if #available(iOS 9.0, *) {
            self.searchController.loadViewIfNeeded()
        } else {
        }
        searchController!.delegate = self
        searchController!.searchBar.delegate = self
        barSearchItem.delegate = self
        self.definesPresentationContext = true
        self.barSearchItem.autocorrectionType = .No
        self.barSearchItem.autocapitalizationType = .None
        self.barSearchItem.autoresizingMask = .FlexibleWidth
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.setLeftBarButtonItems(nil, animated: false)
        self.upArrowImgView!.fadeOut()
        self.configureSearchController()
        searchProducts!.layer.cornerRadius = 5.0
        searchProducts!.layer.borderWidth = 1.0
        searchProducts!.layer.borderColor = UIColor.init(colorLiteralRed: 6/255.0, green: 135/255.0, blue: 255/255.0, alpha: 1.0).CGColor
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        upArrowImgView!.fadeOut()
        
        //        let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
        //        if (userId != nil) {
        //            let userInfo = [
        //                "user_id" : userId!
        //            ]
        //            SigninOperaion.view_cart(userInfo, completionClosure: { response in
        //self.myCartBarItem!.badgeValue = String(self.cartArr.count)
        //                })
        //            { (error: NSError) -> () in
        //                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //                loading.mode = MBProgressHUDModeText
        //                loading.detailsLabelText = error.localizedDescription
        //                loading.hide(true, afterDelay: 2)
        //            }
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        barSearchItem.showsScopeBar = true;
        self.searchController!.searchResultsController?.reloadInputViews()
        print("this is searchText Begin\(filteredData.count)")
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
    }
    
    func loadData(response:NSArray)  {
        self.filteredData.removeAllObjects()
        for var dic in response {
            self.filteredData.addObject(dic)
        }
        self.searchDisplayController!.searchResultsTableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
        } else {
            let userInfo = [
                "keyword" : searchText,
                ]
            SigninOperation.search(userInfo, completionClosure: { response in
                print(response)
                self.loadData(response as! NSArray)
                //self.performSelector(#selector(HomeViewController.loadData(_:)), withObject: response, afterDelay:0)
            }) { (error: NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
                
                //    self.searchDisplayController!.searchResultsTableView.reloadData()
            }
        }
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("CellSubtitle")
        if (cell == nil) {
            cell =  UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CellSubtitle")
        }
        
        cell?.textLabel?.textColor = UIColor.init(colorLiteralRed: Float(arc4random()%255)/255.0 , green: Float(arc4random()%255)/255.0 , blue: Float(arc4random()%255)/255.0 , alpha: 1)
        cell!.textLabel?.text = filteredData[indexPath.row]["name"] as? String
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let id = filteredData.objectAtIndex(indexPath.row)["id"]
        let userInfo = [
            "product_id" : id as! String
            ] as NSDictionary
        SigninOperation.get_product_details(userInfo, completionClosure: { response in
            print(response)
            var values = NSArray()
            values = response.valueForKey("Gallery")! as! NSArray
            self.filteredData.removeAllObjects()
            for var dic in values {
                self.filteredData.addObject(dic)
            }
            self.productsData = (response as! NSDictionary)
            let itemInfoDic  = self.productsData as! Dictionary<String, AnyObject>
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("ItemDetailVCIdentifier") as! ItemDetailVC
            destinationVC.getProductInfoDic = itemInfoDic
            self.navigationController?.pushViewController(destinationVC, animated: true)
            self.searchDisplayController!.searchResultsTableView.reloadData()
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

extension UIView {
    
    func fadeOut(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in
        }) {
        UIImageView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.Repeat, animations: {
            self.bounds = CGRect(x: self.bounds.origin.x + 20, y: self.bounds.origin.y + 50 , width: self.bounds.size.width + 0, height: self.bounds.size.height + 10)
            self.alpha = 1.0
            }, completion: completion)
    }
}


