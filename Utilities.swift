//
//  Utilities.swift
//  eShopKart
//
//  Created by Apple on 29/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

extension NSObject {
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    
}

extension String{

    func isValidEmail() -> Bool {
    
        let regex = try?NSRegularExpression(pattern: "^[A-Z0-9._%+]+@(?:[A-Z0-9]+\\.)+[A-Z]{2,}$",options: .CaseInsensitive)
        return regex?.firstMatchInString(self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
    
    func isValidPhoneNumber(value: String) -> Bool {
        
        let character = NSCharacterSet(charactersInString: "0123456789").invertedSet
        var filtered:NSString!
        let inputString:NSArray = value.componentsSeparatedByCharactersInSet(character)
        filtered = inputString.componentsJoinedByString("")
        return value == filtered
    }
}