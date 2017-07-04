//
//  YJCommentCell.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import Kingfisher

class YJCommentCell: UITableViewCell {

	var comment:YJComment? {
		didSet {
			let user = comment!.user
			if let url = user!.avatar_url {
				avatarImageVIew.kf.setImage(with: URL(string:url))
			}
			nicknameLabel.text = user!.nickname
			contentLabel.text = comment!.content
			timeLabel.text = String(describing: comment!.created_at!)
		}
	}
	@IBOutlet weak var avatarImageVIew: UIImageView!
	
	@IBOutlet weak var nicknameLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        super.setSelected(selected, animated: animated)
    }
    
}
