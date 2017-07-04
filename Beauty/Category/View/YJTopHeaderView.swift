//
//  YJTopHeaderView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

protocol YJTopViewDelegate:NSObjectProtocol {
	func topViewDidClickedMoreButton(button: UIButton)
}
class YJTopHeaderView: UIView {
	
	weak var delegate: YJTopViewDelegate?
	
	@IBAction func viewAllBtn(_ sender: UIButton) {
		delegate?.topViewDidClickedMoreButton(button: sender)
	}


	


}
