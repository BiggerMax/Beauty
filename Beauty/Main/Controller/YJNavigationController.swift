//
//  YJNavigationController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/29.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SVProgressHUD
class YJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
	
	internal override class func initialize(){
		super.initialize()
		
		let navBar = UINavigationBar.appearance()
		navBar.barTintColor = GlobalRedColor()
		navBar.tintColor = UIColor.white
		navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 20)]
	}
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		if viewControllers.count > 0{
			viewController.hidesBottomBarWhenPushed = true
			viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(navigationBackClick))
		}
		super.pushViewController(viewController, animated: true)
	}
	
	func navigationBackClick(){
		if SVProgressHUD.isVisible() {
			SVProgressHUD.dismiss()
		}
		if  UIApplication.shared.isNetworkActivityIndicatorVisible {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		popViewController(animated: true)
	}

}
