//
//  UserProfileViewController.swift
//  eShopKart
//
//  Created by mac on 16/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController , UITableViewDelegate{

   
    @IBOutlet var tableView: UITableView!
     @IBOutlet var profileArray: NSArray! = ["My Orders" , "My Returns" , "My Favourites" , "Rate Your Purchase" , "Customer Support" ,"My Account", " Notifications", "Rate the App","Give Feedback","Share Our App","Sell With Us","More"]
    
    @IBOutlet var imageArray: NSMutableArray! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      imageArray[0] = UIImage(named: "kart_icon.png" )!
        imageArray[1] = UIImage(named: "my_return.png" )!
        imageArray[2] = UIImage(named: "favourite.png" )!
        imageArray[3] = UIImage(named: "purchase.png" )!
        imageArray[4] = UIImage(named: "support.png" )!
        imageArray[5] = UIImage(named: "my_account.png" )!
        imageArray[6] = UIImage(named: "notify.png" )!
        imageArray[7] = UIImage(named: "rate_app.png" )!
        imageArray[8] = UIImage(named: "feedback.png" )!
        imageArray[9] = UIImage(named: "share.png" )!
        imageArray[10] = UIImage(named: "sell.png" )!
        imageArray[11] = UIImage(named: "plus.png" )!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
