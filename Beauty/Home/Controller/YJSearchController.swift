//
//  YJSearchController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

let searchCollectionID = "searchColletionCellID"

class YJSearchController: YJBaseViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, YJCollectionViewCellDelegate{
	
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
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(navigationBackClick))
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
		
	}
	
	func sortButtonClick() {
		
	}
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
		YJNetworkTool.shareInstance.loadSearchResult(keyword: keyWord!, sort: "") { (results) in
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
		let productDetailVC = YJP
	}

}
