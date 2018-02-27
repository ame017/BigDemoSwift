//
//  WBMainViewController.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/23.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class WBMainViewController: WBBaseViewController, WBMainHeaderViewDelegate ,UITableViewDelegate, UITableViewDataSource, WBMainTableViewCellDelegate{

    

    @IBOutlet weak var MainTable: UITableView!
    var headDataArray = Array<WBMainHeaderModel>()
    var testModel = WBMainContentModel()
    var testModelOneImage = WBMainContentModel()
    var testModelMoreImage = WBMainContentModel()
    var forwardingModel = WBMainContentModel()
    
    
    
    //MARK: - lifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - getData
    func getData() -> Void {
        for i in 0...4 {
            let model = WBMainHeaderModel()
            let image = UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))
            model.image = image
            if i == 0{
                model.name = "我的故事"
            }else{
                model.name = "微博".appending(String(i))
            }
            model.urlIndex = i
            self.headDataArray.append(model)
        }
        self.testModel.contentId = 0
        self.testModel.type = WBMainContentType.Single
        self.testModel.headIcon =  UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))
        self.testModel.userType = WBContentUserType.Yellow
        self.testModel.name = "时雨大人6666666"
        self.testModel.vipLevel = 4
        self.testModel.time = "2018-2-26 10:00:00"
        self.testModel.from = "iPhone X"
        self.testModel.content = "#首发##陈慧琳#新歌《尾站天国》公开！歌曲讲述一对恋人有幸结缘，但因种种原因，其中一方先要下车暂别，令这段恋情有缘无份。然而，虽然主角的爱人离开，但他深信，只要相爱，就算是下辈子也可以与再次结缘，并一同坐上同一班车，延续他们的爱情故事。@环球音乐华语部"
        self.testModel.forwardingNum = 1
        self.testModel.remarkNum = 0
        self.testModel.likeNum = 0
        
        self.testModelOneImage.contentId = 1
        self.testModelOneImage.type = WBMainContentType.Image
        self.testModelOneImage.headIcon = UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))
        self.testModelOneImage.userType = WBContentUserType.Blue
        self.testModelOneImage.name = "时雨"
        self.testModelOneImage.vipLevel = -1
        self.testModelOneImage.time = "2018-2-26 13:00:00"
        self.testModelOneImage.from = "iPhone X"
        self.testModelOneImage.content = "#初音家#我喜欢这个壁纸!!@长颈鹿"
        self.testModelOneImage.forwardingNum = 99
        self.testModelOneImage.remarkNum = 7
        self.testModelOneImage.likeNum = 23
        self.testModelOneImage.imageArray = [#imageLiteral(resourceName: "miku.jpg")]
        
        self.testModelMoreImage.contentId = 2
        self.testModelMoreImage.type = WBMainContentType.Image
        self.testModelMoreImage.headIcon = UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))
        self.testModelMoreImage.userType = WBContentUserType.Blue
        self.testModelMoreImage.name = "长颈鹿"
        self.testModelMoreImage.vipLevel = 7
        self.testModelMoreImage.time = "2018-2-26 15:55:00"
        self.testModelMoreImage.from = ""
        self.testModelMoreImage.content = "#头像##头像头像头像##神特么的头像# https://dashalu.com 这个网址全是好看的图!!!@小白兔 "
        self.testModelMoreImage.forwardingNum = 22
        self.testModelMoreImage.remarkNum = 0
        self.testModelMoreImage.likeNum = 5
        self.testModelMoreImage.imageArray = [UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!,UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!,UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!,UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!,UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!,UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!,UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!,UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!,UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!]
        
        self.forwardingModel.contentId = 3
        self.forwardingModel.type = WBMainContentType.Forwarding
        self.forwardingModel.headIcon = UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))
        self.forwardingModel.userType = WBContentUserType.Normal
        self.forwardingModel.name = "小白兔"
        self.forwardingModel.vipLevel = 0
        self.forwardingModel.time = "2018-2-27 9:00:00"
        self.forwardingModel.from = "iPhone SE(4G)"
        self.forwardingModel.content = "转需@长颈鹿"
        self.forwardingModel.forwardingNum = 0
        self.forwardingModel.remarkNum = 0
        self.forwardingModel.likeNum = 0
        self.forwardingModel.forwarding = self.testModelMoreImage
    }
    
    //MARK: - tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? WBMainTableViewCell
        let row = indexPath.row % 4
        if row == 1 {
            cell?.model = self.testModel
        }else if row == 2{
            cell?.model = self.testModelOneImage
        }else if row == 3{
            cell?.model = self.testModelMoreImage
        }else{
            cell?.model = self.forwardingModel
        }
        cell?.delegate = self
        return cell!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = WBMainHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        headView.dataArray = self.headDataArray
        headView.delegate = self
        return headView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
    //MARK - headView.delegate
    func wb_mainHeaderView(_ HeaderView: WBMainHeaderView, imageViewDidClickWithIndex index: Int) {
        let alert = UIAlertController.init(title: "提示", message: "我被点击了:".appending(String(index)), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    func wb_mainTableViewCell(_ cell: WBMainTableViewCell, linkDidClick linkString: String) {
        let alert = UIAlertController.init(title: "提示", message: "我被点击了:".appending(linkString), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
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
