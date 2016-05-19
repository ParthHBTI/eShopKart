//
//  EKartSideMenuManager.swift
//  eShopKart
//
//  Created by mac on 18/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
@objc public protocol EKartSideMenuDelegate{
    optional func sideMenuWillShow()
    optional func sideMenuWillClose()
    optional func sideMenuShouldShow()
}

@objc public protocol EKartSideMenuProtocol{
   // var sideMenu : EKartSideMenuManager? { get }
    func setContentViewcontroller(ContentViewcontroller : UIViewController)
    
}

public enum EKartSideMenuAnimation : Int {
    case None
    case Default
}

public enum EKartSideMenuPostion : Int {
    case Left
    case Right
}

public extension UIViewController {
    public func toggleSideMenuView (){
      //  sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    public func hideSideMenuView () {
      //  sideMenuController()?.sideMenu?.hideSideMenu()
    }
    
    public func showSideMenuView () {
      //  sideMenucontroller()?.sideMenu()?.showSideMenu()
    }

}

class EKartSideMenuManager: NSObject {

}
