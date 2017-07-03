//
//  YJDetailChoiceButtonView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

protocol YJDetailChoiceButtonViewDelegate:NSObjectProtocol {
	//图文介绍按钮
	func choiceIntroduceButtonClick()
	//评论按钮
	func choiceCommentButtonClick()
}
class YJDetailChoiceButtonView: UIView {

	weak var delegate : YJDetailChoiceButtonViewDelegate?
	
	@IBOutlet weak var lineView: UIView!
	
	@IBOutlet weak var leadingConstraint: NSLayoutConstraint!
	@IBOutlet weak var commentBtn: UIButton!
	@IBAction func introduceButtonClick(_ sender: UIButton) {
		UIView.animate(withDuration: 0.25) { 
			self.lineView.x = 0
		}
		delegate?.choiceIntroduceButtonClick()
	}
	@IBAction func commentButtonClick(_ sender: UIButton) {
		UIView.animate(withDuration: 0.25) { 
			self.lineView.x = SCREENW / 2
		}
		delegate?.choiceCommentButtonClick()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	class func choiceBtnView() -> YJDetailChoiceButtonView {
		return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)!.last as! YJDetailChoiceButtonView
	}
}
