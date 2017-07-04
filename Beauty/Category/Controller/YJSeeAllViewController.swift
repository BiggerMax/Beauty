//
//  YJSeeAllViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

let seeAllCellID = "YJSeeAllTopicCell"

class YJSeeAllViewController: YJBaseViewController,UITableViewDelegate,UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	var collections = [YJCollection]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let nib = UINib(nibName: String(describing:YJSeeAllTopicCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: seeAllCellID)
		tableView.separatorStyle = .none
		tableView.rowHeight = 160
		YJNetworkTool.shareNetworkTool.loadCategoryCollection(limit: 20) { (collection) in
			self.collections = collection
			self.tableView!.reloadData()
		}
    }
	//MARK: --TableViewDelegate
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return collections.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: seeAllCellID) as! YJSeeAllTopicCell
		cell.collection = collections[indexPath.row]
		cell.selectionStyle = .none
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let collectionDetailVC = YJCollectionDetailController()
		let collection = collections[indexPath.row]
		collectionDetailVC.title = collection.title
		collectionDetailVC.id = collection.id!
		collectionDetailVC.type = "专题集合"
		navigationController?.pushViewController(collectionDetailVC, animated: true)
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

}
