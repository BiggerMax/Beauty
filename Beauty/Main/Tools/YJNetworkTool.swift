//
//  YJNetworkTool.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/28.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class YJNetworkTool: NSObject {
	static let shareInstance = YJNetworkTool()
	
	//获取首页数据
	func loadHomeInfo(id: Int , finished:@escaping (_ homeItems:[YJHomeItem]) -> ()) {
		let url = BASE_URL + "v1/channels/\(id)/items"
		let params = ["gender":1,"generation":1,"limit":20,"offset":0]
		Alamofire
			.request(url, parameters: params)
			.responseJSON { (response) in
				guard response.result.isSuccess else {
					SVProgressHUD.showError(withStatus: "加载失败")
					return
				}
				if let value = response.result.value{
					let dict = JSON(value)
					let code = dict["code"]
					let message = dict["message"].stringValue
					guard code == 200 else{
						SVProgressHUD.showInfo(withStatus: message)
						return
					}
					let data = dict["data"].dictionary
					if let items = data!["items"]?.arrayObject{
						var homeItems = [YJHomeItem]()
						for item in items{
							let homeItem = YJHomItem(dict: item as! [String: AnyObject])
							homeItems.append(homeItem)
						}
						finished(homeItems)
					}
				}
		}
	}
	
	//获取首页顶部选择数据
	func loadHomeTopData(finished:@escaping (_ home_channels:[YJChannel]) -> ()){
		
		let url = BASE_URL + "v2/channels/preset"
		let params = ["gender":1,"generation":1]
		Alamofire
			.request(url, parameters : params)
			.responseJSON { (response) in
				guard response.result.isSuccess else{
					SVProgressHUD.showError(withStatus: "加载失败...")
					return
				}
				if let value = response.result.value{
					let dict = JSON(value).dictionary
					let code = dict["code"]?.intValue
					let message = dict["message"]?.stringValue
					guard code == 200 else{
						SVProgressHUD.showInfo(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					let data = dict["data"]?.dictionary
					if let hot_words = dict["hot_words"]?.arrayObject{
						finished(hot_words as! [String])
					}
					
				}
		}
	}
	
	//根据搜索条件进行搜索
	func loadSearchResult(keyword: String,sort : String,finished:@escaping(_ results:[YJSearchResult]) -> ()) {
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = "http://api.dantangapp.com/v1/search/item"
		
		let paramers = ["keyword": keyword,
		                "limit": 20,
		                "offset": 0,
		"sort": sort] as [String : AnyObject]
		
		Alamofire
			.request(url, parameters:paramers)
			.responseJSON { (response) in
				guard response.result.isSuccess else{
					SVProgressHUD.showError(withStatus: "加载失败...")
					return
				}
				if let value = response.result.value{
					let dic = JSON(value)
					let code = dic["code"]!.intValue
					let message = dic["message"].stringValue
					guard code == 200 else{
						SVProgressHUD.show(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					let data = dic["data"].dictionary
					if let items = data["items"]?.arrayObject{
						var results = [YJSearchResult]()
						for item in items{
							let result = YJSearchResult(dict:item as? [String:AnyObject])
							results.append(result)
						}
					}
				}
		}
	}
}
