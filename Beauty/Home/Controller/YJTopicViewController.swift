//
//  YJTopicViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/29.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

let homeCellID = "homeCellID"

class YJTopicViewController: UITableViewController,YJHomeCellDelegate {
		var type = Int()
		
		var items = [YJHomeItem]()
		override func viewDidLoad()
		{
			super.viewDidLoad()
			view.backgroundColor = GlobalColor()
			setupTableView()
			refreshControl?.addTarget(self, action: #selector(loadHomeData), for: .valueChanged)
			//获取首页数据
			YJNetworkTool.shareNetworkTool.loadHomeInfo(id: type) { (homeItems) in
				self.items = homeItems
				self.tableView.reloadData()
			}
			
		}
	func loadHomeData(){
		weak var weakSelf = self
		YJNetworkTool.shareNetworkTool.loadHomeInfo(id: type) { (homeItems) in
			weakSelf!.items = homeItems
			weakSelf!.tableView.reloadData()
			weakSelf!.refreshControl?.endRefreshing()
		}
	}
	
	func setupTableView(){
		tableView.rowHeight = 160
		tableView.separatorStyle = .none
		tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 44, 0)
		tableView.scrollIndicatorInsets = tableView.contentInset
		let nib = UINib(nibName: String(describing:YJHomeCell.self), bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: homeCellID)
	}
	
	//MARK: --UITableViewDataSource
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let homeCell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! YJHomeCell
		homeCell.selectionStyle = .none
		homeCell.homeItem = items[indexPath.row]
		homeCell.delegate = self
		return homeCell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailVC = YJDetailViewController()
		detailVC.homeItem = items[indexPath.row]
		detailVC.title = "攻略详情"
		navigationController?.pushViewController(detailVC, animated: true)
	}
	
	//MARK: -- homeCellDelegate
	func homeCellDidClickedFavoriteButton(button: UIButton) {
		if !UserDefaults.standard.bool(forKey: isLogin) {
			let loginVC = YJLoginViewController()
			loginVC.title = "登录"
			let nav = YJNavigationController(rootViewController: loginVC)
			present(nav, animated: true, completion: nil)
		}
	}

}
