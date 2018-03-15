//
//  ELMPreferentialView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/14.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class ELMPreferentialView: UIView {
    @IBOutlet var content: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model:ELMMenuPreferentialModel?{
        didSet{
            self.contentLabel.text = model?.content
            let type = model?.type ?? ELMMenuPreferentialModelType.full
            var color = UIColor.init()
            switch type {
            case .full:
                self.titleLabel.text = "满减"
                color = AMEColor(r: 210, g: 86, b: 77)
            case .mumbership:
                self.titleLabel.text = "会员"
                color = AMEColor(r: 210, g: 86, b: 77)
            case.firstOrder:
                self.titleLabel.text = "首单"
                color = AMEColor(r: 210, g: 86, b: 77)
            case .invoice:
                self.titleLabel.text = "发票"
                color = AMEColor(r: 210, g: 86, b: 77)
            }
            self.titleLabel.textColor = color
            self.titleLabel.backgroundColor = color.withAlphaComponent(0.1)
            self.titleLabel.layer.borderColor = color.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
        self.layer.borderColor = self.titleLabel.textColor.cgColor
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
        self.layer.borderColor = self.titleLabel.textColor.cgColor
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        //nibName是你定义的xib文件名
        let nib = UINib(nibName: "ELMPreferentialView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        content.frame = bounds
        self.addSubview(content)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
