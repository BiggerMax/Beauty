//
//  YJShareButtonView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/3.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJShareButtonView: UIView {

	let images = ["Share_WeChatTimelineIcon_70x70_", "Share_WeChatSessionIcon_70x70_", "Share_WeiboIcon_70x70_", "Share_QzoneIcon_70x70_", "Share_QQIcon_70x70_", "Share_CopyLinkIcon_70x70_"]
	let titles = ["微信朋友圈", "微信好友", "微博", "QQ 空间", "QQ 好友", "复制链接"]
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	private func setupUI() {
		let maxCols = 3
		let buttonW: CGFloat = 70
		let buttonH: CGFloat = buttonW + 30
		let buttonStartX: CGFloat = 20
		let xMargin: CGFloat = (SCREENW - 20 - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
		//创建按钮
		for index in 0..<images.count {
			let button = YJVerticalButton()
			button.tag = index
			button.setImage(UIImage(named:images[index]), for: .normal)
			button.setTitle(titles[index], for: .normal)
			button.setTitleColor(UIColor.black, for: .normal)
			button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
			button.width = buttonW
			button.height = buttonH
			button.addTarget(self, action: #selector(shareButtonClick), for: .touchUpInside)
			//计算x、y
			let row = Int(index / maxCols)
			let col = index % maxCols
			let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
			let buttonMaxY: CGFloat = CGFloat(row) * buttonH
			let buttonY = buttonMaxY
			button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
			addSubview(button)
		}
	}
	
	func shareButtonClick(button: UIButton) {
		if let shareButtonType = YJShareButtonType(rawValue:button.tag){
			switch shareButtonType {
			case .WeChatTimeline:
				break
			case .WeChatSession:
				break
			case .Weibo:
				break
			case .QZone:
				break
			case .QQFriends:
				break
			case .CopyLink:
				break
			}
		}
		print(button.titleLabel!.text!)
	}
	


}
