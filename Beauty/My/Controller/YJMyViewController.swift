//
//  YJMyViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJMyViewController: YJBaseViewController,UITableViewDelegate,UITableViewDataSource {

	var cellCount = 0
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		setupTableView()

    }
	private func setupTableView() {
		let tableView = UITableView(frame: view.bounds, style: .grouped)
		view.addSubview(tableView)
		tableView.separatorStyle = .none
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableHeaderView = headerView
		tableView.tableFooterView = footerView
	}
	private lazy var headerView: YJMyHeaderView = {
		let headerView = YJMyHeaderView()
		headerView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: 200)
		headerView.iconBtn.addTarget(self, action: #selector(iconButtonClick), for: .touchUpInside)
		headerView.messageBtn.addTarget(self, action: #selector(messageButtonClick), for: .touchUpInside)
		headerView.settingBtn.addTarget(self, action: #selector(settingButtonClick), for: .touchUpInside)
		return headerView
	}()
	
	private lazy var footerView: YJMyFooterView = {
		let footerView = YJMyFooterView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 200))
		return footerView
	}()
	
	func iconButtonClick () {
		if UserDefaults.standard.bool(forKey: isLogin){
			let actionSheet = UIAlertController(title: "", message: nil, preferredStyle: .alert)
			let cameraAction = UIAlertAction(title: "编辑资料", style: .default, handler: { (alert) in
				
			})
			let photo = UIAlertAction(title: "退出登录", style: .destructive, handler: { (aletAction) in
				UserDefaults.standard.set(false, forKey: isLogin)
			})
			let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
			actionSheet.addAction(cameraAction)
			actionSheet.addAction(photo)
			actionSheet.addAction(cancelAction)
			self.present(actionSheet, animated: true, completion: nil)
		}else{
			let loginVC = YJLoginViewController()
			loginVC.title = "登录"
			let nav = YJNavigationController(rootViewController: loginVC)
			present(nav, animated: true, completion: nil)
		}
	}
	
	func messageButtonClick() {
		let messageVC = YJMessageViewController()
		messageVC.title = "消息"
		navigationController?.pushViewController(messageVC, animated: true)
	}
	func settingButtonClick() {
		let settionVC = YJSettingViewController()
		settionVC.title = "更多"
		navigationController?.pushViewController(settionVC, animated: true)
	}
	
	// MARK: UITableViewDelegate
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let choiceVC = YJChoiceView()
		return choiceVC
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellCount
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
		return cell
	}
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		if offsetY < 0 {
			var tempFrame = headerView.bgImageView.frame
			tempFrame.origin.y = offsetY
			tempFrame.size.height = 200 - offsetY
			headerView.bgImageView.frame = tempFrame
		}
	}
}
