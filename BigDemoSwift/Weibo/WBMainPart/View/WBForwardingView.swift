//
//  WBForwardingView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/27.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class WBForwardingView: UIControl {
    @IBOutlet var content: UIControl!
    
    @IBOutlet weak var contentLabel: XXLinkLabel!
    var model:WBMainContentModel?{
        didSet{
            let content = "@".appending((model?.name)!).appending(":") .appending((model?.content)!)
            self.contentLabel.text = content
            self.content.layoutIfNeeded()
            if (model?.imageArray.count)! > 0 {
                if model?.imageArray.count == 1{
                    let image = model?.imageArray[0]
                    let imageView = UIImageView.init(image: image)
                    
                    imageView.isUserInteractionEnabled = true
                    let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
                    imageView.addGestureRecognizer(tap)
                    imageView.tag = 0
                    
                    self.content.addSubview(imageView)
                    imageView.snp.makeConstraints({ (make) in
                        make.top.equalTo(contentLabel.snp.bottom).offset(5)
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
                        imageView.snp.makeConstraints({ (make) in
                            //第一个
                            if i == 0{
                                make.top.equalTo(self.contentLabel.snp.bottom).offset(5)
                                make.left.equalTo(10)
                            }else if i % 3 == 0{
                                //第一列
                                make.top.equalTo((lastLineImageView?.snp.bottom)!).offset(5)
                                make.left.equalTo(10)
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
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
        self.contentLabel.linkTextColor = AMEColor(r: 37, g: 139, b: 255)
        self.contentLabel.regularType = [.aboat,.topic,.url]
        self.contentLabel.delegate = self
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
        self.contentLabel.linkTextColor = AMEColor(r: 37, g: 139, b: 255)
        self.contentLabel.regularType = [.aboat,.topic,.url]
        self.contentLabel.delegate = self
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
