//
//  UITextField.swift
//  eShopKart
//
//  Created by Apple on 27/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension UITextField{
    
    func setPlaceHolderWithText(text: String, textColor: UIColor, alpha: CGFloat){
        let ciColor = CIColor(color: textColor)
        let placeHolderColor = UIColor(red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: alpha)
        let attributes = [NSForegroundColorAttributeName: placeHolderColor]
        self.attributedPlaceholder = NSAttributedString(string:text,
                                                        attributes:attributes)
    }
    
    func setTextFieldBackground(color: UIColor, borderColor:UIColor, borderWidth: CGFloat)
    {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.CGColor
        self.backgroundColor = color
    }
    
    func setLeftImage(image: UIImage)
    {
        let imageView1 = UIImageView(image: image)
        imageView1.frame = CGRectMake(0.0, 0.0, imageView1.image!.size.width + 20, imageView1.image!.size.height)
        imageView1.contentMode = UIViewContentMode.Center
        self.leftViewMode = UITextFieldViewMode.Always
        self.leftView = imageView1
    }
    
    func setLeftPadding(padding : CGFloat) {
        let paddingView = UIView(frame: CGRectMake(0, 0, padding, self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.Always
    }
    
    func setRightImage(image: UIImage)
    {
        let imageView1 = UIImageView(image: image)
        imageView1.frame = CGRectMake(0.0, 0.0, imageView1.image!.size.width + 10, imageView1.image!.size.height)
        imageView1.contentMode = UIViewContentMode.Center
        self.rightViewMode = UITextFieldViewMode.Always
        self.rightView = imageView1
    }
    
}
