//
//  ELMMenuViewController.swift
//  BigDemoSwift
//
//  Created by ame on 2018/3/8.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

class ELMMenuViewController: ELMBaseViewController,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    let topViewUpHeight:CGFloat = CGFloat(kStatusBarAndNavigationBarHeight)
    let topViewDownHeight:CGFloat = 100 + CGFloat(kStatusBarAndNavigationBarHeight)
    let headIconMaxWidth:CGFloat = 80
    let likeButtonMaxWidth:CGFloat = 30
    let goBackButtonShowHeight:CGFloat = 80
    //默认150
    var tableViewUpTop:CGFloat = 100 + CGFloat(kStatusBarAndNavigationBarHeight) + 150
    let tableviewDownTop:CGFloat = SCREEN_HEIGHT - 80
    
    let goBackButtonStartShowHeight:CGFloat = (100 + CGFloat(kStatusBarAndNavigationBarHeight) + 150) + (SCREEN_HEIGHT - 80 - (100 + CGFloat(kStatusBarAndNavigationBarHeight) + 150))/2.0
    
    let searchButtonStartShowHeight:CGFloat = CGFloat(kStatusBarAndNavigationBarHeight+50)
    let searchButtonOverShowHeight:CGFloat = CGFloat(kStatusBarAndNavigationBarHeight)
    
    @IBOutlet weak var goBackButtonView: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var topBackImageView: UIImageView!
    @IBOutlet weak var headIconImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var miniSearchButton: UIButton!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var backView: ELMMenuBackView!
    
    
    @IBOutlet weak var backTopHeight: NSLayoutConstraint!
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var tableTopHeight: NSLayoutConstraint!
    @IBOutlet weak var headWidth: NSLayoutConstraint!
    @IBOutlet weak var headOffset: NSLayoutConstraint!
    //MARK: - lifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fd_prefersNavigationBarHidden = true
        self.goBackButtonView.alpha = 0
        self.backView.content.addTarget(self, action: #selector(self.backViewClick(_:)), for: UIControlEvents.touchUpInside)
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
            }
            //如果table的上距离小于最小值 赋值最小值
            if tableTopHeight.constant <= topViewUpHeight{
                tableTopHeight.constant = topViewUpHeight
            }else{
                //否则上推table
                scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                tableTopHeight.constant -= contentOffset
//                //如果top到顶
//                if topHeight.constant <= topViewUpHeight{
//                    backTopHeight.constant -= contentOffset
//                }
            }
        }else{
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
//                //top没到底
//                if topHeight.constant > topViewDownHeight{
//                    backTopHeight.constant -= contentOffset
//                }
//                //如果top到底
//                if topHeight.constant >= topViewDownHeight{
//                    backTopHeight.constant = 0
//                }
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
        //标题变化范围
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}