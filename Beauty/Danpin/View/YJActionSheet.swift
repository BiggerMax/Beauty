//
//  YJActionSheet.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/3.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SnapKit
class YJActionSheet: UIView {
	class func show() {
		let actionSheet = YJActionSheet()
		actionSheet.frame = UIScreen.main.bounds
		actionSheet.backgroundColor = COLOR(r: 0, g: 0, b: 0, a: 0.6)
		let window = UIApplication.shared.keyWindow
		window?.addSubview(actionSheet)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI ()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	private func setupUI() {
		addSubview(bgView)
		
		bgView.addSubview(topView)
		bgView.addSubview(cancelButton)
		topView.addSubview(shareLabel)
		topView.addSubview(shareButtonView)
		topView.snp.makeConstraints { (make) in
			make.bottom.equalTo(cancelButton.snp.top).offset(-10)
			make.left.equalTo(cancelButton.snp.left)
			make.right.equalTo(cancelButton.snp.right)
			make.height.equalTo(230)
		}
		
		cancelButton.snp.makeConstraints { (make) in
			make.left.equalTo(bgView).offset(10)
			make.right.bottom.equalTo(bgView).offset(-10)
			make.height.equalTo(44)
		}
		
		shareLabel.snp.makeConstraints { (make) in
			make.left.right.top.equalTo(topView)
			make.height.equalTo(30)
		}
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		UIView.animate(withDuration: 0.25, animations: { 
			self.bgView.y = SCREENH - self.bgView.height
		}, completion: nil)
	}
	
	//底部view
	private lazy var bgView: UIView = {
		let bgView = UIView()
		bgView.frame = CGRect(x: 0, y: SCREENH, width: SCREENW, height: 280)
		return bgView
	}()
	//上部view
	private lazy var topView: UIView = {
		let topView = UIView()
		topView.backgroundColor = UIColor.white
		topView.layer.cornerRadius = 5.0
		topView.layer.masksToBounds = true
		return topView
	}()
	//分享标签
	private lazy var shareLabel: UILabel = {
		let shareLabel = UILabel()
		shareLabel.text = "分享到"
		shareLabel.textColor = COLOR(r: 0, g: 0, b: 0, a: 0.7)
		shareLabel.textAlignment = .center
		return shareLabel
	}()
	//6个按钮
	private lazy var shareButtonView: YJShareButtonView = {
		let shareButtonView = YJShareButtonView()
		shareButtonView.frame = CGRect(x: 0, y: 30, width: SCREENW - 20, height: 200)
		return shareButtonView
	}()
	//取消按钮
	private lazy var cancelButton: UIButton = {
		let cancelButton = UIButton()
		cancelButton.setTitle("取消", for: .normal)
		cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		cancelButton.setTitleColor(COLOR(r: 37, g: 142, b: 240, a: 1.0), for: .normal)
		cancelButton.backgroundColor = UIColor.white
		cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
		cancelButton.layer.cornerRadius = 5.0
		cancelButton.layer.masksToBounds = true
		return cancelButton
	}()
	
	func cancelButtonClick() {
		UIView.animate(withDuration: 0.25, animations: { 
			self.bgView.y = SCREENH
		}) { (_) in
			self.removeFromSuperview()
		}
	}
	
	 override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		UIView.animate(withDuration: 0.25, animations: { 
			self.bgView.y = SCREENH
		}) { (_) in
			self.removeFromSuperview()
		}
	}

}
