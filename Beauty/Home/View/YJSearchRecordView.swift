//
//  YJSearchRecordView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJSearchRecordView: UIView {

   var words = [String]()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		//搜索页面数据获取热搜关键词
		YJNetworkTool.shareInstance.loadHotWords { (hot_words) in
			self.words = hot_words
			self.setupUI()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI() {
		let topView = UIView()
		addSubview(topView)
		let hotLabel = setupLabel(title:"大家都在搜")
		hotLabel.frame = CGRect(x: 10, y: 20, width: 200, height: 20)
		topView.addSubview(hotLabel)
		
		//历史记录
		let bottomView = UIView()
		addSubview(bottomView)
	}
	
	func setupLabel(title: String) -> UILabel{
		let label = UILabel()
		label.text = title
		label.font = UIFont.systemFont(ofSize: 13)
		label.textColor = COLOR(r: 0, g: 0, b: 0, a: 0.6)
		return label
	}

}
