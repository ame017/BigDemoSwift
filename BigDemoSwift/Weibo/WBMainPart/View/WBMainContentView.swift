//
//  WBMainContentView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/25.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
import SnapKit

class WBMainContentView: UIView {

//    var fatherView:UIView?
    
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var cornerIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: XXLinkLabel!
    @IBOutlet weak var vipLevelImage: UIImageView!
    @IBOutlet weak var nineImageView: WBNineImageView!
    @IBOutlet weak var forwardingView: WBForwardingView!
    @IBOutlet weak var singleImageView: UIImageView!
    
    private var lastBottomConstraint:Constraint?
    
    var subViewArray = Array<UIView>()
    
    var model:WBMainContentModel?{
        didSet{
            //头像
            self.headIcon.image = model?.headIcon
            //用户类型(黄V 蓝V 普通)
            let userType = model?.userType ?? WBContentUserType.Normal
            switch userType {
            case .Blue:
                self.cornerIcon.image = #imageLiteral(resourceName: "avatar_enterprise_vip")
            case .Yellow:
                self.cornerIcon.image = #imageLiteral(resourceName: "avatar_vip")
            case .Normal:
                self.cornerIcon.isHidden = true
            }
            //用户名
            self.nameLabel.text = model?.name
            //vip
            let vipLevel = model?.vipLevel ?? 0
            if vipLevel > 0{
                self.nameLabel.textColor = UIColor.red
            }else{
                self.nameLabel.textColor = UIColor.black
            }
            let image = model?.getVipImage()
            if image != nil {
                self.vipLevelImage.image = image
            }else{
                self.vipLevelImage.isHidden = true
            }
            //时间
            self.timeLabel.text = model?.getTimeString()
            //来源
            if (model?.from?.isEmpty)! || (model?.from == "") || (model?.from == "微博weibo.com"){
                self.fromButton.setTitle("微博weibo.com", for: UIControlState.normal)
                self.fromButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            }else{
                self.fromButton.setTitle(model?.from, for: UIControlState.normal)
                self.fromButton.setTitleColor(AMEColor(r: 37, g: 139, b: 255), for: UIControlState.normal)
            }
            //内容
            self.contentLabel.text = model?.content
            self.content.layoutIfNeeded()
            //内容下面的各种蛋疼的东西
            self.lastBottomConstraint?.deactivate()
            let type = model?.type ?? WBMainContentType.Single
            switch type {
            case .Single:
                self.singleImageView.isHidden = true
                self.forwardingView.isHidden = true
                self.nineImageView.isHidden = true
            case .Image:
                //单张
                if model?.imageArray.count == 1{
                    self.nineImageView.isHidden = true
                    self.singleImageView.isHidden = false
                    self.forwardingView.isHidden = true
                    
                    let image = model?.imageArray[0]
                    self.singleImageView.image = image
                    self.singleImageView.snp.remakeConstraints({ (make) in
                        make.width.equalTo(250)
                        make.height.equalTo((250.0/(image?.size.width)!)*(image?.size.height)!)
                    })
                    self.singleImageView.snp.makeConstraints({ (make) in
                        self.lastBottomConstraint = make.bottom.equalTo(-10).constraint
                    })
                }else{
                    //多张
                    self.nineImageView.isHidden = false
                    self.singleImageView.isHidden = true
                    self.forwardingView.isHidden = true
                    
                    self.nineImageView.imageArray = (self.model?.imageArray)!
                    self.nineImageView.snp.makeConstraints({ (make) in
                        self.lastBottomConstraint = make.bottom.equalTo(-10).constraint
                    })
                }
            case .Forwarding:
                self.nineImageView.isHidden = true
                self.singleImageView.isHidden = true
                self.forwardingView.isHidden = false
                self.forwardingView.model = model?.forwarding
                self.forwardingView.snp.makeConstraints({ (make) in
                    self.lastBottomConstraint = make.bottom.equalTo(-10).constraint
                })
            }
            self.content.layoutIfNeeded()
        }
    }
    
    
    @IBOutlet var content: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
        self.contentLabel.linkTextColor = AMEColor(r: 37, g: 139, b: 255)
        self.contentLabel.regularType = [.aboat,.topic,.url]
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
        self.singleImageView.addGestureRecognizer(tap)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
        self.contentLabel.linkTextColor = AMEColor(r: 37, g: 139, b: 255)
        self.contentLabel.regularType = [.aboat,.topic,.url]
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
        self.singleImageView.addGestureRecognizer(tap)
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        //nibName是你定义的xib文件名
        let nib = UINib(nibName: "WBMainContentView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        content.frame = bounds
        self.addSubview(content)
    }
    @objc func imageViewDidTap(tapGestureRecognizer:UITapGestureRecognizer) -> Void {
        let browser = XLPhotoBrowser.show(withImages: self.model?.imageArray, currentImageIndex: (tapGestureRecognizer.view?.tag)!)
        browser?.browserStyle = XLPhotoBrowserStyle.indexLabel
        browser?.sourceImageView = tapGestureRecognizer.view as! UIImageView
    }
}
