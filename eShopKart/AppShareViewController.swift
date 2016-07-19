//
//  AppShareViewController.swift
//  BrillCreation
//
//  Created by Hemendra Singh on 27/04/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit

class AppShareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AppShareAction(sender: AnyObject) {
        
        let textToShare: String = "http://www.appcoda.com"
        let myWebsite: NSURL = NSURL(string: "http://www.appcoda.com")!
        let objectsToShare: [AnyObject] = [textToShare, myWebsite]
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        let excludeActivities: [AnyObject] = [UIActivityTypeAirDrop, UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo]
        activityVC.excludedActivityTypes = excludeActivities as? [String]
        self.presentViewController(activityVC, animated: true, completion: nil)
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
