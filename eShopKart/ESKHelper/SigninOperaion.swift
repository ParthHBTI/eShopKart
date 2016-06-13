//
//  SigninOperaion.swift
//  eShopKart
//
//  Created by mac on 13/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
import Foundation

class SigninOperaion: BaseOperation, OperationDelegate {
    class func signup(userInfo: NSDictionary, completionClosure: (AnyObject) -> (), havingError:(NSError) -> ()) -> () {
        let urlstr = bcConfig.sharedInstance.urlForKey("signup")
        print("\(urlstr)")
        let urlString = NSString(format: bcConfig.sharedInstance.urlForKey("signup"))
        let URL: NSURL = NSURL(string: urlString as String)!
        BaseOperation.initOperation(URL, userInfo: userInfo, onSuccess: {(onSuccess: AnyObject) -> () in
            let dic = onSuccess as! NSDictionary
            completionClosure(dic)
            }, onError: {(error: NSError) -> () in
        havingError(error)
        })
    }
    
    class func signin(userInfo: NSDictionary,completionClosure: (AnyObject) -> (), havingError: (NSError) -> ()) ->() {
        let urlString = NSString(format:  bcConfig.sharedInstance.urlForKey("signin"))
        let URL: NSURL = NSURL(string: urlString as String)!
        
        BaseOperation.initOperation(URL, userInfo: userInfo, onSuccess: {(onSuccess:AnyObject) -> () in
            let dic = onSuccess as! NSDictionary
            completionClosure(dic)
            }, onError: {(error: NSError) -> () in
                havingError(error)
        })
    }
    
    class func forgotPassword(userInfo: NSDictionary,completionClosure: (AnyObject) -> (), havingError:(NSError) -> ()) ->() {
        let urlString = NSString(format: bcConfig.sharedInstance.urlForKey("forgotPassword"))
        let URL:NSURL = NSURL(string: urlString as String)!
        BaseOperation.initOperation(URL, userInfo: userInfo, onSuccess: { (onSuccess:AnyObject) -> () in
            let dic = onSuccess as! NSDictionary
            completionClosure(dic)
            }, onError: { (error:NSError) -> () in
                havingError(error)
        })
    }

}
