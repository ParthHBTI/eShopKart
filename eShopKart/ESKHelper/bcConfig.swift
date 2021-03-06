//
//  bcConfig.swift
//  eShopKart
//
//  Created by mac on 13/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
import Foundation

class bcConfig {
    var configDict: NSDictionary!
    var userDefaults = NSUserDefaults.standardUserDefaults()

    class var sharedInstance: bcConfig {
        struct Static  {
            static var instance: bcConfig?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = bcConfig()
        }
        return Static.instance!
    }
    
    func urlForKey (configKey: NSString) -> NSString {
        if configDict == nil {
            var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
            path = path.stringByAppendingString("bcConfig.plist")
            let fileManager = NSFileManager.defaultManager()
            if !fileManager.fileExistsAtPath(path as String) {
                let sourcePath = NSBundle.mainBundle().pathForResource("bcConfig", ofType: "plist")
                do {
                    try fileManager.copyItemAtPath(sourcePath!, toPath: path as String)
                } catch _ {
                }
            }
            configDict = NSDictionary(contentsOfFile: path as String) as NSDictionary!
        }
        let webServiceUrlDict:NSDictionary = configDict["WebServiceUrl"] as! NSDictionary
        let relativeUrl:NSString = webServiceUrlDict[configKey] as! String
        let modifiedURLString = NSString(format:"%@%@", hostURL, relativeUrl) as String
        return modifiedURLString
    }
}
    

