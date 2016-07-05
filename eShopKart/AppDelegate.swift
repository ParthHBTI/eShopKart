//
//  AppDelegate.swift
//  eShopKart
//
//  Created by Apple on 21/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import UIKit

let UIAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var currentUser : User?
    var deviceTokenString: NSString?
    var baseView = UIViewController?()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let data = NSUserDefaults.standardUserDefaults().objectForKey("User") as? NSData
        if data != nil {
            let admin = NSKeyedUnarchiver.unarchiveObjectWithData( data!) as! User
            currentUser  = admin;
        }
        let token = NSUserDefaults.standardUserDefaults().valueForKey("token_id") as? String
        if token == nil {
            showUserPage()
        }
        // Override point for customization after application launch.m
        return true
    }
    
    func showUserPage() {
        print("User is Logged In")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("homePageViewIdentifier") as! HomeViewController
        let navigationController:UINavigationController = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navigationController
    }
    
    func saveCurrentUserDetails() {
        
        if let _ = currentUser {
            NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject( currentUser!), forKey: "User")
        }
        
        func applicationWillResignActive(application: UIApplication) {
            // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
            // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        }
        
        func applicationDidEnterBackground(application: UIApplication) {
            // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
            // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        }
        
        func applicationWillEnterForeground(application: UIApplication) {
            // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        }
        
        func applicationDidBecomeActive(application: UIApplication) {
            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        }
        
        func applicationWillTerminate(application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
        
        
    }
    
}
extension UIView {
    func addBorderWithColor(color: UIColor, borderWidth: CGFloat) {
        addBorderToView(color, borderWidth: borderWidth,radius: 0)
    }
    func addCornerRadiusWithValue( radius: CGFloat ,color: UIColor, borderWidth: CGFloat) {
        addBorderToView(color, borderWidth: borderWidth,radius: radius)
    }
    private func addBorderToView(color: UIColor, borderWidth: CGFloat, radius:CGFloat)
    {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.CGColor
    }
}