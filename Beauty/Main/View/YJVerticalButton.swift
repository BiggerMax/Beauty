//
//  YJVerticalButton.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/3.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJVerticalButton: UIButton {

	var group: YJGroup? {
		didSet {
			let url = group!.icon_url
			imageView!.kf.setImage(with: URL(string:url!)!)
			titleLabel?.text = group!.name
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		titleLabel?.textAlignment = .center
		titleLabel?.lineBreakMode = .byTruncatingTail
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		imageView?.x = 10
		imageView?.y = 0
		imageView?.width = self.width - 20
		imageView?.height = imageView!.width

		titleLabel?.x = 0
		titleLabel?.y = imageView!.height
		titleLabel?.width = self.width
		titleLabel?.height = self.height - imageView!.height

	}

}
