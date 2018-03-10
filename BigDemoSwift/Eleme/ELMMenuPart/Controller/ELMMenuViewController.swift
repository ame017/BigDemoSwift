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

    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var tableTopHeight: NSLayoutConstraint!
    let lastOffset:CGFloat = 0
    @IBOutlet weak var goBackButtonView: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var headWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fd_prefersNavigationBarHidden = true
        self.goBackButtonView.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0{
//            var cell = tableView.dequeueReusableCell(withIdentifier: "0")
//            if cell == nil{
//                cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "0")
//                cell!.backgroundColor = UIColor.clear
//                cell?.isUserInteractionEnabled = false
//            }
//            return cell!
//        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "1")
            if cell == nil{
                cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "1")
                cell!.backgroundColor = UIColor.blue
            }

            return cell!
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 667+164+150
//        }else{
            return 667-30-64
//        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0.01
//        }else{
            return 30
//        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 {
//            return UIView.init()
//        }else{
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
            view.backgroundColor = UIColor.orange
            return view
//        }
    }
    @IBAction func backViewClick(_ sender: UIControl) {
        print("aoao")
        self.goToBottom()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let contentOffset = scrollView.contentOffset.y
//        let del = contentOffset - lastOffset
        if contentOffset > 0 {
            //上推
            if topHeight.constant <= 64{
                topHeight.constant = 64
            }else{
                if tableTopHeight.constant < (164+150){
                    scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                    topHeight.constant -= contentOffset
                }
            }
            if tableTopHeight.constant <= 64{
                tableTopHeight.constant = 64
            }else{
                scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                tableTopHeight.constant -= contentOffset
            }
        }else{
            if topHeight.constant >= 164{
                topHeight.constant = 164
            }else{
                topHeight.constant -= contentOffset
            }
            if tableTopHeight.constant >= (667-80){
                tableTopHeight.constant = 667-80
            }else{
                scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                tableTopHeight.constant -= contentOffset
            }
        }
        if tableTopHeight.constant > 150+164+150{
            tableview.alpha = 1.0/((667-80-(150+164+150))/(tableTopHeight.constant-(150+164+150)))
            goBackButtonView.alpha = ((667-80-(150+164+150))/(tableTopHeight.constant-(150+164+150)))
        }
        if tableTopHeight.constant < 150+164 && tableTopHeight.constant > 164+50{
            headWidth.constant = tableTopHeight.constant - (164+50)
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("1111")
        if tableTopHeight.constant < 150+164+150 && tableTopHeight.constant > 150+164 {
            self.returnToNormal()
        }else if tableTopHeight.constant >= 150+164+150{
            self.goToBottom()
        }
    }
    
    @IBAction func goBackButtonClick(_ sender: Any) {
        self.returnToNormal()
    }
    func returnToNormal() -> Void {
        tableTopHeight.constant = 150+164
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.tableview.alpha = 1
            self.goBackButtonView.alpha = 0
        }) { (completion) in
            
        }
    }
    func goToBottom() -> Void {
        tableTopHeight.constant = 667-80
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
