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
}


class WBMainTableViewCell: UITableViewCell,XXLinkLabelDelegate {

    @IBOutlet weak var mainContentView: WBMainContentView!
    @IBOutlet weak var forwardingButton: UIButton!
    @IBOutlet weak var remarkButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
    }

}
