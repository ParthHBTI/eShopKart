//
//  BaseViewController.swift
//  eShopKart
//
//  Created by mac on 12/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController  {
    var showSearchBarbuttonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.whiteColor()
        
        self.title = "eShopKart"
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .Plain, target: self, action: #selector(BaseViewController.backAction))
        let homeBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "building"), style: .Plain, target: self, action: #selector(BaseViewController.showHomePage))
        self.navigationItem.setLeftBarButtonItems([backBarButtonItem , homeBarButtonItem], animated: true)
        
        let searchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .Plain, target: self, action: Selector(""))
        self.navigationController?.navigationBarHidden = false
        let writeAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "market"), style: .Plain, target: self, action: #selector(BaseViewController.myCardDetail))
        let showSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "landlord"), style: .Plain, target: self, action: #selector(BaseViewController.showUserProfile))
        self.navigationItem.setRightBarButtonItems([showSearchBarButtonItem,writeAddBarButtonItem, searchBarButtonItem], animated: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Show user's profile
   func  showUserProfile(){
    
        if ((self.navigationController?.topViewController?.isKindOfClass(UserProfileViewController)) == false) {
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
            self.navigationController?.pushViewController(vc!, animated: true)

        }
    }
    
    // Go to user's card detail page
    func myCardDetail() {
        let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("MyCardDetailIdentifire") as? CartItemDetailVC
        self.navigationController?.pushViewController(vc!, animated: true)

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
    
    override func viewDidAppear(animated: Bool) {
       
    }
    
   
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            showSearchBarbuttonItem?.action
    }
 

}
