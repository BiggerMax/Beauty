//
//  YJCategoryController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJCategoryController: YJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(categoryRightBBClick))
		setupScrollView()
    }
	private func setupScrollView() {
		view.addSubview(scrollView)
		let headerViewController = YJCategoryHeaderViewController()
		addChildViewController(headerViewController)
		
		let topBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 135))
		scrollView.addSubview(topBgView)
		
		let headerVC = childViewControllers[0]
		topBgView.addSubview(headerVC.view)
		
		
	}
	func categoryRightBBClick() {
		let searBarVC = YJSearchController()
		navigationController?.pushViewController(searBarVC, animated: true)
	}
	
	private lazy var scrollView:UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.isScrollEnabled = true
		scrollView.backgroundColor = GlobalColor()
		scrollView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH)
		return scrollView
	}()
	
	

}
