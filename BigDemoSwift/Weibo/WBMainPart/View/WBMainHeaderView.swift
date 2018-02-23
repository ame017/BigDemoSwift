//
//  WBMainHeaderView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/23.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class WBMainHeaderView: UIView {
    lazy var contentView : UIView = {
        let object = UIView()
        self.addSubview(object)
        return object
    }()

    
    var dataArray: Array<WBMainHeaderModel>?{
        
        didSet{
            for i in 0..<dataArray!.count {
                var imageView = UIImageView.init(image: dataArray![i].image)
                
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
