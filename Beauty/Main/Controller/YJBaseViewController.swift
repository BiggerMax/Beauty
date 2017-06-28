//
//  YJBaseViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/28.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SVProgressHUD
import FDFullscreenPopGesture

class YJBaseViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = COLOR(r: 244, g: 244, b: 244, a: 1/0)
		navigationController?.fd_prefersNavigationBarHidden = true
		SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
		SVProgressHUD.setMinimumDismissTimeInterval(1.0)
		SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
		SVProgressHUD.setForegroundColor(UIColor.white)
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle{
		return .lightContent
	}
}
