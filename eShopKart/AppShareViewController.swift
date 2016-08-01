//
//  AppShareViewController.swift
//  BrillCreation
//
//  Created by Hemendra Singh on 27/04/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit
import MessageUI

class AppShareViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    //let messageComposer = MessageComposer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AppShareAction(sender: AnyObject) {
        //if messageComposer.canSendText() {
        let textToShare: String = "Brill Creation, now another plateform for online shopping in bulk, please go through this URL"
            let urlToShare: NSURL = NSURL(string: "http://brillcreations.com/brill/bcreation")!
            let imageToShare: UIImage = UIImage(named: "appImg.png")!
            let objectsToShare: [AnyObject] = [textToShare, urlToShare, imageToShare]
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            let excludeActivities: [AnyObject] = [UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList,UIActivityTypePostToVimeo,UIActivityTypeAirDrop,UIActivityTypeSaveToCameraRoll]
            activityVC.excludedActivityTypes = excludeActivities as? [String]
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.presentViewController(activityVC, animated: true, completion: nil)
        //}
    }
    
   @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
