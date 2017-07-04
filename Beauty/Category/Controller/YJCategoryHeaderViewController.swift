//
//  YJCategoryHeaderViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

let categoryCollectionCell = "categoryCollectionCell"

class YJCategoryHeaderViewController: YJBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YJTopViewDelegate {
	
	var collections = [YJCollection]()
	
	var collectionView: UICollectionView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.clear
		setupUI ()
		
		YJNetworkTool.shareNetworkTool.loadCategoryCollection(limit: 6) { (collections) in
			self.collections = collections
			self.collectionView!.reloadData()
		}
	}
	
	private func setupUI() {
		let headerView = Bundle.main.loadNibNamed(String(describing:YJTopHeaderView.self), owner: nil, options: nil)?.last as! YJTopHeaderView
		headerView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: 40)
		headerView.delegate = self
		view.addSubview(headerView)
		
		let flowlayout = UICollectionViewFlowLayout()
		flowlayout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: SCREENW, height: 95), collectionViewLayout: flowlayout)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.showsVerticalScrollIndicator = false
		collectionView.backgroundColor = UIColor.white
		let nib = UINib(nibName: String(describing:YJCategoryCollectionViewCell.self), bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: categoryCollectionCell)
		view.addSubview(collectionView)
		self.collectionView = collectionView
	}
	
	// MARK: TopHeaderViewDelegate
	func topViewDidClickedMoreButton(button: UIButton) {
		let seeAllVC = YJSeeAllViewController()
		seeAllVC.title = "查看全部"
		navigationController?.pushViewController(seeAllVC, animated: true)
	}
	// MARK: --UICollectionView
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collections.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionCell, for: indexPath) as! YJCategoryCollectionViewCell
		cell.collection = collections[indexPath.row]
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let collectionDetailVC = YJCollectionDetailController()
		let collection = collections[indexPath.item]
		collectionDetailVC.title = collection.title
		collectionDetailVC.id = collection.id!
		collectionDetailVC.type = "专题集合"
		navigationController?.pushViewController(collectionDetailVC, animated: true)
	}
	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 150, height: 100)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(10, 10, 10, 10)
	}

}
