//
//  ESKCategoryTableVC.swift
//  eShopKart
//
//  Created by mac on 12/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
class ESKCategoryTableVC: BaseViewController ,UITableViewDelegate {
    
    @IBOutlet var categoryTblView: UITableView!
    var categoryArray: NSArray = ["ELECTRONICS" , "HOME & APPLIANCES" , "LIFESTYLE" , "AUTOMOTIVE" , "BOOKS & MORE" , " DAILY NEEDS", "SPORTS & OUTDOORS"]
    var data = NSMutableData()
    var tableData = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callingWebservice("")
        self.categoryTblView.rowHeight = 85
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.leftItemsSupplementBackButton = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //
    //    override func viewDidAppear(animated: Bool) {
    //
    //        self.navigationItem.leftItemsSupplementBackButton = false
    //    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ESKCategoryCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Identifier", forIndexPath: indexPath) as! ESKCategoryCell
        cell.TextLabel!.text = categoryArray.objectAtIndex(indexPath.row) as?  String
        //CategoryItemListVC.categoryNameLabel?.text
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as! CategoryItemListVC
        let cell = sender as! ESKCategoryCell
        destinationVC.categoryName = cell.TextLabel!.text
    }
    
    func callingWebservice(searchTerm: String){
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            let urlPath = "http://192.168.0.13/eshopkart/webservices/select_category"
            let url = NSURL(string: urlPath)
            
            let request: NSURLRequest = NSURLRequest(URL: url!)
            let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
            connection.start()
            
        }
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse)
    {
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        self.data.appendData(data)
    }
    func connectionDidFinishLoading(connection: NSURLConnection)
    {
        do{
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                
                if let results: NSArray = jsonResult["id"] as? NSArray {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableData = results
                        self.categoryTblView!.reloadData()
                    })
                }
            }
        }
        catch{
            print("Somthing wrong")
        }
    }
}
