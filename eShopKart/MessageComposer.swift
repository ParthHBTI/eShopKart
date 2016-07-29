//
//  MessageComposer.swift
//  BrillCreation
//
//  Created by Hemendra Singh on 06/05/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit
import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {

    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self 
        //messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = "Hey friend - Just sending a text message in-app using Swift!"
        return messageComposeVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        //messageComposeVC.recipients = textMessageRecipients
        return mailComposeVC
    }
    
    func mailComposeViewController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
