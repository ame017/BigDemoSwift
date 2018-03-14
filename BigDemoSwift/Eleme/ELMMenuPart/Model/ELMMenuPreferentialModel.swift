//
//  ELMMenuPreferentialModel.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/14.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

enum ELMMenuPreferentialLineModelType {
    case full,mumbership,firstOrder,invoice
}

class ELMMenuPreferentialModel: NSObject {
    var type = ELMMenuPreferentialLineModelType.full
    var content = "满减优惠"
}
