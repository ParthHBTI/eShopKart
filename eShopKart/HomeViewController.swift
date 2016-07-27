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
    var tableViewController: UITableViewController?
    var filteredData = NSMutableArray()
    var tableView = UITableView()
    var productsArr = NSArray()
    var productsData = NSDictionary()
    @IBOutlet weak var upArrowImgView: UIImageView!
    @IBOutlet weak var searchProducts: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: self.tableViewController)
        searchController.searchResultsController
        searchController.searchBar.sizeToFit()
        searchController.delegate = self
        searchController.searchBar.delegate = self
        barSearchItem.delegate = self
        self.definesPresentationContext = true
        self.barSearchItem.autocorrectionType = .No
        self.barSearchItem.autocapitalizationType = .None
        self.barSearchItem.autoresizingMask = .FlexibleWidth
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.setLeftBarButtonItems(nil, animated: false)
        self.upArrowImgView.fadeOut()
        self.configureSearchController()
        searchProducts.layer.cornerRadius = 5.0
        searchProducts.layer.borderWidth = 1.0
        searchProducts.layer.borderColor = UIColor.init(colorLiteralRed: 6/255.0, green: 135/255.0, blue: 255/255.0, alpha: 1.0).CGColor
    }
    
    override func viewWillAppear(animated: Bool) {
        upArrowImgView.fadeOut()
    }
    
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        barSearchItem.showsScopeBar = true;
        self.tableView.reloadData()
        print("this is searchText Begin\(filteredData.count)")
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        self.tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            tableView.hidden = true
        } else {
            let userInfo = [
                "keyword" : searchText,
                ]
            SigninOperaion.search(userInfo, completionClosure: { response in
                print(response)
                self.filteredData.removeAllObjects()
                for var dic in response as! NSArray{
                    self.filteredData.addObject(dic)
                }
                self.tableView.reloadData()
            }) { (error: NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
            }
            self.tableView.reloadData()
            print(filteredData.count)
        }
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return self.filteredData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text = filteredData[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let id = filteredData.objectAtIndex(indexPath.row)["id"]
//        let userInfo = [
//            "product_id" : id as! String
//            ] as NSDictionary
//        SigninOperaion.get_product_details(userInfo, completionClosure: { response in
//            print(response)
//            var values: AnyObject = []
//            values = response
//            self.filteredData.removeAllObjects()
//            for var dic in values as! NSArray{
//                self.tableView.reloadData()
//                self.filteredData.addObject(dic)
//                self.productsData = (response as! NSDictionary)
//                let itemInfoDic  = self.productsData as! Dictionary<String, AnyObject>
//                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//                let destinationVC = storyboard.instantiateViewControllerWithIdentifier("ItemDetailVCIdentifier") as! ItemDetailVC
//                destinationVC.getProductInfoDic = itemInfoDic
//            }
//            self.tableView.reloadData()
//        }) { (error: NSError) -> () in
//            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            loading.mode = MBProgressHUDModeText
//            loading.detailsLabelText = error.localizedDescription
//            loading.hide(true, afterDelay: 2)
//        }
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
        let id = filteredData.objectAtIndex(indexPath.row)["id"]
        print("\(id)")
        let params: [NSObject : String] = ["product_id": id as! String]
        print("\(params)")
        manager.POST("http://192.168.0.16/eshopkart/webservices/get_product_details", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
            print("response: \(response!)")
            self.productsData = (response as! NSDictionary)
            let itemInfoDic  = self.productsData as! Dictionary<String, AnyObject>
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("ItemDetailVCIdentifier") as! ItemDetailVC
            destinationVC.getProductInfoDic = itemInfoDic
            self.navigationController?.pushViewController(destinationVC, animated: true)
            })
        { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
            print("error: \(error!)")
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


