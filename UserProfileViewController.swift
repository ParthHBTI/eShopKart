//
//  UserProfileViewController.swift
//  eShopKart
//
//  Created by mac on 16/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
import MessageUI
import Social

class UserProfileViewController: UIViewController, UITableViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
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
    @IBOutlet var profileArray: NSArray! = ["Customer Support","Share Our App","Need Help"]
    
    let messageComposerObj = MessageComposer()
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    var currentUser : User?
    var isuserLogin: Bool = false
    var profileArr2: NSArray = ["Customer Support","Share Our App","Need Help","Give Your Feedback","My Profile","My Address","My Orders"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        self.title = "Profile"
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationItem.setHidesBackButton(true, animated: true)
        let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(UserProfileViewController.crossBtnAction))
        self.navigationItem.setRightBarButtonItem(crossBtnItem, animated: true)
        let userData = NSUserDefaults.standardUserDefaults().valueForKey("User") as? NSData
        if userData != nil {
            isuserLogin = true
        }
        let btnstr = [
            NSFontAttributeName : UIFont.systemFontOfSize(12.0),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
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
        imageArray[0] = UIImage(named: "Shape Copy.png" )!
        imageArray[1] = UIImage(named: "done.png" )!
        imageArray[2] = UIImage(named: "helpIcon5" )!
        imageArray[3] = UIImage(named: "feedbackIcon" )!
        imageArray[4] = UIImage(named: "done.png" )!
        imageArray[5] = UIImage(named: "done.png" )!
        imageArray[6] = UIImage(named: "done.png" )!
        imageArray[7] = UIImage(named: "done.png" )!
        imageArray[8] = UIImage(named: "done.png" )!
        imageArray[9] = UIImage(named: "done.png" )!
        
        let emptyCellSeparatorLineView = UIView(frame: CGRectMake(0, 0, 320, 1))
        emptyCellSeparatorLineView.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = emptyCellSeparatorLineView
    }
    
//    override func viewDidDisappear(animated: Bool) {
//        
//    }
    
//    override func viewDidAppear(animated: Bool) {
//        
//    }
    
//     func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    
    override func viewWillAppear(animated: Bool) {
        let indexPath = self.tableView.indexPathForSelectedRow
        if indexPath != nil {
            self.tableView.deselectRowAtIndexPath(indexPath!, animated: true)
        }
        firstLastLbl.text = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
        mobileLbl.text = NSUserDefaults.standardUserDefaults().valueForKey("mobile") as? String
        emailLbl.text = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Login", bundle:  nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
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
        SigninOperation.logoutUser(userInfo, completionClosure: { (response: AnyObject) -> () in
            appDelegate!.saveCurrentUserDetails()
            if let _: AnyObject = response.valueForKey("User")?.valueForKey("token_id") == nil {
                NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "id")
                NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "User")
                NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "token_id")
                NSUserDefaults.standardUserDefaults().synchronize()
                NSUserDefaults.standardUserDefaults().synchronize()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                })
                loading.hide(true)
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
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        SigninOperation.verification(userInfo, completionClosure: { (response: AnyObject) -> () in
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
            self.AppShareAction(indexPath.row)
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
        } else if indexPath.row == 5{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewControllerWithIdentifier("AddressVCIdentifier") as! AddressViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
        } else {
            let userInfo = [
                "user_id" : NSUserDefaults.standardUserDefaults().valueForKey("id")!,
                ]
            SigninOperation.get_requests(userInfo, completionClosure: { response in
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let destinationVC = storyboard.instantiateViewControllerWithIdentifier("OrderNumberID") as! MyOredrNumberVC
                destinationVC.myOrderArray = response as! NSArray
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }) { (error: NSError) -> () in
                let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loading.mode = MBProgressHUDModeText
                loading.detailsLabelText = error.localizedDescription
                loading.hide(true, afterDelay: 2)
            }
        }
    }
    
    func crossBtnAction() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    func AppShareAction(sender: AnyObject) {
        let textToShare: String = "Brill Creation, now another plateform for online shopping in bulk, please go through this URL"
        let urlToShare: NSURL = NSURL(string: "http://brillcreations.com/brill/bcreation")!
        let imageToShare: UIImage = UIImage(named: "appImg.png")!
        let objectsToShare: [AnyObject] = [textToShare, urlToShare, imageToShare]
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        let excludeActivities: [AnyObject] = [UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList,UIActivityTypePostToVimeo,UIActivityTypeAirDrop,UIActivityTypeSaveToCameraRoll]
        activityVC.excludedActivityTypes = excludeActivities as? [String]
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.presentViewController(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = {(activityType: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in
            self.viewWillAppear(true)// Call this method here to deselect row at indexPathForSelectedRow, while dismiss the UIActivityViewController
            if activityType == UIActivityTypeMail {
                if self.messageComposerObj.canSendMail() {
                    return
                } else {
                    self.showSendMailErrorAlert()
                }
            }
        }
        
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }*/
    
    ////
    
    func AppShareAction(sender: AnyObject) {
        let textToShare: String = "Brill Creation, a new plateform for online shopping in bulk, please go through this URL"
        let urlToShare = NSString(string: "http://brillcreations.com") as String
        //let imageToShare: UIImage = UIImage(named: "appImg.png")!
        let shareActionSheet: UIAlertController = UIAlertController(title: NSLocalizedString("Brill Creation", comment: ""), message: "Share our App through these Social Networks", preferredStyle:UIAlertControllerStyle.ActionSheet)
        shareActionSheet.addAction(UIAlertAction(title:"Share on Facebook", style:UIAlertActionStyle.Default, handler:{ action in
            //let fbUrlStr = NSString(format:"%@webservices/openDeepLink/%@/%@", hostURL, "new_post_in_building") as String
            self.shareOnFacebook(self, ShareText: textToShare, linkToShare: urlToShare)
            
        }))
        shareActionSheet.addAction(UIAlertAction(title:"Share on Twitter", style:UIAlertActionStyle.Default, handler:{ action in
            self.shareOnTwitter(self, ShareText: textToShare, linkToShare: urlToShare)
        }))
        shareActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel, handler:nil))
        presentViewController(shareActionSheet, animated: true, completion: nil)
    }
    
    func shareOnFacebook(viewController: UIViewController, ShareText: String, linkToShare: String) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.addImage(UIImage(named: "appImage.png")!)
            facebookSheet.setInitialText(ShareText)
            facebookSheet.addURL(NSURL( string: linkToShare)!)
            viewController.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share our App.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            viewController.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func shareOnTwitter(viewController: UIViewController, ShareText: String, linkToShare: String) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText(ShareText)
            twitterSheet.addURL(NSURL(string: linkToShare))
            twitterSheet.addImage(UIImage(named: "appImage.png"))
            viewController.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share our App.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            viewController.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    ////
}