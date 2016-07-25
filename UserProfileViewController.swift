//
//  UserProfileViewController.swift
//  eShopKart
//
//  Created by mac on 16/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    var currentUser : User?
    var isuserLogin: Bool = false
    @IBOutlet var firstLastLbl: UILabel!
    @IBOutlet var mobileLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var profileView: UIView!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var logoutBtn: UIButton!
    @IBOutlet var changePass: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageArray: NSMutableArray! = []
    @IBOutlet var profileArray: NSArray! = ["Customer Support","Share Our App","Need Help","Give Feedback"]
    var profileArr2: NSArray = ["Customer Support","Share Our App","Need Help","Give Feedback","My Profile","My Address","My Orders"]
    @IBAction func loginAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Login", bundle:  nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = "Profile"
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationItem.setHidesBackButton(true, animated: true)
//        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(UserProfileViewController.backAction))
        let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(UserProfileViewController.crossBtnAction))
        //let profileEditBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Edit-1"), style: . Plain, target: self, action: Selector(""))
//        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        self.navigationItem.setRightBarButtonItem(crossBtnItem, animated: true)
        
        let userData = NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if userData != nil {
            isuserLogin = true
        }
        let btnstr = [
            NSFontAttributeName : UIFont.systemFontOfSize(15.0),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            //NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue
        ]
        let attributedString1 = NSMutableAttributedString(string:"")
        let attributedString2 = NSMutableAttributedString(string:"")
        
        let logInStr = NSMutableAttributedString(string:"Log In", attributes:btnstr)
        attributedString1.appendAttributedString(logInStr)
        loginBtn!.setAttributedTitle(attributedString1, forState: .Normal)
        loginBtn.addBorderWithColor(UIColor.whiteColor(), borderWidth: 1)
        loginBtn.layer.cornerRadius = 5.0
        let logOutStr = NSMutableAttributedString(string:"Log Out", attributes:btnstr)
        attributedString2.appendAttributedString(logOutStr)
        logoutBtn!.setAttributedTitle(attributedString2, forState: .Normal)
        logoutBtn.addBorderWithColor(UIColor.whiteColor(), borderWidth: 1)
        logoutBtn.layer.cornerRadius = 5.0
        tableView.rowHeight = 55
        //        let data = NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        //        if data != nil {
        if self.isuserLogin == true {
            loginBtn.hidden = true
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
        //navigationItem.setRightBarButtonItem(profileEditBtnItem, animated: true)
        imageArray[0] = UIImage(named: "done.png" )!
        imageArray[1] = UIImage(named: "done.png" )!
        imageArray[2] = UIImage(named: "helpIcon5" )!
        imageArray[3] = UIImage(named: "feedbackIcon" )!
        imageArray[4] = UIImage(named: "done.png" )!
        imageArray[5] = UIImage(named: "done.png" )!
        imageArray[6] = UIImage(named: "done.png" )!
        imageArray[7] = UIImage(named: "done.png" )!
        imageArray[8] = UIImage(named: "done.png" )!
        imageArray[9] = UIImage(named: "done.png" )!
    }
    
    override func viewWillAppear(animated: Bool) {
        let username = NSUserDefaults.standardUserDefaults().valueForKey("username")
        let email = NSUserDefaults.standardUserDefaults().valueForKey("email")
        let mobile = NSUserDefaults.standardUserDefaults().valueForKey("mobile")
        firstLastLbl.text = username as? String
        mobileLbl.text = mobile as? String
        emailLbl.text = email as? String
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
//                let storyboard = UIStoryboard(name: "Main" , bundle: nil)
//                let vc = storyboard.instantiateViewControllerWithIdentifier("homePageViewIdentifier") as? HomeViewController
                //self.navigationController?.pushViewController(vc!, animated: true)
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
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
        if self.isuserLogin == true {
            return profileArr2.count
        }else {
            return profileArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UserProfileCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! UserProfileCell
        cell.moreBtn.hidden = true
        cell.imageIcon.image = imageArray.objectAtIndex(indexPath.row) as? UIImage
        if self.isuserLogin == true{
            cell.profileLbl.text = profileArr2.objectAtIndex(indexPath.row) as? String
        }else {
            cell.profileLbl.text = profileArray.objectAtIndex(indexPath.row) as? String
            
        }
        //        if indexPath.row == 5 || indexPath.row == 11 {
        //            cell.moreBtn.hidden = false
        //        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if(indexPath.row == 0) {
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("GeneralWebVCIdentifier") as! GeneralWebViewController
            let	url = NSString(format: "%@/4", contentURL) as String
            destinationVC.htmlString = url
            destinationVC.pageId = 4
            self.navigationController?.pushViewController(destinationVC, animated: true)
            
        } else if(indexPath.row == 1) {
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("AppShareVCIdentifire") as! AppShareViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
            
        } else if(indexPath.row == 2) {
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("HelpVCIdentifier") as! HelpViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
            
        } else if(indexPath.row == 3) {
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("feedbackControllerIdentifier") as! FeedbackViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
            
        } else if (indexPath.row == 4) {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("ProfileSettingVCIdentifier") as! ProfileSettingViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
            
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("AddressVCIdentifier") as! AddressViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func crossBtnAction() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func backAction() {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
}