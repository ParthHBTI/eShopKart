//
//  ESKCategoryTableVC.swift
//  eShopKart
//
//  Created by mac on 12/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
import AFNetworking

class ESKCategoryTableVC: BaseViewController,UITableViewDelegate {
    
    var responseArr:AnyObject = []
    @IBOutlet var categoryTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTblView.rowHeight = 85
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject>
        manager.POST("http://192.168.0.14/eshopkart/webservices/get_categories", parameters: nil, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
            print("Response: \(response!)")
            self.responseArr = response
            self.categoryTblView.reloadData()
            
        }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
            
            print("error: \(error!)")
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.leftItemsSupplementBackButton = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return responseArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ESKCategoryCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Identifier", forIndexPath: indexPath) as! ESKCategoryCell
        cell.TextLabel!.text = responseArr.objectAtIndex(indexPath.row)["category_name"] as?  String
        cell.cellId!.text = responseArr.objectAtIndex(indexPath.row)["id"] as?  String
        cell.cellId!.accessibilityElementsHidden = true
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as! CategoryItemListVC
        let cell = sender as! ESKCategoryCell
        destinationVC.categoryName = cell.TextLabel!.text
        destinationVC.categoryId = cell.cellId!.text
        
    }
}
