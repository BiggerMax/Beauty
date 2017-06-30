//
//  YJHomeCell.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/29.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import Kingfisher

protocol YJHomeCellDelegate:NSObjectProtocol {
	func homeCellDidClickedFavoriteButton(button:UIButton)
}

class YJHomeCell: UITableViewCell {

	weak var delegate:YJHomeCellDelegate?
	
	@IBOutlet var BgImageView: UIImageView!
	
	@IBOutlet var titleLabel: UILabel!
	
	@IBOutlet var placeholderBtn: UIButton!
	
	@IBOutlet var favoriteBtn: UIButton!

	var homeItem:YJHomeItem?{
		didSet{
			let url = homeItem!.cover_image_url
			BgImageView.kf.setImage(with: URL(string:url!)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageUrl) in
				self.placeholderBtn.isHidden = true
			}
			titleLabel.text = homeItem!.title
			favoriteBtn.setTitle(" " + String(homeItem!.likes_count!) + " ", for: .normal)
		}
	}
	override func awakeFromNib(){
		super.awakeFromNib()
		favoriteBtn.layer.cornerRadius = favoriteBtn.height * 0.5
		favoriteBtn.layer.masksToBounds = true
		favoriteBtn.layer.rasterizationScale = UIScreen.main.scale
		favoriteBtn.layer.shouldRasterize = true
		BgImageView.layer.cornerRadius = 5.0
		BgImageView.layer.masksToBounds = true
		BgImageView.layer.shouldRasterize  = true
		BgImageView.layer.rasterizationScale = UIScreen.main.scale
	}
    
	@IBAction func favoriteButtonClicked(_ sender: UIButton) {
		delegate?.homeCellDidClickedFavoriteButton(button: sender)
	}
}
