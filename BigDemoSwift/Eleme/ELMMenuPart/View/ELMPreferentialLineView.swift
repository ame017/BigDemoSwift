//
//  ELMPreferentialLineView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/14.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class ELMPreferentialLineView: UIView {
    @IBOutlet var content: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
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
        let nib = UINib(nibName: "ELMPreferentialLineView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIControl
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
