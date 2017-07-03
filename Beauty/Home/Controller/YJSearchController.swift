//
//  YJSearchController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

let searchCollectionID = "searchColletionCellID"

class YJSearchController: YJBaseViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, YJCollectionViewCellDelegate,YJSortTableViewDelegate{
	
	var results = [YJSearchResult]()
	weak var collectionView: UICollectionView?
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		searchBar.becomeFirstResponder()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		searchBar.resignFirstResponder()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
		view.addSubview(searchRecordView)
    }
	
	func setupNav(){
		navigationItem.titleView = searchBar
		searchBar.delegate = self;
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(navigationBackClick))
	}
	func navigationBackClick(){
		navigationController?.popViewController(animated: true)
	}
	private lazy var searchRecordView: YJSearchRecordView = {
		let searchRecordView = YJSearchRecordView()
		searchRecordView.backgroundColor = GlobalColor()
		searchRecordView.frame = CGRect(x: 0, y: 64, width: SCREENW, height: SCREENH - 64)
		return searchRecordView
	}()
	private lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.placeholder = "请输入搜索商品"
		return searchBar
	}()
	
	func setupCollectionView() {
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
		collectionView.delegate = self
		collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
		collectionView.backgroundColor = view.backgroundColor
		collectionView.dataSource = self
		collectionView.delegate = self
		let nib = UINib(nibName: String(describing: YJCollectionViewCell.self), bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: searchCollectionID)
		view.addSubview(collectionView)
		self.collectionView = collectionView
	}
	
	func sortButtonClick() {
		
	}
	private lazy var popView: YJSortTableView = {
		let popView = YJSortTableView()
		popView.delegate = self
		return popView
	}()
	//MARK SearchBar Delegate
	func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
		setupCollectionView()
		return true
	}
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"checkUserType_backward_9x15_"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(navigationBackClick))
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"icon_sort_21x21_"), style: .plain, target: self, action: #selector(sortButtonClick))
		let keyWord = searchBar.text
		weak var weakSelf = self
		YJNetworkTool.shareNetworkTool.loadSearchResult(keyword: keyWord!, sort: "") { (results) in
			weakSelf!.results = results
			weakSelf!.collectionView!.reloadData()
		}
	}
	//	MARK UICollectionViewDelegate
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return results.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionID, for: indexPath as IndexPath) as! YJCollectionViewCell
		cell.result = results[indexPath.row]
		cell.delegate = self
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let productDetailVC = YJProductDetailViewController()
		productDetailVC.title = "商品详情"
		productDetailVC.type = String(describing:self)
		productDetailVC.result = results[indexPath.row]
		navigationController?.pushViewController(productDetailVC, animated: true)
	}
	 // MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = (UIScreen.main.bounds.width - 20) / 2
		let height: CGFloat = 245
		return CGSize(width: width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(5, 5, 5, 5)
	}
	//	MARK: - CollectionViewCellDelegate
	func collectionViewCellDidClickedLikeButton(button: UIButton) {
		if !UserDefaults.standard.bool(forKey: isLogin) {
			let loginVC = YJLoginViewController()
			loginVC.title = "登录"
			let nav = YJNavigationController(rootViewController: loginVC)
			present(nav, animated: true, completion: nil)
		}
	}
	
	// MARK: SortTableViewDelegate
	func sortView(sortView: YJSortTableView, didSelecteSortAtIndexPath sort: String) {
		let keyword = searchBar.text
		weak var weakSelf = self
		YJNetworkTool.shareNetworkTool.loadSearchResult(keyword: keyword!, sort: sort) { (results) in
			sortView.dismiss()
			weakSelf!.results = results
			weakSelf!.collectionView!.reloadData()
		}
	}

}
