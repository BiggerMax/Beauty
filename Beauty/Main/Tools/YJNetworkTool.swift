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
							let homeItem = YJHomeItem(dict: item as! [String: AnyObject])
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
					let dict = JSON(value)
					let code = dict["code"].intValue
					let message = dict["message"].stringValue
					guard code == 200 else{
						SVProgressHUD.showInfo(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					let data = dict["data"].dictionary
					if let channels = data!["channels"]?.arrayObject{
						var yj_channels = [YJChannel]()
						for channel in channels{
							let yj_channel = YJChannel(dict: channel as! [String :AnyObject])
							yj_channels.append(yj_channel)
						}
						finished(yj_channels)
					}
					
				}
		}
	}
	
	func loadHotWords(finished:@escaping(_ words: [String]) -> ()){
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = BASE_URL + "v1/search/hot_words"
		Alamofire
			.request(url)
			.responseJSON { (response) in
				guard response.result.isSuccess else {
					SVProgressHUD.showError(withStatus: "加载失败...")
					return
				}
				if let value = response.result.value {
					let dict = JSON(value)
					let code = dict["code"].intValue
					let message = dict["message"].stringValue
					guard code == 200 else {
						SVProgressHUD.showInfo(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					if let data = dict["data"].dictionary {
						if let hot_words = data["hot_words"]?.arrayObject {
							finished(hot_words as! [String])
						}
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
					let code = dic["code"].intValue
					let message = dic["message"].stringValue
					guard code == 200 else{
						SVProgressHUD.show(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					let data = dic["data"].dictionary
					if let items = data!["items"]?.arrayObject{
						var results = [YJSearchResult]()
						for item in items{
							let result = YJSearchResult(dict:item as! [String:AnyObject])
							results.append(result)
						}
					}
				}
		}
	}
	//获取单品数据
	func loadProduceData(finished:@escaping (_ productes:[YJProduct]) -> () ){
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = BASE_URL + "v2/items"
		let params = ["gender": 1,
		              "generation": 1,
		              "limit": 20,
		              "offset": 0]
		Alamofire
			.request(url, parameters:params)
			.responseJSON { (response) in
				guard response.result.isSuccess else{
					SVProgressHUD.showError(withStatus: "加载失败...")
					return
				}
				if let value = response.result.value{
					let dict = JSON(value)
					let code = dict["code"].intValue
					let message = dict["message"].stringValue
					guard code == 200 else{
						SVProgressHUD.show(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					if let data = dict["data"].dictionary{
					if let items = data["items"]?.arrayObject{
						var products = [YJProduct]()
						for item in items{
							let itemDict = item as! [String : AnyObject]
							if let itemData = itemDict["data"]{
								let product = YJProduct(dict: itemData as! [String:AnyObject])
								products.append(product)
							}
						}
						finished(products)
					}
				}
			}
		}
	}
	//获取单品详情
	func loadProductDetailData(id : Int , finished:@escaping (_ productDetail : YJProductDetailData) -> ()){
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = BASE_URL + "v2/items/\(id)"
		Alamofire
				.request(url)
				.responseJSON { (response) in
					guard response.result.isSuccess else{
						SVProgressHUD.showError(withStatus: "加载失败...")
						return
					}
					if let value = response.result.value{
						let dict = JSON(value)
						let code = dict["code"].intValue
						let message = dict["message"].stringValue
						guard code == 200 else{
							SVProgressHUD.show(withStatus: message)
							return
						}
						SVProgressHUD.dismiss()
						if let data = dict["data"].dictionaryObject{
							let productDetail = YJProductDetailData(dict: data as [String : AnyObject])
							finished(productDetail)
						
					}
		}
	}
	
	//商品评论
	func loadProductDetailComments(id : Int,finished:@escaping (_ comment : [YJComment]) -> ()){
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = BASE_URL + "v2/items/\(id)/comments"
		let params = ["limit": 20,
		              "offset": 0]
		Alamofire
			.request(url, parameters: params)
			.responseJSON { (response) in
				guard response.result.isSuccess else{
					SVProgressHUD.showError(withStatus: "加载失败...")
					return;
				}
				if let value = response.result.value{
					let dict = JSON(value)
					let code = dict["code"].intValue
					let message = dict["message"].stringValue
					guard code == 200 else{
						SVProgressHUD.showInfo(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					if let data = dict["data"].dictionary{
						if let commentData = data["comment"]?.arrayObject{
							var comments = [YJComment]()
							for item in commentData{
								let comment = YJComment(dict: item as! [String: AnyObject])
								comments.append(comment)
							}
							finished(comments)
						}
					}
				}
		}
	}
	/// 分类界面 顶部 专题合集
	func loadCategoryCollection(limit: Int, finished:@escaping (_ collections: [YJCollection]) -> ()) {
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = BASE_URL + "v1/collections"
		let params = ["limit": limit,
		              "offset": 0]
		Alamofire
			.request(url, parameters: params)
			.responseJSON { (response) in
				guard response.result.isSuccess else {
					SVProgressHUD.showError(withStatus: "加载失败...")
					return
				}
				if let value = response.result.value {
					let dict = JSON(value)
					let code = dict["code"].intValue
					let message = dict["message"].stringValue
					guard code == 200 else {
						SVProgressHUD.showInfo(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					if let data = dict["data"].dictionary {
						if let collectionsData = data["collections"]?.arrayObject {
							var collections = [YJCollection]()
							for item in collectionsData {
								let collection = YJCollection(dict: item as! [String: AnyObject])
								collections.append(collection)
							}
							finished(collections)
						}
					}
				}
		}
	}
	
	/// 顶部 专题合集 -> 专题列表
	func loadCollectionPosts(id: Int, finished:@escaping (_ posts: [YJCollectionPost]) -> ()) {
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = BASE_URL + "v1/collections/\(id)/posts"
		let params = ["gender": 1,
		              "generation": 1,
		              "limit": 20,
		              "offset": 0]
		Alamofire
			.request(url, parameters: params)
			.responseJSON { (response) in
				guard response.result.isSuccess else {
					SVProgressHUD.show(withStatus: "加载失败...")
					return
				}
				if let value = response.result.value {
					let dict = JSON(value)
					let code = dict["code"].intValue
					let message = dict["message"].stringValue
					guard code == 200 else {
						SVProgressHUD.show(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					if let data = dict["data"].dictionary {
						if let postsData = data["posts"]?.arrayObject {
							var posts = [YJCollectionPost]()
							for item in postsData {
								let post = YJCollectionPost(dict: item as! [String: AnyObject])
								posts.append(post)
							}
							finished(posts)
						}
					}
				}
		}
	}
	
	/// 分类界面 风格,品类
	func loadCategoryGroup(finished:@escaping (_ outGroups: [AnyObject]) -> ()) {
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = BASE_URL + "v1/channel_groups/all"
		Alamofire
			.request(url)
			.responseJSON { (response) in
				guard response.result.isSuccess else {
					SVProgressHUD.show(withStatus: "加载失败...")
					return
				}
				if let value = response.result.value {
					let dict = JSON(value)
					let code = dict["code"].intValue
					let message = dict["message"].stringValue
					guard code == 200 else {
						SVProgressHUD.show(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					if let data = dict["data"].dictionary {
						if let channel_groups = data["channel_groups"]?.arrayObject {
							// outGroups 存储两个 inGroups 数组，inGroups 存储 YMGroup 对象
							// outGroups 是一个二维数组
							var outGroups = [AnyObject]()
							for channel_group in channel_groups {
								var inGroups = [YJGroup]()
								let channel_group_dict = channel_group as! [String: AnyObject]
								let channels = channel_group_dict["channels"] as! [AnyObject]
								for channel in channels {
									let group = YJGroup(dict: channel as! [String: AnyObject])
									inGroups.append(group)
								}
								outGroups.append(inGroups as AnyObject)
							}
							finished(outGroups)
						}
					}
				}
		}
	}
	
	/// 底部 风格品类 -> 列表
	func loadStylesOrCategoryInfo(id: Int, finished:@escaping (_ items: [YJCollectionPost]) -> ()) {
		SVProgressHUD.show(withStatus: "正在加载...")
		let url = BASE_URL + "v1/channels/\(id)/items"
		let params = ["limit": 20,
		              "offset": 0]
		Alamofire
			.request(url, parameters: params)
			.responseJSON { (response) in
				guard response.result.isSuccess else {
					SVProgressHUD.show(withStatus: "加载失败...")
					return
				}
				if let value = response.result.value {
					let dict = JSON(value)
					let code = dict["code"].intValue
					let message = dict["message"].stringValue
					guard code == 200 else {
						SVProgressHUD.show(withStatus: message)
						return
					}
					SVProgressHUD.dismiss()
					if let data = dict["data"].dictionary {
						if let itemsData = data["items"]?.arrayObject {
							var items = [YJCollectionPost]()
							for item in itemsData {
								let post = YJCollectionPost(dict: item as! [String: AnyObject])
								items.append(post)
							}
							finished(items)
						}
					}
				}
		}
		}
	}

}

