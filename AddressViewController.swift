//
//  AddressViewController.swift
//  BrillCreation
//
//  Created by mac on 15/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var myTopView: UIView!
    
    var addressArray = NSMutableArray()
    var tempCell = AddressViewCell()
    var checkOption = false
    var checkDefault = Bool()
    var editCellIndex = -1
    var deleteFlag = Bool()
    var floaringView = UIView()
    var orderBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
           if  checkDefault {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let userInfo = [
                        "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
                    ]
                    SigninOperaion.get_address(userInfo, completionClosure: { response in
                        print(response)
                        self.addressArray.removeAllObjects()
                        let values = (response as? NSArray)!
                        for var dic in values {
                            self.addressArray.addObject(dic)
                        }
                        self.tableView.reloadData()
                    }) { (error: NSError) -> () in
                        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                        loading.mode = MBProgressHUDModeText
                        loading.detailsLabelText = error.localizedDescription
                        loading.hide(true, afterDelay: 2)
                    }
                })
                return
        }
        let userInfo = [
            "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id") as! String,
            ]
        SigninOperaion.get_address(userInfo, completionClosure: { response in
            print(response)
            self.addressArray.removeAllObjects()
            let values = (response as? NSArray)!
            for var dic in values {
                self.addressArray.addObject(dic)
            }
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
            let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
        var topView = myTopView.frame
        topView.size.height = 70.0
        topView.size.width = 320.0
        myTopView.frame = topView
        orderBtn.setTitle("Order Now", forState: .Normal)
        var newButton = orderBtn.frame
        newButton.size.height = 35
        newButton.size.width = 320
        orderBtn.frame = newButton
        floaringView.addSubview(orderBtn)
        self.floaringView.backgroundColor = UIColor.init(red: 74/256.0, green: 115/256.0, blue: 236/256.0, alpha: 1.0)
        var newFrame: CGRect = self.floaringView.frame
        newFrame.size.height = 0
        newFrame.size.width = 400
        self.floaringView.frame = newFrame
        orderBtn.addTarget(self, action: #selector(goForOrder), forControlEvents: .TouchUpInside)
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = "My Addresses"
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(AddressViewController.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        let screenSize:CGRect = UIScreen.mainScreen().bounds
        floaringView.frame.size.height = screenSize.height - 630
        self.tableView.addSubview(floaringView)
        self.tableView.addObserver(self, forKeyPath: "frame", options: .New, context: nil )
        self.tableView.reloadData()
    }
    
    @IBAction func editAction(sender: AnyObject) {
        checkOption = true
        let id = addressArray.objectAtIndex(sender.tag)["id"] as? String
        let itemInfoDic  = addressArray.objectAtIndex(sender.tag) as! NSDictionary
        let destinationVC = storyboard!.instantiateViewControllerWithIdentifier("addNewAddID") as! AddNewAddressVC
        destinationVC.addressInfoDic = itemInfoDic
        destinationVC.flagPoint = checkOption
        destinationVC.address_id = id!
        print(itemInfoDic)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func deleteAction1 (sender: AnyObject) {
        makeLoginAlert(sender)
    }
    
    @IBAction func selectAddress(sender: AnyObject) {
        editCellIndex = sender.tag
        checkDefault = false
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  addressArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addressIdentity", forIndexPath: indexPath) as! AddressViewCell
        cell.deleteButton!.addTarget(self, action:  #selector(AddressViewController.deleteAction1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.selectionBtn!.addTarget(self, action:  #selector(AddressViewController.selectAddress(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.editButton!.addTarget(self, action:  #selector(AddressViewController.editAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.userName?.text = addressArray.objectAtIndex(indexPath.row)["fullname"] as? String
        cell.addressTextField.font = UIFont.boldSystemFontOfSize(18.0)
        cell.addressTextField.text = addressArray.objectAtIndex(indexPath.row)["fullAddress"] as? String
        cell.editButton.hidden = true
        cell.deleteButton.hidden = true
        cell.editButton!.tag = indexPath.row
        cell.selectionBtn!.tag = indexPath.row
        cell.deleteButton!.tag = indexPath.row
        tempCell = cell
        cell.selectionBtn!.tintColor = UIColor.blackColor()
        if self.checkDefault == true {
            if indexPath.row == addressArray.count - 1 {
                cell.editButton.hidden = false
                cell.deleteButton.hidden = false
                cell.selectionBtn!.tintColor = UIColor.init(red: 74/255.0, green: 115/255.0, blue: 236/255.0, alpha: 1.0)
            }
        } else {
            if editCellIndex == indexPath.row {
                checkDefault = false
                cell.editButton.hidden = false
                cell.deleteButton.hidden = false
                cell.selectionBtn!.tintColor = UIColor.init(red: 74/255.0, green: 115/255.0, blue: 236/255.0, alpha: 1.0)
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let addDic = addressArray.objectAtIndex(indexPath.row) as! NSDictionary
        print(addDic)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        adjustFloatingViewFrame()
    }
    
    func adjustFloatingViewFrame() {
        var newFrame: CGRect = self.floaringView.frame
        newFrame.origin.x = 0
        newFrame.origin.y = self.tableView.contentOffset.y  + CGRectGetHeight(self.tableView.bounds) - CGRectGetHeight(self.floaringView.bounds)
        self.floaringView.frame = newFrame
        self.tableView.bringSubviewToFront(self.floaringView)
    }
    
    deinit {
        self.tableView.removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath == "frame") {
            adjustFloatingViewFrame()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.leftItemsSupplementBackButton = false
    }
    
    func backAction() {
        for controller: UIViewController in self.navigationController!.viewControllers {
            if (controller is UserProfileViewController) {
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }
    }
    
    func goForOrder() {
        print("testing")
    }
    
    func makeLoginAlert(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Cofirmation", message: "You want to delete your address.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction!) in
            let id = self.addressArray.objectAtIndex(sender.tag)["id"] as? String
            let userInfo = [
                "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id")!,
                "address_id" : id! as String
            ]
            SigninOperaion.delete_address(userInfo, completionClosure: { response in
                var values: AnyObject = []
                values = response as! NSArray
                print(sender.tag)
                self.addressArray.removeObjectAtIndex(sender.tag)
                self.tableView.reloadData()
            }) { (error: NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
            }

        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            self.deleteFlag = false
            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
    }
}
