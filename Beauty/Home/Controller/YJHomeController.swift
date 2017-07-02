//
//  YJHomeController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/28.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJHomeViewController: YJBaseViewController,UIScrollViewDelegate {
	
	var channels = [YJChannel]()
	//标签
	weak var titleView = UIView()
	//底部红色指示器
	weak var indicatorView = UIView()
	
	weak var contentView = UIScrollView()
	//当前选中按钮
	weak var seletecdBtn = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//设置导航栏
		setupNav()
		weak var weakSelf = self
		YJNetworkTool.shareInstance.loadHomeTopData { (home_channels) in
			for channel in home_channels{
				let vc = YJTopicViewController()
				vc.title = channel.name!
				vc.type = channel.id!
				weakSelf?.addChildViewController(vc)
			}
			self.setupTitleView()
			self.setupContentView()
		}

	}
	func setupTitleView(){
		let bgView = UIView()
		bgView.frame = CGRect(x: 0, y: 64, width: SCREENW, height: 35)
		view.addSubview(bgView)
		
		//标签
		let titlesView = UIView()
		titlesView.backgroundColor = GlobalColor()
		titlesView.frame = CGRect(x: 0, y: 0, width: SCREENW - 35, height: 35)
		bgView.addSubview(titlesView)
		self.titleView = titlesView
		//指示器
		let indicatorView = UIView()
		indicatorView.backgroundColor = GlobalRedColor()
		indicatorView.height = 1.0
		indicatorView.y = 34
		indicatorView.tag = -1
		self.indicatorView = indicatorView
		
		//选择按钮
		let arrowBtn = UIButton()
		arrowBtn.frame = CGRect(x: SCREENW - 35, y: 0, width: 35, height: 35)
		arrowBtn.setImage(UIImage(named: "arrow_index_down_8x4_"), for: .normal)
		arrowBtn.addTarget(self, action: #selector(arrowBtnClicked), for: .touchUpInside)
		arrowBtn.backgroundColor = GlobalColor()
		bgView.addSubview(arrowBtn)
		
		//子标签
		let count = childViewControllers.count
		let width = titlesView.width / CGFloat(count)
		let height = titlesView.height
		
		for index in 0..<count {
			let button = UIButton()
			button.height = height
			button.width = width
			button.x = CGFloat(index) * width
			button.tag = index
			let vc = childViewControllers[index]
			button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
			button.setTitle(vc.title!, for: .normal)
			button.setTitleColor(UIColor.gray, for: .normal)
			button.setTitleColor(GlobalRedColor(), for: .disabled)
			button.addTarget(self, action: #selector(titlesClick), for: .touchUpInside)
			titlesView.addSubview(button)
			
			//默认第一个按钮
			if index == 0 {
				button.isEnabled = false
				seletecdBtn = button
				button.titleLabel?.sizeToFit()
				indicatorView.width = button.titleLabel!.width
				indicatorView.centerX = button.centerX
				
			}
		}
		titlesView.addSubview(indicatorView)
	}
	
	func arrowBtnClicked(button: UIButton) {
		UIView.animate(withDuration: 0.25) { 
			button.imageView?.transform = button.imageView!.transform.rotated(by: CGFloat(Double.pi))
		}
	}
	func titlesClick(button: UIButton) {
		seletecdBtn?.isEnabled = true
		button.isEnabled = false
		seletecdBtn = button
		
		UIView.animate(withDuration: 0.25) { 
			self.indicatorView?.width = self.seletecdBtn!.width
			self.indicatorView?.centerX = self.seletecdBtn!.centerX
		}
		var offset = contentView!.contentOffset
		offset.x = CGFloat(button.tag) * contentView!.width
		contentView?.setContentOffset(offset, animated: true)
		
	}
	func setupContentView(){
		automaticallyAdjustsScrollViewInsets = false
		
		let contentView = UIScrollView()
		contentView.frame = view.bounds
		contentView.delegate = self
		contentView.contentSize = CGSize(width: contentView.width * CGFloat(childViewControllers.count), height: 0)
		contentView.isPagingEnabled = true
		view.insertSubview(contentView, at: 0)
		self.contentView = contentView
		
		scrollViewDidEndScrollingAnimation(contentView)
	}
	
	func setupChildViewControllers(){
		for channel in channels{
			let vc = YJTopicViewController()
			vc.title = channel.name
			addChildViewController(vc)
		}
	}
	func setupNav() {
		view.backgroundColor = UIColor.white
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(rightBtnClicked))
	}
	func rightBtnClicked(){
		let searchController = YJSearchController()
		navigationController?.pushViewController(searchController, animated: true)
	}
	
	//MARK: -- UIScrollViewDelegate
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		let index = Int(scrollView.contentOffset.x / scrollView.width)
		let vc = childViewControllers[index]
		vc.view.x =  scrollView.contentOffset.x
		vc.view.y = 0
		vc.view.height = scrollView.height
		scrollView.addSubview(vc.view)
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		scrollViewDidEndScrollingAnimation(scrollView)
		let index = Int(scrollView.contentOffset.x / scrollView.width)
		let button = titleView?.subviews[index] as! UIButton
		titlesClick(button: button)
	}
}
