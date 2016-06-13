//
//  UserProfileViewController.swift
//  eShopKart
//
//  Created by mac on 16/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController,UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var flag = Bool()
    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var inOutLbl: UILabel!
    @IBOutlet var profileView: UIView!
    @IBOutlet var logibBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageArray: NSMutableArray! = []
    @IBOutlet var profileArray: NSArray! = ["My Orders" , "My Returns" , "My Favourites" , "Rate Your Purchase" , "Customer Support" ,"My Account", " Notifications", "Rate the App","Give Feedback","Share Our App","Sell With Us","More"]
    @IBAction func loginAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Login", bundle:  nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController
        //self.navigationController?.pushViewController(vc!, animated: true)
        let navVC = UINavigationController.init(rootViewController: vc!)
        self.navigationController?.presentViewController(navVC, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(UserProfileViewController.handleTap))
        userPhoto.addGestureRecognizer(tapRecognizer)
        let nitification = NSNotificationCenter()
        nitification.postNotificationName("Login Successfully", object: self)
        if (flag ) {
            inOutLbl.text = "Login"
            
        } else {
            inOutLbl.text = "Logout"
            flag = true
        }
        
        navigationController?.navigationBarHidden = false
        let nav = navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackOpaque
        nav?.tintColor = UIColor.whiteColor()
        title = "Profile"
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let crossBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross_icon"), style: .Plain, target: self, action: #selector(UserProfileViewController.crossBtnAction))
        let profileEditBtnItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Edit-1"), style: . Plain, target: self, action: Selector(""))
        navigationItem.setLeftBarButtonItem(crossBtnItem,animated: true)
        navigationItem.setRightBarButtonItem(profileEditBtnItem, animated: true)
        
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
    }
    func handleTap() {
        var imagePicker = UIImagePickerController()
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
    @IBAction func changePassAction(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("VerificationCodeIdentifire") as? VerificationCodeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
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