//
//  UserProfileViewController.swift
//  eShopKart
//
//  Created by mac on 16/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController , UITableViewDelegate{

   
    @IBOutlet var logibBtn: UIButton!
    @IBOutlet var tableView: UITableView!
     @IBOutlet var profileArray: NSArray! = ["My Orders" , "My Returns" , "My Favourites" , "Rate Your Purchase" , "Customer Support" ,"My Account", " Notifications", "Rate the App","Give Feedback","Share Our App","Sell With Us","More"]
    
    @IBOutlet var imageArray: NSMutableArray! = []
    
    @IBAction func loginAction(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Login" , bundle:  nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LandingViewController") as? ESKLoginSignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.navigationController?.navigationBarHidden = false
            let nav = self.navigationController?.navigationBar
            nav?.barStyle = UIBarStyle.BlackOpaque
            nav?.tintColor = UIColor.whiteColor()
            self.title = "Profile"
            self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        
            let crossBtnIcon: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(UserProfileViewController.crossBtnAction))
            self.navigationItem.setRightBarButtonItem(crossBtnIcon, animated: true)
        
       // navigationItem.leftBarButtonItem  =  UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: "")
        
      imageArray[0] = UIImage(named: "market.png" )!
        imageArray[1] = UIImage(named: "back_icon.png" )!
        imageArray[2] = UIImage(named: "Oval 39 + Shape Copy 2.png" )!
        imageArray[3] = UIImage(named: "market.png" )!
        imageArray[4] = UIImage(named: "market.png" )!
        imageArray[5] = UIImage(named: "market.png" )!
        imageArray[6] = UIImage(named: "market.png" )!
        imageArray[7] = UIImage(named: "market.png" )!
        imageArray[8] = UIImage(named: "market.png" )!
        imageArray[9] = UIImage(named: "market.png" )!
        imageArray[10] = UIImage(named: "market.png" )!
        imageArray[11] = UIImage(named: "market.png" )!
        // Do any additional setup after loading the view.
    }
    
    func crossBtnAction() {
        
        self.navigationController?.dismissViewControllerAnimated(false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
//        self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.leftItemsSupplementBackButton = true
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return profileArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UserProfileCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! UserProfileCell
        cell.moreBtn.hidden = true
        cell.profileLbl.text = profileArray.objectAtIndex(indexPath.row) as! String
        cell.imageIcon.image = imageArray.objectAtIndex(indexPath.row) as! UIImage
        
        
        if indexPath.row == 5 || indexPath.row == 11{
            cell.moreBtn.hidden = false
        }
        return cell
    }
}
