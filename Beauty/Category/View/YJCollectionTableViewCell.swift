//
//  YJCollectionTableViewCell.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import Kingfisher

class YJCollectionTableViewCell: UITableViewCell {
	
	var collectionPost:YJCollectionPost? {
		didSet{
			let url = collectionPost!.cover_image_url!
			collectionImage.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
				self.bgButton.isHidden = true
			}
			titleLabel.text = collectionPost!.title
			likeBtn.setTitle("\(collectionPost!.likes_count!)", for: .normal)
		}
	}
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionImage.layer.cornerRadius = 5
		collectionImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	@IBOutlet weak var bgButton: UIButton!
    
	@IBOutlet weak var collectionImage: UIImageView!

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var likeBtn: UIButton!
}
