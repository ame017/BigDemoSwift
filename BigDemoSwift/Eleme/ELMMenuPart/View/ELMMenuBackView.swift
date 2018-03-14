//
//  ELMMenuBackView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/13.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class ELMMenuBackView: UIControl {
    @IBOutlet var content: UIControl!
    
    @IBOutlet weak var smallContent: UIView!
    @IBOutlet weak var starsViewSmall: RatingBar!
    @IBOutlet weak var startLabelSmall: UILabel!
    @IBOutlet weak var sealLabelSmall: UILabel!
    @IBOutlet weak var timeLabelSmall: UILabel!
    @IBOutlet weak var wayLabel: UILabel!
    
    @IBOutlet weak var bigContent: UIView!
    @IBOutlet weak var startsViewBig: RatingBar!
    @IBOutlet weak var scoreViewBig: UILabel!
    @IBOutlet weak var sealLabelBig: UILabel!
    @IBOutlet weak var timeLabelBig: UILabel!
    @IBOutlet weak var wayLabelBig: UILabel!
    @IBOutlet weak var distanceLabelBig: UILabel!
    
    @IBOutlet weak var preferentialView: UIView!
    @IBOutlet weak var announcementView: UIView!
    
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
        let nib = UINib(nibName: "ELMMenuBackView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIControl
        content.frame = bounds
        self.addSubview(content)
    }

}
