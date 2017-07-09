//
//  YJMyFooterView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/6.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJMyFooterView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	private func setupUI() {
		addSubview(meBlackButton)
		addSubview(messageLabel)
		meBlackButton.snp.makeConstraints { (make) in
			make.size.equalTo(CGSize(width: 50, height: 50))
			make.center.equalTo(self.center)
		}
		
		messageLabel.snp.makeConstraints { (make) in
			make.top.equalTo(meBlackButton.snp.bottom).offset(10)
			make.left.right.equalTo(self)
		}
	}
	
	lazy var meBlackButton: UIButton = {
		let myBlankBtn = UIButton()
		myBlankBtn.setTitleColor(COLOR(r: 200, g: 200, b: 200, a: 1.0), for: .normal)
		//myBlankBtn.width = 100
		myBlankBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		myBlankBtn.setImage(UIImage(named:"Me_blank_50x50_"), for: .normal)
		myBlankBtn.addTarget(self, action: #selector(footerViewButtonClick), for: .touchUpInside)
		return myBlankBtn
	}()
	
	lazy var messageLabel:UILabel = {
		let messageLabel = UILabel()
		messageLabel.text = "登录以享受功能"
		messageLabel.font = UIFont.systemFont(ofSize: 15)
		messageLabel.textAlignment = .center
		messageLabel.textColor = COLOR(r: 200, g: 200, b: 200, a: 1.0)
		return messageLabel
	}()
	func footerViewButtonClick() {
		let nav = YJNavigationController(rootViewController: YJLoginViewController())
		UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
	}
	

}
