//
//  WBMainTableViewCell.swift
//  BigDemoSwift
//
//  Created by ame on 2018/2/23.
//  Copyright © 2018年 ame017. All rights reserved.
//

import UIKit

class WBMainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainContentView: WBMainContentView!
    @IBOutlet weak var forwardingButton: UIButton!
    @IBOutlet weak var remarkButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
