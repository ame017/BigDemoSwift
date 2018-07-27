//
//  ELMMenuBackView.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/13.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
import SnapKit

class ELMMenuBackView: UIControl {
    @IBOutlet var content: UIControl!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var smallContent: UIView!
    @IBOutlet weak var starsViewSmall: RatingBar!
    @IBOutlet weak var scoreLabelSmall: UILabel!
    @IBOutlet weak var sealLabelSmall: UILabel!
    @IBOutlet weak var timeLabelSmall: UILabel!
    @IBOutlet weak var wayLabelSmall: UILabel!
    
    @IBOutlet weak var bigContent: UIView!
    @IBOutlet weak var starsViewBig: RatingBar!
    @IBOutlet weak var scoreLabelBig: UILabel!
    @IBOutlet weak var sealLabelBig: UILabel!
    @IBOutlet weak var timeLabelBig: UILabel!
    @IBOutlet weak var wayLabelBig: UILabel!
    @IBOutlet weak var distanceLabelBig: UILabel!
    
    @IBOutlet weak var preferentialView: UIView!
    @IBOutlet weak var announcementView: UIView!
    @IBOutlet weak var announcementTextView:UITextView!
    
    
    let preferentialsViewOriginLeft:CGFloat = 25
    let preferentialNumlabelOriginRight:CGFloat = -36
    let announcementTextViewOriginTop:CGFloat = -3
    let announcementTextViewOriginleftRight:CGFloat = 25
    let announcementTextViewOriginHeight:CGFloat = 27
    
    
    let couponOriginHeight:CGFloat = 25
    let couponOriginWidth:CGFloat = 110
    
    let couponOverWidth:CGFloat = (SCREEN_WIDTH-10)/2.0
    let couponOverHeight:CGFloat = ((SCREEN_WIDTH-10)/2.0)/157.0*51
    
    let couponViewOriginTop:CGFloat = 0
    let preferentialsViewOriginTop:CGFloat = 0
    
    let preferentialViewOriginBottom:CGFloat = -12
    
    
    @IBOutlet weak var announcementTextViewTop: NSLayoutConstraint!
    @IBOutlet weak var announcementTextViewLeft: NSLayoutConstraint!
    @IBOutlet weak var announcementTextViewRight: NSLayoutConstraint!
    @IBOutlet weak var announcementTextViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var preferentialViewTop: NSLayoutConstraint!
    var downImageView = UIImageView.init()
    
    var characteristicsView = UIStackView.init()
    var couponView = UIStackView.init()
    var preferentialsView = UIStackView.init()
    var preferentialNumLabel = UILabel.init()
    
