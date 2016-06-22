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
    var searchController: UISearchController!
    var tableViewController: UITableViewController?
    var filteredData = NSMutableArray()
    var tableView = UITableView()
    var productsData = NSDictionary()
    
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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        barSearchItem.showsScopeBar = true;
        print("this is searchText Begin\(filteredData.count)")
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {   print("this is section\(filteredData.count)")
        return self.filteredData.count

    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
        } else {
            let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
            let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
            manager.requestSerializer = requestSerializer
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
            let params: [NSObject : String] = ["keyword": searchText ]
            manager.POST("http://192.168.0.11/eshopkart/webservices/search", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
                print("response: \(response!)")
                var values: AnyObject = []
                values = response
                self.filteredData.removeAllObjects()
                for var objDic in values as! NSArray
                {
                    self.filteredData.addObject(objDic)
                }
                print("\(self.filteredData.count)")
                self.tableView.reloadData()
            })
            { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
                print("error: \(error!)")
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text = filteredData[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
        let id = filteredData.objectAtIndex(indexPath.row)["id"]
        print("\(id)")
        let params: [NSObject : String] = ["product_id": id as! String]
        print("\(params)")
        manager.POST("http://192.168.0.11/eshopkart/webservices/get_product_details", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
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


