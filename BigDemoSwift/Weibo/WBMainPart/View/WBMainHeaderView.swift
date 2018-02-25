//
//  WBMainHeaderView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/23.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

let IMAGEVIEW_WIDTH_HEIGHT = 50.0
var viewArray = Array<UIView>()

@objc protocol WBMainHeaderViewDelegate : NSObjectProtocol{
    @objc optional func wb_mainHeaderView(_ HeaderView:WBMainHeaderView, imageViewDidClickWithIndex index:Int)
}


class WBMainHeaderView: UIView {
    
    var delegate: WBMainHeaderViewDelegate? = nil
    
    lazy var contentView : UIScrollView = {
        let object = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.addSubview(object)
        return object
    }()

    var dataArray: Array<WBMainHeaderModel>?{
        
        didSet{
            for view in viewArray {
                view.removeFromSuperview()
            }
            viewArray.removeAll()
            
            var lastImageView:UIImageView?
            for i in 0..<dataArray!.count {
                let imageView                      = UIImageView.init(image: dataArray![i].image)
                imageView.clipsToBounds            = true
                imageView.layer.borderColor        = UIColor.init(white: 0.97, alpha: 1.0).cgColor
                imageView.layer.borderWidth        = 2.0
                imageView.layer.cornerRadius       = CGFloat(IMAGEVIEW_WIDTH_HEIGHT/2.0)
                imageView.tag                      = i
                imageView.isUserInteractionEnabled = true
                self.contentView.addSubview(imageView)
                if i != 0 {
                    let backGround = UIView.init()
                    backGround.backgroundColor    = UIColor.orange
                    backGround.layer.cornerRadius = CGFloat((IMAGEVIEW_WIDTH_HEIGHT+4)/2.0)
                    backGround.clipsToBounds      = true
                    self.contentView.insertSubview(backGround, belowSubview: imageView)
                    viewArray.append(backGround)
                    backGround.snp.makeConstraints({ (make) in
                        make.top.left.equalTo(imageView).offset(-2)
                        make.bottom.right.equalTo(imageView).offset(2)
                    })
                }
                if i == 0 {
                    let addImage = UIImageView.init(image:UIImage.init(named: "story_icon_empty_badge"))
                    self.contentView.addSubview(addImage)
                    viewArray.append(addImage)
                    addImage.snp.makeConstraints({ (make) in
                        make.right.equalTo(imageView).offset(-3)
                        make.bottom.equalTo(imageView).offset(-3)
                    })
                }
                
                imageView.snp.makeConstraints({ (make) in
                    make.top.equalTo(20)
                    if lastImageView == nil {
                        make.left.equalTo(20)
                    }else{
                        make.left.equalTo(lastImageView!.snp.right).offset(20)
                    }
                    make.width.height.equalTo(IMAGEVIEW_WIDTH_HEIGHT)
                    if i == (self.dataArray?.count)! - 1{
                        make.right.equalTo(self.contentView).offset(-20)
                    }
                })
                let label = UILabel.init()
                label.text = dataArray![i].name
                label.font = UIFont.systemFont(ofSize: 13)
                self.contentView .addSubview(label)
                label.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(imageView)
                    make.top.equalTo(imageView.snp.bottom).offset(5)
                })
                viewArray.append(label)
                lastImageView = imageView
                viewArray.append(imageView)
                
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
                imageView.addGestureRecognizer(tap)
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.97, alpha: 1.0)
    }
    
    @objc func imageViewDidTap(tapGestureRecognizer:UITapGestureRecognizer) -> Void {
        self.delegate?.wb_mainHeaderView?(self, imageViewDidClickWithIndex: (tapGestureRecognizer.view?.tag)!)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
