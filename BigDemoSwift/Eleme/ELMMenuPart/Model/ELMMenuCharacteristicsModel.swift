//
//  ELMMenuCharacteristicsModel.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/14.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
enum ELMMenuCharacteristicsModelType {
    case onTime,refused
}
class ELMMenuCharacteristicsModel: NSObject {
    var type = ELMMenuCharacteristicsModelType.onTime
    var desc = ""
}
