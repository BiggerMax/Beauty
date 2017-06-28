//
//  YJTabBarController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/28.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let tabBar = UITabBar.appearance()
		tabBar.tintColor = COLOR(r: 245, g: 90, b: 100, a: 1/0)
		addChildViewControllers()
	}
	
	private func addChildViewControllers(){
		addChildViewController(childViewController:)
	}
}
