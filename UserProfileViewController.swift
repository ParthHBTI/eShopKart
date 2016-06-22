//
//  UserProfileViewController.swift
//  eShopKart
//
//  Created by mac on 16/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class UserProfileViewController: BaseViewController, UITableViewDelegate, UIImagePickerControllerDelegate{
    var currentUser : User?
    @IBOutlet var firstLastLbl: UILabel!
    @IBOutlet var mobileLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var profileView: UIView!
    @IBOutlet var logibBtn: UIButton!
    @IBOutlet var logoutBtn: UIButton!
    @IBOutlet var changePass: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageArray: NSMutableArray! = []
    @IBOutlet var profileArray: NSArray! = ["My Orders" , "My Returns" , "My Favourites" , "Rate Your Purchase" , "Customer Support" ,"My Account", " Notifications", "Rate the App","Give Feedback","Share Our App","Sell With Us","More"]
    @IBAction func loginAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Login", bundle:  nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if (data != nil) {
            logibBtn.hidden = true
            changePass.hidden = false
            let username = NSUserDefaults.standardUserDefaults().valueForKey("username")
            let email = NSUserDefaults.standardUserDefaults().valueForKey("email")
            let mobile = NSUserDefaults.standardUserDefaults().valueForKey("mobile")
            firstLastLbl.text = username as? String
            mobileLbl.text = mobile as? String
            emailLbl.text = email as? String
        } else {
            logoutBtn.hidden = true
            emailLbl.hidden = true
            mobileLbl.hidden = true
            firstLastLbl.hidden = true
            
        }
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(UserProfileViewController.handleTap))
        userPhoto.addGestureRecognizer(tapRecognizer)
        let nitification = NSNotificationCenter()
        nitification.postNotificationName("Login Successfully", object: self)
        navigationController?.navigationBarHidden = false
        let nav = navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        title = "Profile"
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(UserProfileViewController.crossBtnAction))
        //let profileEditBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Edit-1"), style: . Plain, target: self, action: Selector(""))
        navigationItem.setLeftBarButtonItem(crossBtnItem,animated: true)
        //navigationItem.setRightBarButtonItem(profileEditBtnItem, animated: true)
        imageArray[0] = UIImage(named: "my_orders.png" )!
        imageArray[1] = UIImage(named: "my_returns.png" )!
        imageArray[2] = UIImage(named: "favourites.png" )!
        imageArray[3] = UIImage(named: "purchase.png" )!
        imageArray[4] = UIImage(named: "customer.png" )!
        imageArray[5] = UIImage(named: "my_account.png" )!
        imageArray[6] = UIImage(named: "notification.png" )!
        imageArray[7] = UIImage(named: "rate_app.png" )!
        imageArray[8] = UIImage(named: "feedback.png" )!
        imageArray[9] = UIImage(named: "share_app.png" )!
        imageArray[10] = UIImage(named: "sell.png" )!
        imageArray[11] = UIImage(named: "more-1.png" )!
    }
    
    @IBAction func logoutAction() {
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let loading = MBProgressHUD.showHUDAddedTo(appDelegate?.window, animated: true)
        var token = appDelegate?.deviceTokenString as? String
        if token == nil {
            token = "3e94849f5eb3922965e8df4dc2332d0e"
        }
        let userInfo = [
            "token_id" : token!
        ]
        loading.mode = MBProgressHUDModeIndeterminate
        SigninOperaion.logoutUser(userInfo, completionClosure: { (response: AnyObject) -> () in
            appDelegate!.saveCurrentUserDetails()
            if let _: AnyObject = response.valueForKey("User")?.valueForKey("token_id") == nil {
                NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "User")
                NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "token_id")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSUserDefaults.standardUserDefaults().synchronize()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                })
                loading.hide(true)
                let storyboard = UIStoryboard(name: "Main" , bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("homePageViewIdentifier") as? HomeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "Exceptional error occured. Please try again after some time"
                loading.hide(true, afterDelay: 2)
            }
        }){ (error: NSError) -> () in
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
    }
    
    func handleTap() {
        if(NSUserDefaults.standardUserDefaults().valueForKey("User") != nil) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
                print("Button capture")
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
                print("Button capture")
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            
            userPhoto.contentMode = .ScaleAspectFit
            userPhoto.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func crossBtnAction() {
            let storyboard = UIStoryboard(name: "Main" , bundle:  nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("homePageViewIdentifier") as? HomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
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
    
    @IBAction func changePassAction(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let userInfo = [
            "email" : NSUserDefaults.standardUserDefaults().valueForKey("email")!,
            ]
        loading.mode = MBProgressHUDModeIndeterminate
        SigninOperaion.verification(userInfo, completionClosure: { (response: AnyObject) -> () in
            let admin = NSArray(object: response.valueForKey("User") as! NSDictionary)
            let user: User  = User.initWithArray(admin)[0] as! User
            appDelegate.currentUser = user
            appDelegate.saveCurrentUserDetails()
            if let tokenId: AnyObject = response.valueForKey("User")?.valueForKey("token_id") {
                let username =	response.valueForKey("User")?.valueForKey("username") as! String
                let email =	response.valueForKey("User")?.valueForKey("email") as! String
                let mobile = response.valueForKey("User")?.valueForKey("mobile") as! String
                NSUserDefaults.standardUserDefaults().setValue(tokenId, forKey: "token_id")
                NSUserDefaults.standardUserDefaults().setValue(username, forKey: "username")
                NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
                NSUserDefaults.standardUserDefaults().setValue(mobile, forKey: "mobile")
                NSUserDefaults.standardUserDefaults().synchronize()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                })
                loading.hide(true, afterDelay: 2)
                let storyboard = UIStoryboard(name: "Login" , bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("VerificationCodeIdentifire") as? VerificationCodeViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                
            } else {
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = "Exceptional error occured. Please try again after some time"
                loading.hide(true, afterDelay: 2)
            }
        }) { (error: NSError) -> () in
            loading.mode = MBProgressHUDModeText
            loading.detailsLabelText = error.localizedDescription
            loading.hide(true, afterDelay: 2)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UserProfileCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! UserProfileCell
        cell.moreBtn.hidden = true
        cell.profileLbl.text = profileArray.objectAtIndex(indexPath.row) as? String
        cell.imageIcon.image = imageArray.objectAtIndex(indexPath.row) as? UIImage
        if indexPath.row == 5 || indexPath.row == 11 {
            cell.moreBtn.hidden = false
        }
        return cell
    }
}