    var model:ELMMenuBaseModel?{
        didSet{
            titleLabel.text = model?.name
            starsViewSmall.rating = CGFloat((model?.score)!)
            scoreLabelSmall.text = String((model?.score)!)
            sealLabelSmall.text = String((model?.seal)!)
            timeLabelSmall.text = model?.time
            wayLabelSmall.text = model?.way
            
            starsViewBig.rating = CGFloat((model?.score)!)
            scoreLabelBig.text = String((model?.score)!)
            sealLabelBig.text = String((model?.seal)!)
            timeLabelBig.text = model?.time
            wayLabelBig.text = model?.way
            
            var distance = ""
            if (model?.distance)! >= 1000{
                distance = String(Double((model?.distance)!) / 1000.0).appending("km")
            }else{
                distance = String((model?.distance)!).appending("m")
            }
            let attrDistance = NSMutableAttributedString.init(string: distance)
            if (model?.distance)! >= 1000{
                attrDistance.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: NSRange.init(location: distance.count-2, length: 2))
                attrDistance.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16), range: NSRange.init(location: 0, length: distance.count-2))
            }else{
                attrDistance.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: NSRange.init(location: distance.count-1, length: 1))
                attrDistance.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16), range: NSRange.init(location: 0, length: distance.count - 1))
            }
            distanceLabelBig.attributedText = attrDistance
            
            announcementTextView.text = model?.announcement
            
            if (model?.characteristicsArray.count)! > 0{
                characteristicsView.spacing = 5
                characteristicsView.alpha = 0
                characteristicsView.axis = .horizontal
                self.content.addSubview(characteristicsView)
                characteristicsView.snp.makeConstraints({ (make) in
                    make.top.equalTo(bigContent.snp.bottom).offset(8)
                    make.centerX.equalToSuperview()
                })
                for i in 0 ..< (model?.characteristicsArray.count)! {
                    let label = UILabel.init()
                    switch (model?.characteristicsArray[i].type)!{
                        case .onTime:
                            label.text = "准时达"
                            label.font = UIFont.systemFont(ofSize: 11)
                            label.textColor = AMEColor(r: 68, g: 155, b: 235)
                            label.textAlignment = .center
                            label.clipsToBounds = true
                            label.layer.cornerRadius = 3.0
                            label.layer.borderWidth = 1.0
                            label.layer.borderColor = UIColor.init(white: 0.9, alpha: 1.0).cgColor
                        case .refused:
                            label.text = "拒单赔"
                            label.font = UIFont.systemFont(ofSize: 11)
                            label.textColor = UIColor.darkGray
                            label.textAlignment = .center
                            label.clipsToBounds = true
                            label.layer.cornerRadius = 3.0
                            label.layer.borderWidth = 1.0
                            label.layer.borderColor = UIColor.init(white: 0.9, alpha: 1.0).cgColor
                    }
                    characteristicsView.addArrangedSubview(label)
                    label.snp.makeConstraints({ (make) in
                        make.width.equalTo(45)
                        make.height.equalTo(16)
                    })
                }
            }
            
            if (model?.couponArray.count)! > 0 {
                couponView.spacing = 10
                couponView.axis = .horizontal
                self.content.addSubview(couponView)
                couponView.snp.makeConstraints({ (make) in
                    make.top.equalTo(announcementTextView.snp.bottom).offset(couponViewOriginTop)
                    make.centerX.equalToSuperview()
                })
                preferentialViewTop.isActive = false
                preferentialView.snp.makeConstraints({ (make) in
                    make.bottom.equalTo(couponView.snp.top).offset(preferentialViewOriginBottom)
                })
                for i in 0 ..< (model?.couponArray.count)! {
                    let coupon = ELMCouponView.init(frame: CGRect.init())
                    coupon.model = model?.couponArray[i]
                    couponView.addArrangedSubview(coupon)
                    coupon.snp.makeConstraints({ (make) in
                        make.width.equalTo(110)
                        make.height.equalTo(25)
                    })
                }
            }
            
            if (model?.preferentialArray.count)! > 0 {
                preferentialNumLabel = UILabel.init()
                preferentialNumLabel.font = UIFont.systemFont(ofSize: 11)
                preferentialNumLabel.textColor = UIColor.gray
                preferentialNumLabel.text = String((model?.preferentialArray.count)!).appending("个优惠")
                self.content.addSubview(preferentialNumLabel)
                
                downImageView.image = #imageLiteral(resourceName: "shopping_activity_count_arrow_6x3_")
                self.content.addSubview(downImageView)
                
                preferentialsView.spacing = 5
                preferentialsView.axis = .vertical
                self.content.addSubview(preferentialsView)
                
                
                downImageView.snp.makeConstraints({ (make) in
                    make.right.equalTo(-25)
                    make.width.equalTo(6)
                    make.height.equalTo(3)
                    make.centerY.equalTo(preferentialNumLabel)
                })
                
                preferentialNumLabel.snp.makeConstraints({ (make) in
                    make.right.equalTo(preferentialNumlabelOriginRight)
                    make.top.equalTo(preferentialsView)
                })
                
                preferentialsView.snp.makeConstraints({ (make) in
                    if (self.model?.couponArray.count)! > 0{
                        make.top.equalTo(couponView.snp.bottom).offset(10)
                    }else{
                        make.top.equalTo(announcementTextView.snp.bottom).offset(preferentialsViewOriginTop)
                    }
                    make.left.equalTo(preferentialsViewOriginLeft)
                    make.width.equalTo(SCREEN_WIDTH-30-30-41-40)
                })
                if model?.couponArray.count == 0{
                    preferentialViewTop.isActive = false
                    preferentialView.snp.makeConstraints({ (make) in
                        make.bottom.equalTo(preferentialsView.snp.top).offset(preferentialViewOriginBottom)
                    })
                }
                
                for i in 0 ..< (model?.preferentialArray.count)! {
                    let preferential = ELMPreferentialView.init(frame: CGRect.init())
                    preferential.model = model?.preferentialArray[i]
                    self.preferentialsView.addArrangedSubview(preferential)
                }
            }

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
        announcementTextView.textContainer.lineBreakMode = .byTruncatingTail
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
        announcementTextView.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        //nibName是你定义的xib文件名
        let nib = UINib(nibName: "ELMMenuBackView", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil)[0] as! UIControl
        content.frame = bounds
        self.addSubview(content)
    }
    
    func returnToInitConstant() -> Void {
        if (model?.preferentialArray.count)! > 0{
            for view in preferentialsView.arrangedSubviews{
                let pView = view as! ELMPreferentialView
                pView.contentLabel.numberOfLines = 1
            }
            preferentialsView.snp.updateConstraints({ (make) in
                make.left.equalTo(preferentialsViewOriginLeft)
            })
            preferentialNumLabel.snp.updateConstraints({ (make) in
                make.right.equalTo(preferentialNumlabelOriginRight)
            })
        }
        announcementTextViewTop.constant = announcementTextViewOriginTop
        announcementTextViewLeft.constant = announcementTextViewOriginleftRight
        announcementTextViewRight.constant = announcementTextViewOriginleftRight
        announcementTextViewHeight.constant = announcementTextViewOriginHeight
        if (model?.couponArray.count)! > 0{
            for view in couponView.arrangedSubviews{
                view.snp.updateConstraints({ (make) in
                    make.height.equalTo(couponOriginHeight)
                    make.width.equalTo(couponOriginWidth)
                })
            }
            couponView.snp.updateConstraints({ (make) in
                make.top.equalTo(announcementTextView.snp.bottom).offset(couponViewOriginTop)
            })
        }else{
            preferentialsView.snp.updateConstraints { (make) in
                make.top.equalTo(announcementTextView.snp.bottom).offset(preferentialsViewOriginTop)
            }
        }
    }
    
    func goToOverConstant() -> Void {
        if (model?.preferentialArray.count)! > 0{
            for view in preferentialsView.arrangedSubviews{
                let pView = view as! ELMPreferentialView
                pView.contentLabel.numberOfLines = 0
            }
            preferentialsView.snp.updateConstraints({ (make) in
                make.left.equalTo(15)
            })
            preferentialNumLabel.snp.updateConstraints({ (make) in
                make.right.equalTo(-15)
            })
        }
        var secondDownHeight:CGFloat = 0.0
        if (self.model?.characteristicsArray.count)! > 0 {
            secondDownHeight = 11 + 8 + 16 + 10
        }else{
            secondDownHeight = 11 + 10
        }
        let height = announcementTextView.sizeThatFits(CGSize.init(width: SCREEN_WIDTH - 15*2, height: CGFloat(MAXFLOAT))).height
        announcementTextViewTop.constant = announcementTextViewOriginTop + secondDownHeight + height * ((16+10)/height)
        announcementTextViewLeft.constant = 15
        announcementTextViewRight.constant = 15
        announcementTextViewHeight.constant = announcementTextViewOriginHeight + height * (1-(16+10)/height)
        
        if (model?.couponArray.count)! > 0{
            for view in couponView.arrangedSubviews{
                view.snp.updateConstraints({ (make) in
                    make.height.equalTo(couponOverHeight)
                    make.width.equalTo(couponOverWidth)
                })
            }
            couponView.snp.updateConstraints({ (make) in
                make.top.equalTo(announcementTextView.snp.bottom).offset(couponViewOriginTop+16+8)
            })
        }else{
            preferentialsView.snp.updateConstraints { (make) in
                make.top.equalTo(announcementTextView.snp.bottom).offset(preferentialsViewOriginTop+16+8)
            }
        }
    }
    
    func returnToInitAlpha() -> Void {
        if (model?.preferentialArray.count)! > 0{
            for view in preferentialsView.arrangedSubviews{
                view.alpha = 1
            }
            downImageView.alpha = 1
        }
        smallContent.alpha = 1
        bigContent.alpha = 0
        characteristicsView.alpha = 0
        announcementView.alpha = 0
        if (model?.couponArray.count)! > 0{
            for view in couponView.arrangedSubviews{
                let conponView = view as! ELMCouponView
                conponView.smallContent.alpha = 1
                conponView.bigContent.alpha = 0
            }
        }else{
            
        }
        preferentialView.alpha = 0
    }
    func goToOverAlpha() -> Void {
        if (model?.preferentialArray.count)! > 0{
            for view in preferentialsView.arrangedSubviews{
                view.alpha = 1
            }
            downImageView.alpha = 0
        }
        smallContent.alpha = 0
        bigContent.alpha = 1
        characteristicsView.alpha = 1
        announcementView.alpha = 1
        if (model?.couponArray.count)! > 0{
            for view in couponView.arrangedSubviews{
                let conponView = view as! ELMCouponView
                conponView.smallContent.alpha = 0
                conponView.bigContent.alpha = 1
            }
        }else{
            
        }
        preferentialView.alpha = 1
    }
}
