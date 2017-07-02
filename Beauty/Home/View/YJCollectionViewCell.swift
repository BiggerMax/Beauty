//
//  YJCollectionViewCell.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import Kingfisher

protocol YJCollectionViewCellDelegate: NSObjectProtocol {
	func collectionViewCellDidClickedLikeButton(button: UIButton)
}

class YJCollectionViewCell: UICollectionViewCell {
	weak var delegate: YJCollectionViewCellDelegate?
	var result: YJSearchResult? {
		didSet{
			let url = result!.cover_image_url!
			productImageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageUrl) in
				self.placeholderBtn.isHidden = true
			}
			likeBtn.setTitle(" " + String(result!.favorites_count!) + " ", for: .normal)
			priceLabel.text = "￥" + String(result!.price!)
		}
	}
	
	var product: YJProduct? {
		didSet{
			let url = product!.cover_image_url!
			productImageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageUrl) in
				self.placeholderBtn.isHidden = true
			}
			likeBtn.setTitle(" " + String(product!.favorites_count!) + " ", for: .normal)
			titleLabel.text = product!.name
			priceLabel.text = "￥" + String(product!.price!)
		}
	}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	@IBOutlet weak var placeholderBtn: UIButton!

	@IBOutlet weak var productImageView: UIImageView!

	@IBOutlet weak var titleLabel: UILabel!

	@IBOutlet weak var priceLabel: UILabel!
	
	@IBOutlet weak var likeBtn: UIButton!
	
	@IBAction func LikeBtnClicked(_ sender: UIButton) {
		delegate?.collectionViewCellDidClickedLikeButton(button: sender)
	}
}
