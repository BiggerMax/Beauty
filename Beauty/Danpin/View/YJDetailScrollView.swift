//
//  YJDetailScrollView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJDetailScrollView: UIScrollView {

	var product: YJProduct? {
		didSet{
			topScrollView.product = product
			bottomScrollView.product = product
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		sutupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func sutupUI() {
		addSubview(topScrollView)
		addSubview(bottomScrollView)
		
		topScrollView.snp.makeConstraints { (make) in
			make.left.equalTo(self)
			make.top.equalTo(self)
			make.size.equalTo(CGSize(width: SCREENW, height: 520))
		}
		bottomScrollView.snp.makeConstraints { (make) in
			make.left.equalTo(self)
			make.top.equalTo(topScrollView.snp.bottom).offset(10)
			make.size.equalTo(CGSize(width: SCREENW, height: SCREENW - 109))
		}
	}
	//顶部视图
	private lazy var topScrollView: YJProductDetailTopView = {
		let topScrollView = YJProductDetailTopView()
		topScrollView.backgroundColor = UIColor.white
		return topScrollView
	}()
	//底部滚动视图
	private lazy var bottomScrollView: YJProductBottomView = {
		let bottomScrollView = YJProductBottomView()
		bottomScrollView.backgroundColor = UIColor.white
		return bottomScrollView
	}()
}
