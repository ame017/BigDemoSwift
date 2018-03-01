//
//  WBMainContentView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/25.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class WBMainContentView: UIView {

    var fatherView:UIView?
    
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var cornerIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: XXLinkLabel!
    @IBOutlet weak var vipLevelImage: UIImageView!
    
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
            for view in self.subViewArray {
                view.removeFromSuperview()
            }
            self.subViewArray.removeAll()
            //图片型
            if model?.type == WBMainContentType.Image {
                //单张
                if model?.imageArray.count == 1{
                    let image = model?.imageArray[0]
                    let imageView = UIImageView.init(image: image)
                    
                    imageView.isUserInteractionEnabled = true
                    let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
                    imageView.addGestureRecognizer(tap)
                    imageView.tag = 0
                    
                    self.content.addSubview(imageView)
                    self.subViewArray.append(imageView)
                    imageView.snp.makeConstraints({ (make) in
                        make.top.equalTo(contentLabel.snp.bottom).offset(7)
                        make.left.equalTo(contentLabel)
                        make.width.equalTo(250)
                        make.height.equalTo((250.0/(image?.size.width)!)*(image?.size.height)!)
                        make.bottom.equalTo(-10)
                    })
                }else{
                    //大于1张,九宫格
                    var lastImageView:UIImageView?
                    var lastLineImageView:UIImageView?
                    for i in 0..<(model?.imageArray.count)!{
                        let imageView = UIImageView.init(image: model?.imageArray[i])
                        imageView.contentMode = UIViewContentMode.scaleAspectFill
                        imageView.clipsToBounds = true
                        
                        imageView.isUserInteractionEnabled = true
                        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
                        imageView.addGestureRecognizer(tap)
                        imageView.tag = i
                        
                        self.content.addSubview(imageView)
                        self.subViewArray.append(imageView)
                        imageView.snp.makeConstraints({ (make) in
                            //第一个
                            if i == 0{
                                make.top.equalTo(self.contentLabel.snp.bottom).offset(7)
                                make.left.equalTo(self.headIcon)
                            }else if i % 3 == 0{
                                //第一列
                                make.top.equalTo((lastLineImageView?.snp.bottom)!).offset(5)
                                make.left.equalTo(self.headIcon)
                            }else{
                                //其他
                                make.top.equalTo(lastImageView!)
                                make.left.equalTo((lastImageView?.snp.right)!).offset(5)
                            }
                            make.width.height.equalTo((SCREEN_WIDTH-10*2-5*2)/3.0)
                            //设置底边
                            if i == (model?.imageArray.count)!-1{
                                make.bottom.equalTo(-10)
                            }
                        })
                        //如果是最后一个设置关联
                        if i % 3 == 2{
                            lastLineImageView = imageView
                        }
                        lastImageView = imageView
                    }
                }
            }else if model?.type == WBMainContentType.Forwarding{
                //转发
                let fw = WBForwardingView.init(frame: CGRect.init())
                fw.model = self.model?.forwarding
                self.content.addSubview(fw)
                self.subViewArray.append(fw)
                fw.snp.makeConstraints({ (make) in
                    make.top.equalTo(self.contentLabel.snp.bottom).offset(7)
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    make.bottom.equalTo(0)
                })
                fw.contentLabel.delegate = self.contentLabel.delegate
                if (self.fatherView?.isKind(of: WBMainTableViewCell.classForCoder()))!{
                    let fatherV = self.fatherView as! WBMainTableViewCell
                    fw.content.addTarget(fatherV, action: #selector(fatherV.forwardingViewDidClick(forwardingView:)), for: UIControlEvents.touchUpInside)
                }
            }
        }
    }
    
    
    @IBOutlet var content: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
        self.contentLabel.linkTextColor = AMEColor(r: 37, g: 139, b: 255)
        self.contentLabel.regularType = [.aboat,.topic,.url]
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
        self.contentLabel.linkTextColor = AMEColor(r: 37, g: 139, b: 255)
        self.contentLabel.regularType = [.aboat,.topic,.url]
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
