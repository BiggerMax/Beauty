//
//  YJHomeController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/28.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJHomeViewController: YJBaseViewController,UIScrollViewDelegate {
	
	var channel = [YJChannel]()
	//标签
	weak var titleView = UIView()
	//底部红色指示器
	weak var indicatorView = UIView()
	
	weak var contentView = UIScrollView()
	//当前选中按钮
	weak var seletecdBtn = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//设置导航栏
		setupNav()
		weak var weakSelf = self
		

	}
	func setupNav() {
		view.backgroundColor = UIColor.white
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(rightBtnClicked)
	}
}
