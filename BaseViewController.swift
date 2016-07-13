//
//  BaseViewController.swift
//  eShopKart
//
//  Created by mac on 12/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UINavigationControllerDelegate  {
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    var unreadCartNotificationCount = 0
    
    var showSearchBarbuttonItem: UIBarButtonItem!
    var unreadCartItemDetailLabel: UILabel!
    var isUserLogin: Bool! = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let data =  NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if data != nil {
            isUserLogin = true
        }
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = ""
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        let homeBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "building"), style: .Plain, target: self, action: #selector(BaseViewController.showHomePage))
        self.navigationItem.setLeftBarButtonItems([backBarButtonItem , homeBarButtonItem], animated: true)
        let writeAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "market"), style: .Plain, target: self, action: #selector(BaseViewController.myCardDetail))
        let showSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "landlord"), style: .Plain, target: self, action: #selector(BaseViewController.showUserProfile))
        self.navigationItem.setRightBarButtonItems([showSearchBarButtonItem,writeAddBarButtonItem], animated: true)
        //self.navigationItem.rightBarButtonItem!.badgeValue = "1";
        //        let NavItemsArr = self.navigationController?.navigationBar.items as NSArray!
        //        let navItem = NavItemsArr.objectAtIndex(2) as! UINavigationItem
        
    }
    
    //Show user's profile
    func  showUserProfile(){
        if (self.navigationController?.topViewController?.isKindOfClass(UserProfileViewController)) == false{
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
            //self.navigationController?.pushViewController(vc!, animated: true)
            let navController = UINavigationController(rootViewController: vc!)
            self.presentViewController(navController, animated: true, completion: nil)
        }
    }
    
    // Go to user's card detail page
    func myCardDetail() {
        let data =  NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if data != nil {
            if (self.navigationController?.topViewController?.isKindOfClass(CartItemDetailVC)   ) == false{
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
        if (self.navigationController?.topViewController?.isKindOfClass(HomeViewController)) == false{
            //            let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
            //            let vc = storyboard.instantiateViewControllerWithIdentifier("homePageViewIdentifier") as? HomeViewController
            //self.navigationController?.popToViewController(vc!, animated: true)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
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
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            let storyboard = UIStoryboard(name: "Login" , bundle:  nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
            let navController = UINavigationController(rootViewController: vc!)
            self.navigationController?.presentViewController(navController, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
    }
}


