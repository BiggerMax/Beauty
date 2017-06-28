//
//  YJChannel.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/28.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJChannel: NSObject {
	var editable:Bool?
	var id:Int?
	var name:String?
	
	init(dict:[String:AnyObject]) {
		id = dict["id"] as? Int
		name = dict["name"] as? String
		editable = dict["editable"] as? Bool
	}
	
}
