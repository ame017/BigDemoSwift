//
//  ELMCouponView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/14.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class ELMCouponView: UIView {
    @IBOutlet var content: UIControl!
    @IBOutlet weak var smallContent: UIView!
    @IBOutlet weak var smallNumber: UILabel!
    @IBOutlet weak var smallDesc: UILabel!
    
    @IBOutlet weak var bigContent: UIView!
    @IBOutlet weak var bigNumber: UILabel!
    @IBOutlet weak var bigDesc: UILabel!
    @IBOutlet weak var bigSubContent: UILabel!
    
    var model:ELMMenuCouponModel?{
        didSet{
            //type将来再弄
            smallNumber.text = String(describing: model?.money)
            bigNumber.text = String(describing: model?.money)
            smallDesc.text = model?.desc
            bigDesc.text = model?.desc
            bigSubContent.text = model?.subContent
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        //nibName是你定义的xib文件名
        let nib = UINib(nibName: "ELMCouponView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIControl
        content.frame = bounds
        self.addSubview(content)
    }
}
