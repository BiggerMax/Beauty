//
//  YJDanpingController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

let collectionCellID = "YJCollectionCellID"

class YJDanpingController: YJBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YJCollectionViewCellDelegate {
	
	var products = [YJProduct]()
	
	var collectionView: UICollectionView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupCollectionView()
		weak var weakSelf = self
		YJNetworkTool.shareNetworkTool.loadProductData { (products) in
			weakSelf!.products = products
			weakSelf!.collectionView!.reloadData()
		}
    }
	func setupCollectionView() {
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = view.backgroundColor
		let nib = UINib(nibName: String(describing:YJCollectionViewCell.self), bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: collectionCellID)
		view.addSubview(collectionView)
		self.collectionView = collectionView
	}
	// MARK: -UICollectionView
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return products.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! YJCollectionViewCell
		cell.product = products[indexPath.item]
		cell.delegate = self
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let productDetailVC = YJProductDetailViewController()
		productDetailVC.title = "商品详情"
		productDetailVC.product = products[indexPath.item]
		navigationController?.pushViewController(productDetailVC, animated: true)
	}
	
	// MARK: flowout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = (UIScreen.main.bounds.width - 20) / 2
		let height: CGFloat = 245
		return CGSize(width: width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(5, 5, 5, 5)
	}
	
	//MARK: collectionviewcell
	func collectionViewCellDidClickedLikeButton(button: UIButton) {
		if !UserDefaults.standard.bool(forKey: isLogin){
			let loginVC = YJLoginViewController()
			loginVC.title = "登录"
			let nav = YJNavigationController(rootViewController: loginVC)
			present(nav, animated: true, completion: nil)
		}
	}



}
