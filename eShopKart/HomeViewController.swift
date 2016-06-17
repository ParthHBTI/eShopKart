//
//  HomeViewController.swift
//  eShopKart
//
//  Created by Apple on 02/03/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UISearchControllerDelegate, UISearchDisplayDelegate, UITableViewDataSource {
    
    @IBOutlet weak var barSearchItem: UISearchBar!
    var searchController: UISearchController!
    var tableViewController: UITableViewController!
    var filteredData: [String]!
    
    var data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: self.tableViewController)
        searchController.searchResultsController
        searchController.searchBar.sizeToFit()
        searchController.delegate = self
        searchController.searchBar.delegate = self
        barSearchItem.delegate = self
        filteredData = data
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
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return filteredData.count
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        if searchText.isEmpty {
            filteredData = data
        } else {
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                var token = appDelegate.deviceTokenString as? String
                if token == nil {
                    token = "786e246f17d1a0684d499b390b8"
                }
                let userInfo = [
                    "keyword" : searchText as String
            ]
                loading.mode = MBProgressHUDModeIndeterminate
                SigninOperaion.search(userInfo, completionClosure: { (response: AnyObject) -> () in
                    let product = NSArray(object: response.valueForKey("keyword") as! NSDictionary)
                    let user: User  = User.initWithArray(product)[0] as! User
                    appDelegate.currentUser = user
                    appDelegate.saveCurrentUserDetails()
                    if (true) {
                        loading.hide(true, afterDelay: 2)
                        let productData = NSUserDefaults.standardUserDefaults().valueForKey("keyword")! as! [String]
                        self.filteredData = productData.filter({(dataItem: String) -> Bool in
                            if dataItem.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                                return true
                            } else {
                                return false
                            }
                        })
                       
                    } else {
                        loading.mode = MBProgressHUDModeText
                        loading.detailsLabelText = "Exceptional error occured. Please try again after some time"
                        loading.hide(true, afterDelay: 2)
                    }
                }) { (error: NSError) -> () in
                    loading.mode = MBProgressHUDModeText
                    loading.detailsLabelText = error.localizedDescription
                    loading.hide(true, afterDelay: 2)
                }
            }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
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


