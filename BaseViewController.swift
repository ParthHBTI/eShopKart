//
//  BaseViewController.swift
//  eShopKart
//
//  Created by mac on 12/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UINavigationControllerDelegate  {
    var showSearchBarbuttonItem: UIBarButtonItem?
    var unreadCartItemDetailLabel: UILabel?
    var unreadCartNotificationCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        //nav?.barStyle = UIBarStyle.init(rawValue: 285893)!
//       nav?.backgroundColor = UIColor.init(colorLiteralRed: 16.0, green: 33.0, blue: 53.0, alpha: 1.0)
        nav?.tintColor = UIColor.whiteColor()
        self.title = "eShopKart"
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        let homeBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "building"), style: .Plain, target: self, action: #selector(BaseViewController.showHomePage))
        self.navigationItem.setLeftBarButtonItems([backBarButtonItem , homeBarButtonItem], animated: true)
        let searchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .Plain, target: self, action: Selector(""))
        self.navigationController?.navigationBarHidden = false
        let writeAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "market"), style: .Plain, target: self, action: #selector(BaseViewController.myCardDetail))
        let showSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "landlord"), style: .Plain, target: self, action: #selector(BaseViewController.showUserProfile))
        self.navigationItem.setRightBarButtonItems([showSearchBarButtonItem,writeAddBarButtonItem, searchBarButtonItem], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* func getCartNotifications() {
        
        let navArr = self.navigationController?.navigationBar.items as NSArray!
            //self.navigationController.
        if navArr != nil {
            let navItem = navArr.objectAtIndex(3) as! UINavigationItem
            if self.unreadChatMessages == 0 {
                navItem.badgeValue = nil
            } else {
                navItem.badgeValue = String(self.unreadChatMessages)
            }
        }
        self.navigationItem.rightBarButtonItem?.badgeValue = "1"
    }*/
    
    //Show user's profile
   func  showUserProfile(){
        //self.navigationController?.navigationBar.hidden = true
        if (self.navigationController?.topViewController?.isKindOfClass(UserProfileViewController)) == false{
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
            let navVC = UINavigationController.init(rootViewController: vc!)
            self.navigationController?.presentViewController(navVC, animated: false, completion: nil)
        }
    }
    
    // Go to user's card detail page
    func myCardDetail() {
        
        if (self.navigationController?.topViewController?.isKindOfClass(CartItemDetailVC)) == false{
            
            let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("MyCardDetailIdentifire") as? CartItemDetailVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    // Go to home page
    func showHomePage() {
        
        //let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
        //let vc = storyboard.instantiateViewControllerWithIdentifier("homePageViewIdentifier") as? HomeViewController
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
    
    // Go back to previous page
    func backAction() {
        
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    //Go to next page
    func nextAction(){
        
        let storyboard = UIStoryboard(name: "main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("") as? UserRegistrationVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
       
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            showSearchBarbuttonItem?.action
    }
 

}
