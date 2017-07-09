//
//  YJMyHeaderView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/6.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SnapKit
class YJMyHeaderView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	private func setupUI() {
		addSubview(bgImageView)
		addSubview(messageBtn)
		addSubview(settingBtn)
		addSubview(iconBtn)
		addSubview(nameLabel)
		
		bgImageView.snp.makeConstraints { (make) in
			make.left.bottom.right.right.equalTo(self)
			make.top.equalTo(-20)
		}
		settingBtn.snp.makeConstraints { (make) in
			make.size.equalTo(CGSize(width: 44, height: 44))
			make.right.equalTo(self)
			make.top.equalTo(0)
		}
		messageBtn.snp.makeConstraints { (make) in
			make.size.equalTo(CGSize(width: 44, height: 44))
			make.left.equalTo(self)
			make.top.equalTo(settingBtn.snp.top)
		}
		iconBtn.snp.makeConstraints { (make) in
			make.centerX.equalTo(SCREENW * 0.5)
			make.size.equalTo(CGSize(width: 75, height: 75))
			make.bottom.equalTo(nameLabel.snp.top).offset(-5)
		}
		nameLabel.snp.makeConstraints { (make) in
			make.bottom.equalTo(self).offset(-30)
			make.left.right.equalTo(self)
			make.height.equalTo(20)
		}
		
	}
	lazy var bgImageView: UIImageView = {
		let bgImageView = UIImageView()
		bgImageView.contentMode = .scaleAspectFill
		bgImageView.image = UIImage(named: "Me_ProfileBackground")
		return bgImageView
	}()
	lazy var messageBtn: UIButton = {
		let messageBtn = UIButton()
		messageBtn.setImage(UIImage(named:"Me_message_20x20_"), for: .normal)
		return messageBtn
	}()
	lazy var settingBtn: UIButton = {
		let settingBtn = UIButton()
		settingBtn.setImage(UIImage(named:"Me_settings_20x20_"), for: .normal)
		return settingBtn
	}()
	lazy var iconBtn: UIButton = {
		let iconBtn = UIButton()
		iconBtn.setBackgroundImage(UIImage(named:"Me_AvatarPlaceholder_75x75_"), for: .normal)
		iconBtn.layer.cornerRadius = iconBtn.width * 0.5
		iconBtn.layer.masksToBounds = true
		return iconBtn
	}()
	lazy var nameLabel: UILabel = {
		let namelabel = UILabel()
		namelabel.text = "Jerry"
		namelabel.font = UIFont.systemFont(ofSize: 15.0)
		namelabel.textColor = UIColor.white
		namelabel.textAlignment = .center
		return namelabel
	}()
}
