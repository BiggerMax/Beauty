//
//  YJCategoryBottomView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import Kingfisher

protocol YJCategoryBottomViewDelegate:NSObjectProtocol {
	func bottomViewButtonDidClicked(buttton: UIButton)
}
class YJCategoryBottomView: UIView {

	weak var delegate: YJCategoryBottomViewDelegate?
	var outGroups = [AnyObject]()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		weak var weakSelf = self
		YJNetworkTool.shareNetworkTool.loadCategoryGroup { (outGroup) in
			self.outGroups = outGroup
			self.setupUI ()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	private func setupUI() {
		let topGroups = outGroups[0] as! NSArray
		let bottomGroups = outGroups[1] as! NSArray
		
		//风格
		let topView = UIView()
		topView.width = SCREENW
		topView.backgroundColor = UIColor.white
		addSubview(topView)
		let styleLabel = setupLabel(title: "风格")
		topView.addSubview(styleLabel)
		
		for index in 0..<topGroups.count{
			let group = topGroups[index] as! YJGroup
			let button = setupButton(index: index, group: group)
			topView.addSubview(button)
			if index == topGroups.count - 1 {
				topView.height = button.frame.maxY + 10			}
		}
		
		//品类
		let bottomView = UIView()
		bottomView.width = SCREENW
		bottomView.y = topView.frame.maxY + 10
		bottomView.backgroundColor = UIColor.white
		addSubview(bottomView)
		let categoryLabel = setupLabel(title: "品类")
		bottomView.addSubview(categoryLabel)
		
		for index in 0..<bottomGroups.count {
			let group = bottomGroups[index] as! YJGroup
			let button = setupButton(index: index, group: group)
			bottomView.addSubview(button)
			if index == bottomGroups.count - 1 {
				bottomView.height = button.frame.maxY + 10
			}
		}
	}
	
	private func setupLabel(title: String) -> UILabel{
		let styleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: SCREENW, height: 40))
		styleLabel.text = title
		styleLabel.textColor = COLOR(r: 0, g: 0, b: 0, a: 0.6)
		styleLabel.font = UIFont.systemFont(ofSize: 16)
		return styleLabel
	}
	
	private func setupButton(index: Int,group: YJGroup) -> YJVerticalButton{
		let buttonW: CGFloat = SCREENW / 4
		let buttonH: CGFloat = buttonW
		let styleLabelH: CGFloat = 40
		
		let button = YJVerticalButton()
		button.width = buttonW
		button.height = buttonH
		button.x = buttonW * CGFloat(index % 4)
		button.y = buttonH * CGFloat(index / 4) + styleLabelH
		if index > 3 {
			button.y = buttonH * CGFloat(index / 4) + styleLabelH + 10
		}
		button.tag = group.id!
		button.addTarget(self, action: #selector(groupButonClick), for: .touchUpInside)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(COLOR(r: 0, g: 0, b: 0, a: 0.6), for: .normal)
		button.kf.setImage(with: URL(string:group.icon_url!), for: .normal)
		button.setTitle(group.name, for: .normal)
		return button
	}
	func groupButonClick(button: UIButton) {
		delegate?.bottomViewButtonDidClicked(buttton: button)
	}
}
