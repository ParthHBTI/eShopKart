//
//  CategoryItemsVC.swift
//  eShopKart
//
//  Created by Apple on 22/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import UIKit
import AFNetworking

class CategoryItemListVC: BaseViewController,UITableViewDelegate{
    var subcatResponseArr:AnyObject = []
    var categoryId: String!
    var categoryName: String!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var cteagoryItemsTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryNameLabel!.text = categoryName!
        self.cteagoryItemsTblView.rowHeight = 55
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
        let params: [NSObject : AnyObject] = ["category_id": categoryId]
        manager.POST("http://192.168.0.13/eshopkart/webservices/get_categories", parameters: params, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
            print("response: \(response!)")
            self.subcatResponseArr = response
            self.cteagoryItemsTblView.reloadData()
            
        }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
            
            print("error: \(error!)")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subcatResponseArr.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CategoryItemsViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryItemsCell", forIndexPath: indexPath) as! CategoryItemsViewCell
        cell.subCategoryItemName?.text = subcatResponseArr.objectAtIndex(indexPath.row)["category_name"] as? String
        return cell
    }
    
    @IBAction func crossAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    
}
