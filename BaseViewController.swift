//  BaseViewController.swift
//  eShopKart
//  Created by mac on 12/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
class BaseViewController: UIViewController, UINavigationControllerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    var unreadCartNotificationCount = 0
    var cartArr = NSMutableArray()
    
    //var CartItemDetailVCIns = CartItemDetailVC()
    var showSearchBarbuttonItem: UIBarButtonItem!
    var unreadCartItemDetailLabel: UILabel!
    var isUserLogin: Bool! = false
    var myCartBarItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController!.navigationBar.barTintColor = UIColor.init(red: 74/255.0, green: 115/255.0, blue: 236/255.0, alpha: 1.0)
        myCartBarItem = UIBarButtonItem(image: UIImage(named: "market"), style: .Plain, target: self, action: #selector(BaseViewController.myCartDetail))
        
        ////
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
        if (userId != nil) {
            let userInfo = [
                "user_id" : userId!,
                ]
            SigninOperaion.view_cart(userInfo, completionClosure: { response in
                print(response)
                for var obj in response as! NSArray {
                    self.cartArr.addObject(obj)
                    self.myCartBarItem!.badgeValue = String(self.cartArr.count)
                    //self.badgeValCounter = self.cartDetailResponseArr.count
                }
                //self.tableView.reloadData()
            }) { (error: NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
            }
        }
        ////
        
        let data =  NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if data != nil {
            isUserLogin = true
        }
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        //        nav!.frame=CGRectMake(0, 0, 320, 20)
        //        self.view.addSubview(nav!)
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = ""
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        let homeBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "building"), style: .Plain, target: self, action: #selector(BaseViewController.showHomePage))
        self.navigationItem.setLeftBarButtonItems([backBarButtonItem , homeBarButtonItem], animated: true)
        let showSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "landlord"), style: .Plain, target: self, action: #selector(BaseViewController.showUserProfile))
        self.navigationItem.setRightBarButtonItems([showSearchBarButtonItem,myCartBarItem!], animated: true)
        //self.navigationItem.rightBarButtonItem!.badgeValue = "1";
        //        let NavItemsArr = self.navigationController?.navigationBar.items as NSArray!
        //        let navItem = NavItemsArr.objectAtIndex(2) as! UINavigationItem
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let totalCartItemsArr = NSMutableArray()
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("id")
        if (userId != nil) {
            let userInfo = [
                "user_id" : userId!,
                ]
            SigninOperaion.view_cart(userInfo, completionClosure: { response in
                print(response)
                for var obj in response as! NSArray {
                    totalCartItemsArr.addObject(obj)
                    //self.myCartBarItem!.badgeValue = String(self.cartArr.count)
                    //self.badgeValCounter = self.cartDetailResponseArr.count
                }
                    self.myCartBarItem!.badgeValue = String(totalCartItemsArr.count)
                })
            { (error: NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
            }
        }
        
    }
    
    //Show user's profile
    func  showUserProfile(){
        if (self.navigationController?.topViewController?.isKindOfClass(UserProfileViewController)) == false {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
            let navController = UINavigationController(rootViewController: vc!)
            self.presentViewController(navController, animated: true, completion: nil)
        }
    }
    
    // Go to user's card detail page
    func myCartDetail() {
        let data =  NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if data != nil {
            if (self.navigationController?.topViewController?.isKindOfClass(CartItemDetailVC)) == false {
                let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("MyCardDetailIdentifire") as? CartItemDetailVC
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        } else {
            //            let storyboard = UIStoryboard(name: "Login" , bundle:  nil)
            //            let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController
            //            self.navigationController?.pushViewController(vc!, animated: true)
            self.makeLoginAlert()
        }
    }
    
    // Go to home page
    func showHomePage() {
        //        if (self.navigationController?.topViewController?.isKindOfClass(HomeViewController)) == false{
        self.navigationController?.popToRootViewControllerAnimated(true)
        //            for controller in self.navigationController!.viewControllers as Array {
        //                if controller.isKindOfClass(HomeViewController) {
        //                    self.navigationController?.popToViewController(controller as UIViewController, animated: true)
        //                    break
        //                }
        //            }
    }
    
    // Go back to previous page
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        showSearchBarbuttonItem?.action
    }
    
    func makeLoginAlert()
    {
        let refreshAlert = UIAlertController(title: "Please Login", message: "To make this action, please login first.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Login", style: .Default, handler: { (action: UIAlertAction!) in
            let storyboard = UIStoryboard(name: "Login" , bundle:  nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController
            let navController = UINavigationController(rootViewController: vc!)
            self.navigationController?.presentViewController(navController, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
}

