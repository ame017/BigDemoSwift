//
//  WBMainTableViewCell.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/23.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

@objc protocol WBMainTableViewCellDelegate : NSObjectProtocol {
    @objc optional func wb_mainTableViewCell(_ cell:WBMainTableViewCell,linkDidClick linkString:String)
    @objc optional func wb_mainTableViewCellHeadIconDidClick(_ cell:WBMainTableViewCell)
    @objc optional func wb_mainTableViewCell(_ cell:WBMainTableViewCell, fromButtonDidClick from:String)
    @objc optional func wb_mainTableViewCellForwardingButtonDidClick(_ cell:WBMainTableViewCell)
    @objc optional func wb_mainTableViewCellRemarkButtonDidClick(_ cell:WBMainTableViewCell)
    @objc optional func wb_mainTableViewCellLikeButtonDidClick(_ cell:WBMainTableViewCell)
    @objc optional func wb_mainTableViewCellForwardingViewDidClick(_ cell:WBMainTableViewCell)
}


class WBMainTableViewCell: UITableViewCell,XXLinkLabelDelegate {

    @IBOutlet private weak var mainContentView: WBMainContentView!
    @IBOutlet private weak var forwardingButton: UIButton!
    @IBOutlet private weak var remarkButton: UIButton!
    @IBOutlet private weak var likeButton: UIButton!
    var tableView:UITableView?
    
    var delegate:WBMainTableViewCellDelegate?
    
    var model:WBMainContentModel?{
        didSet{
            if (model?.forwardingNum)! > 0 {
                forwardingButton.setTitle(String((model?.forwardingNum)!), for: UIControlState.normal)
            }
            if (model?.remarkNum)! > 0 {
                remarkButton.setTitle(String((model?.remarkNum)!), for: UIControlState.normal)
            }
            if (model?.likeNum)! > 0 {
                likeButton.setTitle(String((model?.likeNum)!), for: UIControlState.normal)
            }
            self.mainContentView.model = model
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainContentView.contentLabel.delegate = self
        mainContentView.contentLabel.extend = self
        mainContentView.forwardingView.contentLabel.delegate = self
        
        mainContentView.forwardingView.content.addTarget(self, action: #selector(forwardingViewDidClick(forwardingView:)), for: UIControlEvents.touchUpInside)
        let tap0 = UITapGestureRecognizer.init(target: self, action: #selector(forwardingNineImageViewClick(tapGestureRecognizer:)))
        mainContentView.forwardingView.nineImageView.content.addGestureRecognizer(tap0)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(HeadIconDidTap(tapGestureRecognizer:)))
        mainContentView.headIcon.addGestureRecognizer(tap)
        mainContentView.fromButton.addTarget(self, action: #selector(fromButtonDidClick(button:)), for: UIControlEvents.touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK - XXLinkLabelDelegate
    func labelImageClickLinkInfo(_ linkInfo: XXLinkLabelModel!) {
        print("labelImageClickLinkInfo")
    }
    
    func labelLinkClickLinkInfo(_ linkInfo: XXLinkLabelModel!, linkUrl: String!) {
        print("labelLinkClickLinkInfo")
    }
    
    func labelLinkLongPressLinkInfo(_ linkInfo: XXLinkLabelModel!, linkUrl: String!) {
        print("labelLinkLongPressLinkInfo")
    }
    
    func labelRegularLinkClickWithclickedString(_ clickedString: String!) {
        print("labelRegularLinkClickWithclickedString:".appending(clickedString))
        self.delegate?.wb_mainTableViewCell?(self, linkDidClick: clickedString)
    }
    
    func labelClicked(withExtend extend: Any!) {
        print("labelClicked")
        let exView = extend as! UIView
        //本
        if exView.isKind(of: self.classForCoder) {
            let indexPath = self.tableView!.indexPath(for: self)
            self.tableView?.delegate?.tableView!(self.tableView!, didSelectRowAt: indexPath!)
        }else{
            //转发
            self.forwardingViewDidClick(forwardingView: exView as! WBForwardingView)
        }
    }
    //MARK - Click
    @objc func HeadIconDidTap(tapGestureRecognizer:UITapGestureRecognizer) -> Void {
        self.delegate?.wb_mainTableViewCellHeadIconDidClick?(self)
    }
    @objc func fromButtonDidClick(button:UIButton) -> Void {
        self.delegate?.wb_mainTableViewCell?(self, fromButtonDidClick: button.title(for: UIControlState.normal)!)
    }
    @objc func forwardingViewDidClick(forwardingView:WBForwardingView) -> Void {
        self.delegate?.wb_mainTableViewCellForwardingViewDidClick?(self)
    }
    @objc func forwardingNineImageViewClick(tapGestureRecognizer:UITapGestureRecognizer) -> Void {
        self.delegate?.wb_mainTableViewCellForwardingViewDidClick?(self)
    }
    
    @IBAction func forwardingButtonDidClick(_ sender: UIButton) {
        self.delegate?.wb_mainTableViewCellForwardingButtonDidClick?(self)
    }
    @IBAction func remarkButtonDidClick(_ sender: UIButton) {
        self.delegate?.wb_mainTableViewCellRemarkButtonDidClick?(self)
    }
    @IBAction func likeButtonClick(_ sender: UIButton) {
        self.delegate?.wb_mainTableViewCellLikeButtonDidClick?(self)
    }
    
}
