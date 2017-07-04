//
//  YJCollectionDetailController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

let collectionTableCellID = "YJCollectionTableViewCell"
class YJCollectionDetailController: UIViewController,UITableViewDataSource,UITableViewDelegate {
	
	var type = String()
	var posts = [YJCollectionPost]()
	var id = Int()
	
	@IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

		let nib = UINib(nibName: String(describing:YJCollectionTableViewCell.self), bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: collectionCellID)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = 150
		tableView.separatorStyle = .none
		if type == "专题集合" {
			YJNetworkTool.shareNetworkTool.loadCollectionPosts(id: id, finished: { (posts) in
				self.posts = posts
				self.tableView.reloadData()
			})
		}else if type == "风格品类"{
				YJNetworkTool.shareNetworkTool.loadStylesOrCategoryInfo(id: id, finished: { (items) in
					self.posts = items
					self.tableView.reloadData()
				})
		}
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: collectionCellID) as! YJCollectionTableViewCell
		cell.selectionStyle = .none
		cell.collectionPost = posts[indexPath.row]
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let postDetailVC = YJPostDetailViewController()
		postDetailVC.title = "攻略详情"
		postDetailVC.post = posts[indexPath.row]
		navigationController?.pushViewController(postDetailVC, animated: true)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
