//
//  YJSeeAllTopicCell.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJSeeAllTopicCell: UITableViewCell {
	@IBOutlet weak var bgImageView: UIImageView!

	@IBOutlet weak var placeholderBtn: UIButton!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subTitleLabel: UILabel!
	var collection: YJCollection? {
		didSet{
			let url = collection!.cover_image_url!
			bgImageView.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacaheType, imageurl) in
				self.placeholderBtn.isHidden = true
			}
			titleLabel.text = collection!.title!
			subTitleLabel.text = collection!.subtitle!
		}
	}
    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageView.layer.cornerRadius = 5.0
		bgImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
