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
        model.score = 5.0
        model.seal = 315
        model.distance = 3150
        model.time = "约25分钟"
        model.way = "蜂鸟专送"
        model.announcement = "本店经营各种便当，好吃不贵，全是新鲜的小白兔，长颈鹿负责亲自烹调，高峰时期为了避免拥堵，请您提前订餐。"
        let cModel0 = ELMMenuCharacteristicsModel.init()
        model.characteristicsArray.append(cModel0)
        let coupon0 = ELMMenuCouponModel.init()
        model.couponArray.append(coupon0)
        let pModel0 = ELMMenuPreferentialModel.init()
        pModel0.content = "满6减5，满30减22，满50减35，满100减70."
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
        print(scrollView.contentOffset.y)
        let contentOffset = scrollView.contentOffset.y
//        let del = contentOffset - lastOffset
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
//                print(backTopHeight?.isActive)
//                print(tableViewTopDistance?.isActive)
                print(backView.titleLabel.frame)
                print(backView.frame)
                print(tableview.frame)
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
                    for view in backView.preferentialsView.arrangedSubviews{
                        let pView = view as! ELMPreferentialView
                        preferentialDownHeight += pView.frame.size.height+5
                    }
                    preferentialDownHeight -= 5
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
            }
            if tableTopHeight.constant - tableViewUpTop > preferentialDownHeight{
                
            }
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
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.tableview.alpha = 1
            self.goBackButtonView.alpha = 0
        }) { (completion) in
            
        }
    }
    func goToBottom() -> Void {
        tableTopHeight.constant = tableviewDownTop
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.tableview.alpha = 0
            self.goBackButtonView.alpha = 1
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
