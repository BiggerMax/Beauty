//
//  YJConst.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/28.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

let BASE_URL =	"http://api.dantangapp.com/"

let FIRSTLAUNCH = "firstLaunch"
let isLogin = "isLogin"
let SCREENW = UIScreen.main.bounds.size.width
let SCREENH = UIScreen.main.bounds.size.height
func COLOR(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
	return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
/// 背景灰色
func GlobalColor() -> UIColor {
	return COLOR(r: 240, g: 240, b: 240, a: 1)
}

/// 红色
func GlobalRedColor() -> UIColor {
	return COLOR(r: 245, g: 80, b: 83, a: 1.0)
}
/// iPhone 5
let isIPhone5 = SCREENH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREENH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREENH == 736 ? true : false
