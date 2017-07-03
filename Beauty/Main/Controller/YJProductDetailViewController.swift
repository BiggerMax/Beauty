//
//  YJProductDetailViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SnapKit

class YJProductDetailViewController: YJBaseViewController,YJProductDetailToolBarDelegate {
	
	var product: YJProduct?
	var result: YJSearchResult?
	var type = String()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
	
	func setupUI() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"GiftShare_icon_18x22_"), style: .plain, target: self, action: #selector(shareBBItemClick))
		view.addSubview(scrollView)
		view.addSubview(toolBarView)
		scrollView.product = product
		
		scrollView.snp.makeConstraints { (make) in
			make.top.left.right.equalTo(view)
			make.bottom.equalTo(toolBarView.snp.top)
		}
		
		toolBarView.snp.makeConstraints { (make) in
			make.left.bottom.right.equalTo(view)
			make.height.equalTo(45)
		}
		
		scrollView.contentSize = CGSize(width: SCREENW, height: SCREENH - 99 + 520)
	}
	
	func shareBBItemClick() {
		YJActionSheet.show()
	}
	//scrollView
	private lazy var scrollView:YJDetailScrollView = {
		let scrollView = YJDetailScrollView()
		scrollView.showsHorizontalScrollIndicator = true
		scrollView.delegate = self as? UIScrollViewDelegate
		return scrollView
	}()
	//底部栏
	private lazy var toolBarView: YJProductDetailToolBar = {
		let toolBarView = Bundle.main.loadNibNamed(String(describing:YJProductDetailToolBar.self), owner: nil, options: nil)?.last as! YJProductDetailToolBar
		toolBarView.delegate = self
		return toolBarView
	}()
	
	//底部按钮点击
	func toolBarDidClickedTMALLButton() {
		let tmallVC = YJTmallViewController()
		tmallVC.title = "商品详情"
		tmallVC.product = product
		let nav = YJNavigationController(rootViewController: tmallVC)
		present(nav, animated: true, completion: nil)
	}
}
extension YJProductDetailViewController:UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		var offsetY = scrollView.contentOffset.y
		if offsetY >= 465 {
			offsetY = CGFloat(465)
			scrollView.contentOffset = CGPoint(x: 0, y: offsetY)
		}
	}
}
