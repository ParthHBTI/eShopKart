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
    
    @IBOutlet var categoryTblView: UITableView!
    
    var responseArr = NSMutableArray()
    var dataSend = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let emptyCellSeparatorLineView = UIView(frame: CGRectMake(0, 0, 320, 1))
        emptyCellSeparatorLineView.backgroundColor = UIColor.clearColor()
        self.categoryTblView.tableFooterView = emptyCellSeparatorLineView
        let userInfo = [
            "1" : "1"
        ]
        SigninOperaion.get_categories(userInfo, completionClosure: { response in
            self.responseArr = response as! NSMutableArray
            self.categoryTblView.reloadData()
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
        self.categoryTblView.rowHeight = 55
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
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
        destinationVC.DataSend = dataSend
        
    }
}
