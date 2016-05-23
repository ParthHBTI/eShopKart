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
       
      
        let homeBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "building"), style: .Plain, target: self, action: "myCardDetail")
        self.navigationItem.setLeftBarButtonItem( homeBarButtonItem , animated: true)
        
        let searchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .Plain, target: self, action: "")
        self.navigationController?.navigationBarHidden = false
        let writeAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "market"), style: .Plain, target: self, action: "myCardDetail")
        let showSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "landlord"), style: .Plain, target: self, action: Selector("showUserProfile"))
        self.navigationItem.setRightBarButtonItems([showSearchBarButtonItem,writeAddBarButtonItem, searchBarButtonItem], animated: true)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UINotificationUpdateMsgBadge", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getNotifications", name: "UINotificationUpdateMsgBadge", object: nil)
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: .Default)
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   func  showUserProfile(){
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewIdentifire") as? UserProfileViewController
      self.navigationController?.pushViewController(vc!, animated: true)
    
    
    }
    
    func myCardDetail() {
        let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("MyCardDetailIdentifire") as? CartItemDetailVC
        self.navigationController?.pushViewController(vc!, animated: true)
        if(cartItemArray.count == 0){
            let alert: UIAlertView = UIAlertView.init(title: "Sorry", message: "Your card is Empty, Shopping Something", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
       
    }
    
    func homeView() {
        let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("MyHomeDetailIdentifire") as? ESKCategoryTableVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    override func viewDidAppear(animated: Bool) {
       
    }
   

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    showSearchBarbuttonItem?.action
    }
 

}
