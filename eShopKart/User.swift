//
//  User.swift
//  eShopKart
//
//  Created by mac on 09/06/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var email: String?
    var fullname: String?
    var gender: String?
    var login_type: String?
    var phone: String?
    var user_type: String?
    var username: String?
    var confirmation_status: String?
    var userImage: UIImage?
    var token_id: String?  //need to confirm in this and above
    var firstname: String?
    var lastname: String?
    
    init(inDict:NSDictionary) {
        super.init()
        self.id = inDict["id"] as? String
        self.email = inDict["email"] as? String
        self.fullname = inDict["fullname"] as? String
        self.gender = inDict["gender"] as? String
        self.login_type = inDict["login_type"] as? String
        self.phone = inDict["phone"] as? String
        self.user_type = inDict["user_type"] as? String
        self.username = inDict["username"] as? String
        self.confirmation_status = inDict["confirmation_status"] as? String
        self.token_id = inDict["token_id"] as? String
        self.firstname = inDict["firstname"] as? String
        self.lastname = inDict["lastname"] as? String
        if (self.fullname == nil) {
            if self.firstname == nil {
                self.fullname = inDict["email"] as? String
            } else {
                self.fullname = self.firstname!
                if self.lastname != nil {
                    self.fullname = self.firstname! + " " + self.lastname!
                }
            }
        }
    }

    class func initWithArray (inArr: NSArray) -> NSArray {
        let allValues:NSMutableArray = []
        for inDictNew in inArr {
            allValues.addObject(User(inDict: inDictNew as! NSDictionary))
        }
        return allValues
    }

    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(self.id, forKey: "id")
        aCoder.encodeObject(self.email, forKey: "email")
        aCoder.encodeObject(self.fullname, forKey: "fullname")
        aCoder.encodeObject(self.gender, forKey: "gender")
        aCoder.encodeObject(self.login_type, forKey: "login_type")
        aCoder.encodeObject(self.phone, forKey: "phone")
        aCoder.encodeObject(self.user_type, forKey: "user_type")
        aCoder.encodeObject(self.username, forKey: "username")
        aCoder.encodeObject(self.confirmation_status, forKey: "confirmation_status")
        aCoder.encodeObject(self.token_id, forKey: "token_id")
        aCoder.encodeObject(self.firstname, forKey: "firstname")
        aCoder.encodeObject(self.lastname, forKey: "lastname")
    }
    
    init(coder aDecoder: NSCoder!) {
        self.id = aDecoder.decodeObjectForKey("id") as? String
        self.email = aDecoder.decodeObjectForKey("email") as? String
        self.fullname = aDecoder.decodeObjectForKey("fullname") as? String
        self.gender = aDecoder.decodeObjectForKey("gender") as? String
        self.login_type = aDecoder.decodeObjectForKey("login_type") as? String
        self.phone = aDecoder.decodeObjectForKey("phone") as? String
        self.user_type = aDecoder.decodeObjectForKey("user_type") as? String
        self.username = aDecoder.decodeObjectForKey("username") as? String
        self.confirmation_status = aDecoder.decodeObjectForKey("confirmation_status") as? String
        self.token_id = aDecoder.decodeObjectForKey("token_id") as? String
        self.firstname = aDecoder.decodeObjectForKey("firstname") as? String
        self.lastname = aDecoder.decodeObjectForKey("lastname") as? String
    }
    
    override init() {
    }

}
