//
//  BaseOperation.swift
//  eShopKart
//
//  Created by Apple on 10/03/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit
import AFNetworking

let hostURL = "http://192.168.0.15/eshopkart/"
let contentURL = hostURL + "pages/content"
let imageBaseURL = hostURL + "files"
@objc protocol OperationDelegate {
    
}

class BaseOperation {
    var delegate: OperationDelegate!
    class func initOperation(inUrl:NSURL, userInfo:NSDictionary, onSuccess: (AnyObject) -> (), onError: (NSError) -> ()) {
        print("userinfo: \(userInfo)")
        let postDic = NSMutableDictionary(dictionary: userInfo)
        postDic.setValue(NSUserDefaults.standardUserDefaults().valueForKey("token_id") as? String ?? "12345", forKey: "token_id")
        let del = UIApplication.sharedApplication().delegate as? AppDelegate
        print("token id sent is: ", del?.currentUser?.token_id)
        print("userinfo: \(postDic)")
        let manager:	AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer : AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = requestSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "text/plain","application/soap+xml") as Set<NSObject>
        print("URL: \(inUrl)")
        manager.POST(inUrl.absoluteString, parameters: postDic, success: { (operation : AFHTTPRequestOperation!, response : AnyObject!) -> Void in
            print("URL: \(inUrl)")
            if let _ = response {
                if let res = response.valueForKey("code") as? String
                {
                    if res != "1000"
                    {
                        let dict = NSMutableDictionary()
                        dict[NSLocalizedDescriptionKey] = response.valueForKey("message") as! String
                        dict[NSLocalizedFailureReasonErrorKey] = response.valueForKey("code") as! String
                        let error = NSError(domain: "com.bc.app.error", code: (response.valueForKey("code")?.integerValue)!, userInfo: dict as [NSObject : AnyObject])
                        dict[NSUnderlyingErrorKey] = error
                        onError(error)
                    } else {
                        onSuccess(response!)
                    }
                } else {
                    print("Response: \(response!)")
                    onSuccess(response!)
                }
                
            } else {
                let dict = NSMutableDictionary()
                dict[NSLocalizedDescriptionKey] = "Server issues" //as! String
                dict[NSLocalizedFailureReasonErrorKey] = "1000"
                let error = NSError(domain: "com.bc.app.error", code: 1000, userInfo: dict as [NSObject : AnyObject])
                dict[NSUnderlyingErrorKey] = error
                onError(error)
                
            }
        }) { (operation : AFHTTPRequestOperation?, error : NSError?) -> Void in
            onError(error!)
        }
    }
}