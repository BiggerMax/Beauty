//
//  YJCategoryCollectionViewCell.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import Kingfisher

class YJCategoryCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var placeholderBtn: UIButton!
	
	@IBOutlet weak var collectionImage: UIImageView!
	
	var collection: YJCollection? {
		didSet{
			let url = collection!.banner_image_url!
			collectionImage.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageUrl) in
				self.placeholderBtn.isHidden = true
			}
		}
	}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
