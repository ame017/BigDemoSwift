//
//  WBForwardingView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/27.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
import SnapKit

class WBForwardingView: UIControl {
    @IBOutlet var content: UIControl!

    @IBOutlet weak var nineImageView: WBNineImageView!
    
    @IBOutlet weak var contentLabel: XXLinkLabel!
    
    @IBOutlet weak var singleImageView: UIImageView!
    
    private var lastBottomConstraint:Constraint?
    
    var model:WBMainContentModel?{
        didSet{
            let content = "@".appending((model?.name)!).appending(":") .appending((model?.content)!)
            self.contentLabel.text = content
            
            self.lastBottomConstraint?.deactivate()
            //有图
            if (model?.imageArray.count)! > 0 {
                //单张
                if model?.imageArray.count == 1{
                    self.nineImageView.isHidden = true
                    self.singleImageView.isHidden = false
                    
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
                    self.nineImageView.imageArray = (self.model?.imageArray)!
                    self.nineImageView.snp.makeConstraints({ (make) in
                        self.lastBottomConstraint = make.bottom.equalTo(-10).constraint
                    })
                }
            }else{
                //无图
                self.nineImageView.isHidden = true
                self.singleImageView.isHidden = true
            }
            self.content.layoutIfNeeded()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
        self.contentLabel.linkTextColor = AMEColor(r: 37, g: 139, b: 255)
        self.contentLabel.regularType = [.aboat,.topic,.url]
        self.contentLabel.delegate = self
        self.contentLabel.extend = self
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
        self.singleImageView.addGestureRecognizer(tap)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
        self.contentLabel.linkTextColor = AMEColor(r: 37, g: 139, b: 255)
        self.contentLabel.regularType = [.aboat,.topic,.url]
        self.contentLabel.delegate = self
        self.contentLabel.extend = self
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
        self.singleImageView.addGestureRecognizer(tap)
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        //nibName是你定义的xib文件名
        let nib = UINib(nibName: "WBForwardingView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIControl
        content.frame = bounds
        self.addSubview(content)
    }
    
    @objc func imageViewDidTap(tapGestureRecognizer:UITapGestureRecognizer) -> Void {
        let browser = XLPhotoBrowser.show(withImages: self.model?.imageArray, currentImageIndex: (tapGestureRecognizer.view?.tag)!)
        browser?.browserStyle = XLPhotoBrowserStyle.indexLabel
        browser?.sourceImageView = tapGestureRecognizer.view as! UIImageView
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
