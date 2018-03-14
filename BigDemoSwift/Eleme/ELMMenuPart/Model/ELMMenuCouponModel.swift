//
//  ELMMenuCouponModel.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/14.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
enum ELMMenuCouponModelType {
    case mumbership,shop
}
class ELMMenuCouponModel: NSObject {
    var type = ELMMenuCouponModelType.mumbership
    var money = 6
    var desc = "无门槛"
    var subContent = "超级会员红包"
}
