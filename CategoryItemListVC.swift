//
//  CategoryItemsVC.swift
//  eShopKart
//
//  Created by Apple on 22/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import UIKit
import AFNetworking

class CategoryItemListVC: BaseViewController,UITableViewDelegate {
    
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var cteagoryItemsTblView: UITableView!
    
    var subcatResponseArr:AnyObject = []
    var categoryId: String!
    var categoryName: String!
    var DataSend = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cteagoryItemsTblView.separatorStyle = .SingleLine
        let emptyCellSeparatorLineView = UIView(frame: CGRectMake(0, 0, 320, 1))
        emptyCellSeparatorLineView.backgroundColor = UIColor.clearColor()
        self.cteagoryItemsTblView.tableFooterView = emptyCellSeparatorLineView
        categoryNameLabel!.text = categoryName!
        self.cteagoryItemsTblView.rowHeight = 55
        let userInfo = [
            "category_id" : categoryId
        ]
        SigninOperaion.get_categories(userInfo, completionClosure: { response in
            self.subcatResponseArr = response
            self.cteagoryItemsTblView.reloadData()
        }) {(error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)        }
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
        cell.subCatId?.text = subcatResponseArr.objectAtIndex(indexPath.row)["id"] as? String
        //
        /*let separatorLineView = UIView(frame: CGRectMake(0, 0, 320, 1))
        separatorLineView.backgroundColor = UIColor.clearColor()
        cell.contentView.addSubview(separatorLineView)*/
        //
        return cell
    }
    
    @IBAction func crossAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! SimillerProductDetailVC
        let cell = sender as! CategoryItemsViewCell
        destinationVC.getsubCategoryId = cell.subCatId!.text
    }
}

extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}