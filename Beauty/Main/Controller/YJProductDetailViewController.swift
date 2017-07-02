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
	}
	
	func shareBBItemClick() {
		
	}
	
	private lazy var scrollView:


}
