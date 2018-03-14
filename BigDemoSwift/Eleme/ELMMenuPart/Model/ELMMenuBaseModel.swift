//
//  ELMMenuBaseModel.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/14.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class ELMMenuBaseModel: NSObject {
    var backimage = UIImage()
    var iconImage = UIImage()
    var name = "店铺名称"
    var score = 0.0
    var seal = 0
    var way = "蜂鸟专送"
    var time = "约0分钟"
    var distance = 0
    var announcement = "请提前下单，避免高峰时期耽误您用餐。"
    var characteristicsArray = Array<ELMMenuCharacteristicsModel>()
    var couponArray = Array<ELMMenuCouponModel>()
    var preferentialArray = Array<ELMMenuPreferentialModel>()
}
