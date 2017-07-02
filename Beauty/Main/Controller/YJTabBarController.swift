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
		addChildViewController(childController:YJHomeViewController(),titile:"首页",imageName:"TabBar_home_23x23_")
			addChildViewController(childController: YJDanpingController(), titile: "单品", imageName: "TabBar_gift_23x23_")
		addChildViewController(childController: YJCategoryController(), titile: "分类", imageName: "TabBar_category_23x23_")
		addChildViewController(childController: YJMyViewController(), titile: "我的", imageName: "TabBar_me_boy_23x23_")
		
	}
	private func addChildViewController(childController:UIViewController,titile: String,imageName:String){
		childController.tabBarItem.image = UIImage(named:imageName)
		childController.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
		childController.title = titile
		let nacVC = YJNavigationController(rootViewController :childController)
		addChildViewController(nacVC)
		
	}
}
