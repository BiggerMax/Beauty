//
//  YJProductDetailToolBar.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

protocol YJProductDetailToolBarDelegate: NSObjectProtocol {
	func toolBarDidClickedTMALLButton()
}
class YJProductDetailToolBar: UIView {
	weak var delegate: YJProductDetailToolBarDelegate?
	
	@IBOutlet weak var likeBtn: UIButton!
	
	@IBAction func likeBtnClicked(_ sender: UIButton) {
		if UserDefaults.standard.bool(forKey: isLogin){
			sender.isSelected = !sender.isSelected
		}else{
			let loginVC = YJLoginViewController()
			loginVC.title = "登录"
			let nav = YJNavigationController(rootViewController: loginVC)
			UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
		}
	}
	@IBAction func goTMALLBtn(_ sender: UIButton) {
		delegate?.toolBarDidClickedTMALLButton()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		likeBtn.layer.borderColor = GlobalRedColor().cgColor
		likeBtn.layer.borderWidth = 1.0
		likeBtn.setImage(UIImage(named:"content-details_like_16x16_"), for: .normal)
		likeBtn.setImage(UIImage(named:"content-details_like_selected_16x16_"), for: .selected)
	}
}
