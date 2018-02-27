//
//  WBMainContentModel.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/25.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
enum WBMainContentType {
    case Single         //纯文本
    case Image          //图片
    case Forwarding     //转发
}
enum WBContentUserType {
    case Normal
    case Blue
    case Yellow
}

class WBMainContentModel: NSObject {
    var contentId:Int?
    var type:WBMainContentType?
    var headIcon:UIImage?
    var userType:WBContentUserType?
    var name:String?
    var vipLevel:Int?
    var time:String?
    var from:String?
    var content:String?
    var imageArray = Array<UIImage>()
    var forwarding:WBMainContentModel?
    var forwardingNum:Int?
    var remarkNum:Int?
    var likeNum:Int?
    
    func getVipImage() -> UIImage {
        var image:UIImage?
        let vipLevel = self.vipLevel ?? 0
        switch vipLevel {
        case -1:
            image = #imageLiteral(resourceName: "common_icon_membership_expired")
        case 0:
            image = UIImage.init()
        default:
            if vipLevel <= 7 {
                image = UIImage.init(named: "common_icon_membership_level".appending(String(vipLevel)))
            }else{
                image = #imageLiteral(resourceName: "common_icon_membership_level7")
            }
        }
        return image!
    }
    func getTimeString() -> String {
        if (self.time?.isEmpty)! {
            return ""
        }
        let timeFormatter = DateFormatter.init()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = timeFormatter.date(from: self.time!)
        let interval = abs(Int((date?.timeIntervalSinceNow)!))
        if interval > 60*60*24*7 {
            return self.time!
        }else if interval > 60*60*24{
            return String(interval/(60*60*24)).appending("天前")
        }else if interval > 60*60{
            return String(interval/(60*60)).appending("小时前")
        }else if interval > 60{
            return String(interval/(60)).appending("分钟前")
        }else{
            return String(interval).appending("秒前")
        }
    }
}
