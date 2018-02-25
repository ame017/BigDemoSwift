//
//  Header.swift
//  Coupon
//
//  Created by ame on 2017/12/15.
//  Copyright © 2017年 ame017. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

import SnapKit
/*----------------工具宏----------------*/

//APP版本
let APP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
//build
let APP_BUILD = Bundle.main.infoDictionary!["CFBundleVersion"]
//设备版本
let SYSTEM_VERSION = Float(UIDevice.current.systemVersion)
//设备语言
let CURRENT_LANGUAGE = NSLocale.preferredLanguages[0]
//判断是否为iPhone
let IS_IPHONE = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)
//判断是否为iPad
let IS_IPAD = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false)

//获取沙盒Document路径
let kDocumentPath = NSHomeDirectory() + "/Documents/"
//获取沙盒temp路径
let kTempPath = NSTemporaryDirectory()
//获取沙盒Cache路径
let kCachePath = NSHomeDirectory() + "/Library/Caches/"

//用10进制表示颜色，例如（255,255,255）白色
func AMEColorAlpha(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)-> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}
func AMEColor(r:CGFloat, g:CGFloat, b:CGFloat)-> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

//转字符串
/*----------------工具宏----------------*/


/*----------------界面宏----------------*/
//WIDTH和HEIGHT
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

// iPhone X
let IS_iPhoneX = (SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 812.0 ? true : false)

// Status bar height.
let kStatusBarHeight = (IS_iPhoneX ? 44.0 : 20.0)

// Navigation bar height.
let kNavigationBarHeight = 44.0

// Tabbar height.
let kTabbarHeight = (IS_iPhoneX ? (49.0+34.0) : 49.0)

// Tabbar safe bottom margin.
let kTabbarSafeBottomMargin = (IS_iPhoneX ? 34.0 : 0.0)

// Status bar & navigation bar height.
let kStatusBarAndNavigationBarHeight = (IS_iPhoneX ? 88.0 : 64.0)

@available(iOS 11.0, *)
func kViewSafeAreInsets(view : UIView) ->UIEdgeInsets{
    var insets = UIEdgeInsets()
    insets = view.safeAreaInsets
    return insets
}

//比例计算
let X_P = (SCREEN_WIDTH/375.0)
let Y_P = (SCREEN_HEIGHT/667.0)

/*----------------界面宏----------------*/

/*----------------本项目专用宏----------------*/

/*----------------本项目专用宏----------------*/
