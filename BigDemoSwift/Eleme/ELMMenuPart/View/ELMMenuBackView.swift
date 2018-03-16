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
    @IBOutlet weak var announcementLabel: UILabel!
    
    @IBOutlet weak var announcementLabelMaskView: UIView!
    
    
    let preferentialsViewOriginLeft:CGFloat = 25
    let preferentialNumlabelOriginRight:CGFloat = -36
    let announcementLabelOriginTop:CGFloat = 5
    let announcementLabelOriginleftRight:CGFloat = 25
    let announcementLabelMaskOriginTop:CGFloat = 11
    
    @IBOutlet weak var announcementLabelTop: NSLayoutConstraint!
    @IBOutlet weak var announcementLabelLeft: NSLayoutConstraint!
    @IBOutlet weak var announcementLabelRight: NSLayoutConstraint!
    @IBOutlet weak var announcementLabelMaskHeight: NSLayoutConstraint!
    @IBOutlet weak var announcementLabelMaskTop: NSLayoutConstraint!
    
    
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
                attrDistance.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: NSRange.init(location: distance.count-1-2, length: 2))
                attrDistance.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16), range: NSRange.init(location: 0, length: distance.count-2))
            }else{
                attrDistance.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: NSRange.init(location: distance.count-1-1, length: 1))
                attrDistance.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16), range: NSRange.init(location: 0, length: distance.count - 1))
            }
            distanceLabelBig.attributedText = attrDistance
            
            
            
            let attrAnnouncement = NSMutableAttributedString.init(string: (model?.announcement)!)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            attrAnnouncement.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: (model?.announcement.count)!))
            attrAnnouncement.addAttribute(NSAttributedStringKey.foregroundColor, value:UIColor.darkGray , range: NSRange.init(location: 0, length: (model?.announcement.count)!))
            announcementLabel.attributedText = attrAnnouncement
            announcementLabel.lineBreakMode = .byTruncatingTail
            
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
                    make.top.equalTo(announcementLabelMaskView.snp.bottom).offset(12)
                    make.centerX.equalToSuperview()
                })
                preferentialView.snp.makeConstraints({ (make) in
                    make.bottom.equalTo(couponView.snp.top).offset(-15)
                })
                for i in 0 ..< (model?.couponArray.count)! {
                    let coupon = ELMCouponView.init(frame: CGRect.init())
                    coupon.model = model?.couponArray[i]
                    couponView.addArrangedSubview(coupon)
                    coupon.snp.makeConstraints({ (make) in
                        make.width.equalTo(110)
                        make.height.equalTo(20)
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
                        make.top.equalTo(announcementLabel.snp.bottom).offset(10)
                    }
                    make.left.equalTo(preferentialsViewOriginLeft)
                    make.width.equalTo(SCREEN_WIDTH-30-30-41-40)
                })
                if model?.couponArray.count == 0{
                    preferentialView.snp.makeConstraints({ (make) in
                        make.bottom.equalTo(preferentialsView.snp.top).offset(-15)
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
