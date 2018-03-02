//
//  WBNineImageView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/1.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
import SnapKit

class WBNineImageView: UIView {
    @IBOutlet var content: UIView!
    
    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    
    private var imageViewArray:Array<UIImageView>!
    private var lastBottomConstraint:Constraint?
    
    var imageArray = Array<UIImage>(){
        didSet{
            for i in 0..<imageViewArray.count {
                if i < imageArray.count{
                    imageViewArray[i].image = imageArray[i]
                    imageViewArray[i].isHidden = false
                    imageViewArray[i].isUserInteractionEnabled = true
                }else{
                    imageViewArray[i].isHidden = true
                    imageViewArray[i].isUserInteractionEnabled = false
                }
            }
            lastBottomConstraint?.deactivate()
            imageViewArray[imageArray.count - 1].snp.makeConstraints({ (make) in
                self.lastBottomConstraint = make.bottom.equalTo(0).constraint
            })
            self.content.layoutIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
        imageViewArray = [self.imageView0,self.imageView1,self.imageView2,self.imageView3,self.imageView4,self.imageView5,self.imageView6,self.imageView7,self.imageView8]
        for i in 0..<imageViewArray.count{
            let imageView = imageViewArray[i]
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
            imageView.addGestureRecognizer(tap)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
        imageViewArray = [self.imageView0,self.imageView1,self.imageView2,self.imageView3,self.imageView4,self.imageView5,self.imageView6,self.imageView7,self.imageView8]
        for i in 0..<imageViewArray.count{
            let imageView = imageViewArray[i]
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap(tapGestureRecognizer:)))
            imageView.addGestureRecognizer(tap)
        }
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        //nibName是你定义的xib文件名
        let nib = UINib(nibName: "WBNineImageView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        content.frame = bounds
        self.addSubview(content)
    }
    
    @objc func imageViewDidTap(tapGestureRecognizer:UITapGestureRecognizer){
        let browser = XLPhotoBrowser.show(withImages: self.imageArray, currentImageIndex: (tapGestureRecognizer.view?.tag)!)
        browser?.browserStyle = XLPhotoBrowserStyle.indexLabel
        browser?.sourceImageView = tapGestureRecognizer.view as! UIImageView
    }
    
//    override func updateConstraints() {
//        lastBottomConstraint?.deactivate()
//        imageViewArray[imageArray.count - 1].snp.updateConstraints({ (make) in
//            self.lastBottomConstraint = make.bottom.equalTo(0).constraint
//        })
//        super.updateConstraints()
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
