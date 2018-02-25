//
//  WBMainViewController.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/23.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class WBMainViewController: WBBaseViewController, WBMainHeaderViewDelegate ,UITableViewDelegate, UITableViewDataSource{

    

    @IBOutlet weak var MainTable: UITableView!
    var headDataArray = Array<WBMainHeaderModel>()
    
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
    }
    
    //MARK: - tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
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
    
    //MARK - headView.delegate
    func wb_mainHeaderView(_ HeaderView: WBMainHeaderView, imageViewDidClickWithIndex index: Int) {
        let alert = UIAlertController.init(title: "提示", message: "我被点击了".appending(String(index)), preferredStyle: UIAlertControllerStyle.alert)
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
