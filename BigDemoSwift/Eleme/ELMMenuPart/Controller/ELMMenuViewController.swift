//
//  ELMMenuViewController.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/8.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import SnapKit

class ELMMenuViewController: ELMBaseViewController,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    let topViewUpHeight:CGFloat = CGFloat(kStatusBarAndNavigationBarHeight)
    let topViewDownHeight:CGFloat = 100 + CGFloat(kStatusBarAndNavigationBarHeight)
    let headIconMaxWidth:CGFloat = 80
    let likeButtonMaxWidth:CGFloat = 30
    let goBackButtonShowHeight:CGFloat = 80
    //默认150
    var tableViewUpTop:CGFloat = 100 + CGFloat(kStatusBarAndNavigationBarHeight) + 150
    let tableviewDownTop:CGFloat = SCREEN_HEIGHT - 80
    
    var goBackButtonStartShowHeight:CGFloat = (100 + CGFloat(kStatusBarAndNavigationBarHeight) + 150) + (SCREEN_HEIGHT - 80 - (100 + CGFloat(kStatusBarAndNavigationBarHeight) + 150))/2.0
    
    let searchButtonStartShowHeight:CGFloat = CGFloat(kStatusBarAndNavigationBarHeight+50)
    let searchButtonOverShowHeight:CGFloat = CGFloat(kStatusBarAndNavigationBarHeight)
    
    private var isLayout = false
    private var preferentialDownHeight:CGFloat = 0.0
    private var secondDownHeight:CGFloat = 0.0
    private var thirdDownHeight:CGFloat = 0.0
    private var fourthDownHeight:CGFloat = 0.0
    
    @IBOutlet weak var goBackButtonView: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var topBackImageView: UIImageView!
    @IBOutlet weak var headIconImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var miniSearchButton: UIButton!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var topContentView: UIView!
    
    @IBOutlet weak var backView: ELMMenuBackView!
    
    
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var tableTopHeight: NSLayoutConstraint!
    @IBOutlet weak var headWidth: NSLayoutConstraint!
    @IBOutlet weak var headOffset: NSLayoutConstraint!
    
    private var tableViewTopDistance:Constraint?
    private var backTopHeight:Constraint?
    
    
    
    
    var model = ELMMenuBaseModel.init()
    
    //MARK: - lifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fd_prefersNavigationBarHidden = true
        self.goBackButtonView.alpha = 0
        self.backView.content.addTarget(self, action: #selector(self.backViewClick(_:)), for: UIControlEvents.touchUpInside)
        //代码创建两个约束
        self.backView.snp.makeConstraints { (make) in
            backTopHeight = make.top.equalTo(topContentView.snp.bottom).constraint
        }
        self.backTopHeight?.activate()
        
        model.name = "小白兔便当"
        model.score = 4.7
        model.seal = 315
        model.distance = 3150
        model.time = "约25分钟"
        model.way = "蜂鸟专送"
        model.announcement = "本店经营各种便当，好吃不贵，全是新鲜的食材，用料精良，欢迎各位新老顾客前来订餐。算上满减大概十多元一份，经济实惠，是您午餐与晚餐的不二之选。最近雨雪天气路滑，如有送餐迟到的情况请多多包涵。为了保证您能及时就餐，高峰时期请提前订餐。"
        let cModel0 = ELMMenuCharacteristicsModel.init()
        model.characteristicsArray.append(cModel0)
        let coupon0 = ELMMenuCouponModel.init()
        model.couponArray.append(coupon0)
        let pModel0 = ELMMenuPreferentialModel.init()
        pModel0.content = "满6减5，满30减22，满50减35，满100减70。"
        let pModel1 = ELMMenuPreferentialModel.init()
        pModel1.type = .firstOrder
        pModel1.content = "新人首单减16元。"
        let pModel2 = ELMMenuPreferentialModel.init()
        pModel2.type = .mumbership
        pModel2.content = "会员领6元无门槛红包。"
        model.preferentialArray = [pModel0,pModel1,pModel2]
        self.backView.model = model
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    //MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "OneScrollCell")
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 667-30-64
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        view.backgroundColor = UIColor.orange
        return view
    }
    @objc func backViewClick(_ sender: UIControl) {
        print("aoao")
        self.goToBottom()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
 //       print("scrollView.contentOffset.y:"+String(describing: scrollView.contentOffset.y))
        let contentOffset = scrollView.contentOffset.y
        if contentOffset > 0 {
            //上推
            //如果top的高度小于最小值 赋值最小值
            if tableTopHeight.constant <= tableViewUpTop{
                if topHeight.constant <= topViewUpHeight{
                    topHeight.constant = topViewUpHeight
                }else{
                    //否则当table在初始位置之上的时候减少top的height
                    if tableTopHeight.constant < tableviewDownTop{
                        scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                        topHeight.constant -= contentOffset
                    }
                }
                self.backTopHeight?.deactivate()
                self.tableViewTopDistance?.activate()
            }
            //如果table的上距离小于最小值 赋值最小值
            if tableTopHeight.constant <= topViewUpHeight{
                tableTopHeight.constant = topViewUpHeight
            }else{
                //否则上推table
                scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                tableTopHeight.constant -= contentOffset
            }
        }else if contentOffset < 0{
            //下拉
            if tableTopHeight.constant >= tableViewUpTop-(topViewDownHeight-topViewUpHeight){
                //如果topview的高度大于最大值 赋值最大值
                if topHeight.constant >= topViewDownHeight{
                    topHeight.constant = topViewDownHeight
                }else{
                    //否则下拉
                    scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                    topHeight.constant -= contentOffset
                }
            }
            //如果tableview的上边缘大于最大值 赋值最大值
            if tableTopHeight.constant >= tableviewDownTop{
                tableTopHeight.constant = tableviewDownTop
            }else{
                //否则下拉
                scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                tableTopHeight.constant -= contentOffset
                if tableTopHeight.constant > tableViewUpTop {
                    self.tableViewTopDistance?.deactivate()
                    self.backTopHeight?.activate()
                }
            }
        }
        //渐变向上按钮
        if tableTopHeight.constant > tableViewUpTop{
            tableview.alpha = 1-(tableTopHeight.constant - goBackButtonStartShowHeight)/goBackButtonShowHeight
            goBackButtonView.alpha = (tableTopHeight.constant - goBackButtonStartShowHeight)/goBackButtonShowHeight
        }
        //头像变化范围
        if tableTopHeight.constant < tableViewUpTop && tableTopHeight.constant > tableViewUpTop - headIconMaxWidth{
            headWidth.constant = tableTopHeight.constant - (tableViewUpTop - headIconMaxWidth+20)
            headOffset.constant = -((headWidth.constant)/headIconMaxWidth)*20
            headIconImageView.alpha = (headWidth.constant)/headIconMaxWidth
        }
        if tableTopHeight.constant <= tableViewUpTop - headIconMaxWidth {
            headWidth.constant = 0
            headIconImageView.alpha = 0
        }
        if tableTopHeight.constant >= tableViewUpTop {
            headWidth.constant = headIconMaxWidth
            headIconImageView.alpha = 1
        }
        //标题搜索栏变化范围
        if topHeight.constant < searchButtonStartShowHeight && topHeight.constant > searchButtonOverShowHeight {
            self.pinButton.alpha = (topHeight.constant - searchButtonOverShowHeight)/(searchButtonStartShowHeight-searchButtonOverShowHeight)
            self.miniSearchButton.alpha = (topHeight.constant - searchButtonOverShowHeight)/(searchButtonStartShowHeight-searchButtonOverShowHeight)
            self.searchButton.alpha = 1 - (topHeight.constant - searchButtonOverShowHeight)/(searchButtonStartShowHeight-searchButtonOverShowHeight)
        }
        if topHeight.constant <= searchButtonOverShowHeight {
            self.pinButton.alpha = 0
            self.miniSearchButton.alpha = 0
            self.searchButton.alpha = 1
        }
        if topHeight.constant >= searchButtonStartShowHeight {
            self.pinButton.alpha = 1
            self.miniSearchButton.alpha = 1
            self.searchButton.alpha = 0
        }
        //backView动效
        if tableTopHeight.constant > tableViewUpTop {
            //按优先级来
            if model.preferentialArray.count != 0{
                for view in backView.preferentialsView.arrangedSubviews{
                    let pView = view as! ELMPreferentialView
                    pView.contentLabel.numberOfLines = 0
                }
                //获取高度
                if preferentialDownHeight == 0{
                    for i in 0 ..< backView.preferentialsView.arrangedSubviews.count{
                        if i >= 3 {
                            break;
                        }
                        let pView = backView.preferentialsView.arrangedSubviews[i] as! ELMPreferentialView
                        preferentialDownHeight += pView.frame.size.height+5
                    }
                    preferentialDownHeight -= 7
                }
                let p = (tableTopHeight.constant - tableViewUpTop)/preferentialDownHeight
                if p <= 1{
                    backView.preferentialsView.snp.updateConstraints({ (make) in
                        make.left.equalTo(15+(backView.preferentialsViewOriginLeft-15) * (1-p))
                    })
                    backView.preferentialNumLabel.snp.updateConstraints({ (make) in
                        make.right.equalTo(-15+(backView.preferentialNumlabelOriginRight+15) * (1-p))
                    })
                    backView.downImageView.alpha = 1-p
                }
                if p > 1{
                    backView.preferentialsView.snp.updateConstraints({ (make) in
                        make.left.equalTo(15)
                    })
                    backView.preferentialNumLabel.snp.updateConstraints({ (make) in
                        make.right.equalTo(-15)
                    })
                    backView.downImageView.alpha = 0
                }
                //一行的高度
                let del = tableViewUpTop - topViewDownHeight - backView.preferentialsView.frame.origin.y
                //渐变
                if backView.preferentialsView.arrangedSubviews.count > 1{
                    for i in 1 ..< backView.preferentialsView.arrangedSubviews.count{
                        let beginTop = backView.preferentialsView.arrangedSubviews[i].frame.origin.y - del
                        let height = backView.preferentialsView.arrangedSubviews[i].frame.size.height
                        if tableTopHeight.constant - tableViewUpTop > beginTop{
                            backView.preferentialsView.arrangedSubviews[i].alpha = ((tableTopHeight.constant - tableViewUpTop) - beginTop)/height
                        }
                        if tableTopHeight.constant - tableViewUpTop > beginTop + height{
                            backView.preferentialsView.arrangedSubviews[i].alpha = 1
                        }
                    }
                }
            }
            if secondDownHeight == 0{
                if self.model.characteristicsArray.count > 0 {
                    secondDownHeight = 11 + 8 + 16 + 10
                }else{
                    secondDownHeight = 11 + 10
                }
            }
            //没有满减或者满减拉到了三个
            if tableTopHeight.constant > preferentialDownHeight + tableViewUpTop{
                //第二段
                let beginHeightSecond = preferentialDownHeight + tableViewUpTop
                if tableTopHeight.constant - beginHeightSecond <= secondDownHeight {
                    backView.announcementTextViewTop.constant -= contentOffset
                }
                let alphaChangeHeight = secondDownHeight - 12
                if tableTopHeight.constant - beginHeightSecond <= alphaChangeHeight {
                    let p = (tableTopHeight.constant - beginHeightSecond)/alphaChangeHeight
                    backView.smallContent.alpha = 1-p
                    backView.bigContent.alpha = p
                }else{
                    backView.smallContent.alpha = 0
                    backView.bigContent.alpha = 1
                }
                if self.model.characteristicsArray.count > 0{
                    let characteristicsBeginHeight = beginHeightSecond + secondDownHeight - 15
                    if tableTopHeight.constant - characteristicsBeginHeight <= 16{
                        let p = (tableTopHeight.constant - characteristicsBeginHeight)/16
                        backView.characteristicsView.alpha = p
                    }else{
                        backView.characteristicsView.alpha = 1
                    }
                }
                //第三段
                let beginHeightThird = beginHeightSecond + secondDownHeight
                if tableTopHeight.constant - beginHeightSecond > secondDownHeight{
                    if thirdDownHeight == 0{
                        let height = backView.announcementTextView.sizeThatFits(CGSize.init(width: SCREEN_WIDTH - 15*2, height: CGFloat(MAXFLOAT))).height
                        print("height:",height)
                        thirdDownHeight = height
                    }
                }
                if thirdDownHeight != 0 && tableTopHeight.constant - beginHeightThird <= thirdDownHeight {
                    if tableTopHeight.constant < beginHeightThird{
                        backView.announcementTextViewLeft.constant = backView.announcementTextViewOriginleftRight
                        backView.announcementTextViewRight.constant = backView.announcementTextViewOriginleftRight
                        backView.announcementTextViewHeight.constant = backView.announcementTextViewOriginHeight
                        backView.announcementView.alpha = 0
                    }else{
                        backView.announcementTextViewTop.constant -= contentOffset*((16+10)/thirdDownHeight)
                        backView.announcementTextViewHeight.constant -= contentOffset*(1-(16+10)/thirdDownHeight)
                        if tableTopHeight.constant - beginHeightThird <= 16+10{
                            backView.announcementTextViewLeft.constant = 15 + (backView.announcementTextViewOriginleftRight-15)*(1-(tableTopHeight.constant - beginHeightThird)/(16+10))
                            backView.announcementTextViewRight.constant = 15 + (backView.announcementTextViewOriginleftRight-15)*(1-(tableTopHeight.constant - beginHeightThird)/(16+10))
                        }else{
                            backView.announcementView.alpha = (tableTopHeight.constant - (beginHeightThird+16+10)) /  (thirdDownHeight-16-10)
                        }
                    }
                }
                //第四段
                let beginHeightFourth = beginHeightThird + thirdDownHeight
                if fourthDownHeight == 0{
                    if self.model.couponArray.count > 0 {
                        fourthDownHeight = 16+8+backView.couponOverHeight
                    }else{
                        fourthDownHeight = 16+8
                    }
                }
                if tableTopHeight.constant - beginHeightFourth <= fourthDownHeight{
                    if tableTopHeight.constant < beginHeightFourth{
                        if model.couponArray.count > 0{
                            for view in backView.couponView.arrangedSubviews{
                                view.snp.updateConstraints({ (make) in
                                    make.height.equalTo(backView.couponOriginHeight)
                                    make.width.equalTo(backView.couponOriginWidth)
                                })
                            }
                        }
                        backView.preferentialView.alpha = 0
                    }else{
                        if tableTopHeight.constant - beginHeightFourth <= 16 + 8{
                            backView.preferentialView.alpha = (tableTopHeight.constant - beginHeightFourth) / (16+8)
                            if model.couponArray.count > 0{
                                backView.couponView.snp.updateConstraints({ (make) in
                                    make.top.equalTo(backView.announcementTextView.snp.bottom).offset(backView.couponViewOriginTop + (tableTopHeight.constant - beginHeightFourth))
                                })
                            }else{
                                backView.preferentialsView.snp.updateConstraints({ (make) in
                                    make.top.equalTo(backView.announcementTextView.snp.bottom).offset(backView.preferentialsViewOriginTop + (tableTopHeight.constant - beginHeightFourth))
                                })
                            }
                        }else if tableTopHeight.constant <= beginHeightFourth + fourthDownHeight{
                            if model.couponArray.count > 0{
                                let p = (tableTopHeight.constant - beginHeightFourth - 16 - 8) / (fourthDownHeight - 16 - 8)

                                let width = backView.couponOriginWidth + (backView.couponOverWidth - backView.couponOriginWidth) * p
                                let height = backView.couponOriginHeight + (backView.couponOverHeight - backView.couponOriginHeight) * p
                                for view in backView.couponView.arrangedSubviews{
                                    view.snp.updateConstraints({ (make) in
                                        make.width.equalTo(width)
                                        make.height.equalTo(height)
                                    })
                                    let conponView = view as! ELMCouponView
                                    if height < 30{
                                        conponView.smallContent.alpha = 1
                                        conponView.bigContent.alpha = 0
                                    }
                                    if height >= 30 && height <= 45{
                                        let alphaP = (height - 30) / (45-30)
                                        conponView.smallContent.alpha = 1 - alphaP
                                        conponView.bigContent.alpha = alphaP
                                    }
                                    if height > 45{
                                        conponView.smallContent.alpha = 0
                                        conponView.bigContent.alpha = 1
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }else if tableTopHeight.constant > tableViewUpTop-30{
            //缓冲一下
            backView.returnToInitAlpha()
            backView.returnToInitConstant()
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableTopHeight.constant < goBackButtonStartShowHeight && tableTopHeight.constant > tableViewUpTop {
            self.returnToNormal()
        }else if tableTopHeight.constant >= goBackButtonStartShowHeight{
            self.goToBottom()
        }
    }
    
    @IBAction func goBackButtonClick(_ sender: Any) {
        self.returnToNormal()
    }
    func returnToNormal() -> Void {
        tableTopHeight.constant = tableViewUpTop
        backView.returnToInitConstant()
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.tableview.alpha = 1
            self.goBackButtonView.alpha = 0
            self.backView.returnToInitAlpha()
        }) { (completion) in
            
        }
    }
    func goToBottom() -> Void {
        tableTopHeight.constant = tableviewDownTop
        backView.goToOverConstant()
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.tableview.alpha = 0
            self.goBackButtonView.alpha = 1
            self.backView.goToOverAlpha()
        }) { (completion) in
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //修正初始布局
        if self.isLayout == false{
            var normalHeight:CGFloat = 0
            if self.model.preferentialArray.count > 0 {
                if self.backView.preferentialsView.frame.origin.y != 0{
                    self.isLayout = true
                    normalHeight = self.backView.preferentialsView.frame.origin.y + self.backView.preferentialsView.arrangedSubviews[0].frame.size.height + 2
                }
            }else if self.model.couponArray.count > 0 {
                if self.backView.couponView.frame.origin.y != 0{
                    self.isLayout = true
                    normalHeight = self.backView.couponView.frame.origin.y + self.backView.couponView.frame.size.height + 2
                }
            }else{
                if self.backView.announcementView.frame.origin.y != 0{
                    self.isLayout = true
                    normalHeight = self.backView.announcementView.frame.origin.y + self.backView.announcementView.frame.size.height + 20
                }
            }
            tableViewUpTop = topViewDownHeight + normalHeight
            tableTopHeight.constant = tableViewUpTop
            goBackButtonStartShowHeight = tableViewUpTop + (tableviewDownTop - tableViewUpTop)/2.0
            
            self.tableview.snp.makeConstraints({ (make) in
                tableViewTopDistance = make.top.equalTo(self.backView).offset(tableViewUpTop-topViewDownHeight).constraint
            })
            self.tableViewTopDistance?.deactivate()
        }
        
    }
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "back"{
            self.navigationController?.popViewController(animated: true)
        }
    }
     */

}
