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
    var dataArray = Array<WBMainContentModel>()
//    var testModel = WBMainContentModel()
//    var testModelOneImage = WBMainContentModel()
//    var testModelMoreImage = WBMainContentModel()
//    var forwardingModel = WBMainContentModel()
    
    let nameArray = ["Takanotakashi","该用户已和谐丶","七十一号街幽灵","MADAO注孤生百分百","星宫本蒸気液","晴大西","口口口口口口少","boom天天在爆炸","魔理沙喜歡愛麗絲玛格特罗伊德","-米斯蒂娅_萝蕾拉-","超铃音","你彤爷","長门大魔神","日_推"]
    let contentArray = ["NICO动画宣布，今天起观看视频不再需要登录/注册账号，生放送和APP日后也将支持 ​​​​","投降了…我贴膜水平驾驭不了这玩意 ​​​​","#不像我，才是我#被@魏晨 的气场和片子的张力震撼了。也许是因为视频所表达的“勇于探索真我”的态度，是来自魏晨内心，所以才这么富有感染力吧。不畏“人设”，坚持探索自我，这无疑是@361度 和魏晨最契合的部分，也是最让年轻人有共鸣的地方。你探索自我的过程是否也如视频中魏晨上演的那般？","#虾米热评# 告白张国荣：时间会改变一切，但有些需要铭记于心，在我们心中，哥哥永远都是那颗最闪耀的星星，我们永远都爱这样的你，今生今世，为您钟情。立即参加：http://music.xiami.com"," @DNAsdw 我错了……那会儿我跟同事一起去A店玩，然后她想roll个挪椅子，一直没roll到，后来一气之下就买了整个一盒，拿走了挪椅子和命苦叔之后，剩下的全给我了……我看着反正也有多余的，就给自己挂了个苍叶，给他挂了个红雀，毕竟同事告诉我那是官cp……后来我包上的苍叶掉了，他那个就一直挂了两年多，昨儿他突然给我说那个红雀的头要断了，问我还有没有……我不舍得再挂了，而且也没有红雀了，就算有也不想给挂，怕掉，也怕坏或者脏，就说没有了……他问我同事那还有不，我说不知道，你自己淘宝搜着买，他说不知道搜什么关键字，我没什么耐心了，就说你去万能的微博问吧……谁成想……(¯﹃¯)……然后刚才我偷看他微博，发现他要去安利给同事，这下我慌了，赶紧告知他真相了……我该怎么办？《遥1》和《餐厅》的大盒子还会给我买吗？","#二哈#怎么做到的?","盘点18年必看的大剧！你最期待哪部？","给@Polymath9  的新曲《Etude -Rain Valley-》画了个封面，真滴很好听希望大家能支持下，网易云","本u149P已定請國家放心  等過幾天收貨  特期待","2020东京奥运吉祥物选举今早开票，这两只“未来机器人”最终胜出，暂时还未命名...怎么感觉不是很可爱","一给我里giaogiao ​​​​","【腾讯：我没做错什么啊，国服还没出，吃鸡怎么就凉了！】“大吉大利，今晚吃鸡”这句2017年最喜庆的金句，在2018年听来却只剩下尴尬。根据Steam Charts的最新统计数据显示，《绝地求生》这款游戏最近30天的玩家人数不断下滑。截至昨晚（2018-02-27），其平均玩家数在过去30天下滑了11.03%，减少了约17.5万个玩家。这也是该款游戏自发售以来首次出现玩家人数负增长。该数据同时由Steam Spy在Twitter进行了二次确认","转自天涯的一篇文章《直接骂了单位的一个女同事！》。。。你身边有这样的人吗？","最新一期NG图透：光伦巴黎蜜月之旅","【这一巴掌，打的对不对？】近日，在一个结婚典礼现场，新人正欲跪拜老人，这时一闹婚男子掐住新娘脖子，强行将新娘按倒跪地。男子一直掐着新娘脖子，新娘被激怒，起身怒扇男子耳光。周围还有人说：“不可以（打），闹着玩呢！","#一封家书# 从小就活跃在大众视野的90后小花！哈哈，这个答案是不是呼之欲出了呢？","孩子的婚姻敏感期值得重视，你知道孩子什么时候进入了婚姻敏感期吗？"]
    let forwardContentArray = ["哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈//@睿睿睿睿_波斯猫守着她的爱恋: ？？？？[允悲]//@D999·蝉弥花:hhhhhhh","转发微博","万…万一呢………","支持//@selcYc: 好 支持 顶//@Polymath9:狂捞 没人听 哭哭//@Polymath9: Repost","转需","帮扩","AC部警告//@冠位咕哒馆: 这个咕哒的画风…","风间仁＋三岛平八//@hm05flash:感觉右边秃头了一样//@平成废物少女:我还是挺喜欢滴","沉迷砍怪[二哈]//@专业戳轮胎熊律师:我现在AFK主要就是有一晚，连续4盘给孤儿打死，就不想玩了。。//@老刀99: 主要是被外挂搞凉的[衰]//@Normalmap:说明**会追热点，但不懂游戏//@Samuraiwu:讲道理，这本身是个很粗糙的游戏。。。老美都去玩堡垒之夜了，靠国内外挂玩家撑着。。。","我滴妈//@颜文字君:好可爱_(•̀ω•́ 」∠)_//@肉山山子:啊啊啊啊啊啊啊啊啊啊啊啊啊啊怎么这么可爱啊想捏！！！","//@你们鸡摸://@木味菌:Cleverness is a gift, yet kindness is a choice.//@金河别雁: 雾中之塔，长夜之灯，无论世道多么惨淡，总有愿意盗火的人，总有愿意第一个冲上去挡子弹的人。“你神圣的罪恶是怀有仁心”。","如果是我先把那傻叉揍一頓再說鬧著玩//@雾雨人形:一句闹着玩救了多少傻逼[拜拜]//@独木桥上来回走的兔崽子:玩？？？//@Tiger公子:新郎劝说？？？","哈哈//@粽粽粽粽粽粽粽:恭喜//@江南大野花:恭喜恭喜 收获意外惊喜//@北美小桥段:意不意外？惊不惊喜？//@这是一个很高冷的ID: 哈哈哈哈哈哈哈哈哈哈//@资深灭婊砖家:恍恍惚惚恍恍惚惚恍恍惚惚//@刘一杭三三:哈哈哈哈一天不做死不舒服斯基"]
    let fromArray = ["微博weibo.com","iPhone 5","iPhone 6","iPhone 6s","iPhone 5s","iPhone 8","iPhone 7","iPhone SE","iPhone X"]
    
    
    
    
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
        for i in 0..<100 {
            let model = WBMainContentModel()
            
            if i%6 == 0{
                model.type = WBMainContentType.Single
                model.userType = WBContentUserType.Normal
                
                let contentIndex = Int(arc4random()) % self.contentArray.count
                model.content = self.contentArray[contentIndex]
            }else if (i%6)<3{
                model.type = WBMainContentType.Image
                model.userType = WBContentUserType.Yellow
                
                let contentIndex = Int(arc4random()) % self.contentArray.count
                model.content = self.contentArray[contentIndex]
                
                let imageNum = Int(arc4random()%9)+1
                for _ in 0..<imageNum{
                    model.imageArray.append(UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))!)
                }
            }else{
                model.type = WBMainContentType.Forwarding
                model.userType = WBContentUserType.Blue
                
                let contentIndex = Int(arc4random()) % self.forwardContentArray.count
                model.content = self.forwardContentArray[contentIndex]
            }
            
            model.headIcon = UIImage.init(named: "headIcon".appending(String(arc4random()%42).appending(".jpg")))
            
            let nameIndex = Int(arc4random()) % self.nameArray.count
            model.name = self.nameArray[nameIndex]
            
            model.vipLevel = Int((arc4random()%9))-1
            
            let allInterval = 60*60*24*15
            let realInterval = Int(arc4random()) % allInterval
            let date = Date.init(timeIntervalSinceNow: TimeInterval(-realInterval))
            let format = DateFormatter.init()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            model.time = format.string(from: date)
            
            let fromIndex = Int(arc4random()) % self.fromArray.count
            model.from = self.fromArray[fromIndex]
            
            model.forwardingNum = Int(arc4random()%200)
            model.remarkNum     = Int(arc4random()%200)
            model.likeNum       = Int(arc4random()%200)
            self.dataArray.append(model)
        }
        for i in 0..<self.dataArray.count {
            let model = self.dataArray[i]
            if (i%6)>=3 {
                var j = Int(arc4random()%100)
                while ((j%6)>=3){
                    j = Int(arc4random()%100)
                }
                model.forwarding = self.dataArray[j]
            }
        }
    }
    
    //MARK: - tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? WBMainTableViewCell
        cell?.model = self.dataArray[indexPath.row]
        cell?.delegate = self
        cell?.tableView = tableView
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController.init(title: "提示", message: "cell被点击了:".appending(String(indexPath.row)), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    
    //MARK - WBMainHeaderViewDelegate
    func wb_mainHeaderView(_ HeaderView: WBMainHeaderView, imageViewDidClickWithIndex index: Int) {
        let alert = UIAlertController.init(title: "提示", message: "我被点击了:".appending(String(index)), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    //MARK - WBMainTableViewCellDelegate
    func wb_mainTableViewCell(_ cell: WBMainTableViewCell, linkDidClick linkString: String) {
        let alert = UIAlertController.init(title: "提示", message: "链接被点击了:".appending(linkString), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    func wb_mainTableViewCellHeadIconDidClick(_ cell: WBMainTableViewCell) {
        let alert = UIAlertController.init(title: "提示", message: "头像被点击了:".appending((cell.model?.name)!), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    func wb_mainTableViewCellLikeButtonDidClick(_ cell: WBMainTableViewCell) {
        let alert = UIAlertController.init(title: "提示", message: "点赞被点击了:".appending((cell.model?.name)!), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    func wb_mainTableViewCellRemarkButtonDidClick(_ cell: WBMainTableViewCell) {
        let alert = UIAlertController.init(title: "提示", message: "评论被点击了:".appending((cell.model?.name)!), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    func wb_mainTableViewCellForwardingButtonDidClick(_ cell: WBMainTableViewCell) {
        let alert = UIAlertController.init(title: "提示", message: "转发被点击了:".appending((cell.model?.name)!), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    func wb_mainTableViewCellForwardingViewDidClick(_ cell: WBMainTableViewCell) {
        let alert = UIAlertController.init(title: "提示", message: "转发框被点击了:".appending((cell.model?.name)!), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true) {
            
        }
    }
    func wb_mainTableViewCell(_ cell: WBMainTableViewCell, fromButtonDidClick from: String) {
        let alert = UIAlertController.init(title: "提示", message: "来源被点击了:".appending((cell.model?.from)!), preferredStyle: UIAlertControllerStyle.alert)
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
