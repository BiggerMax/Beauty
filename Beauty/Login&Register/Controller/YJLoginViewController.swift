//
//  YJLoginViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/30.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJLoginViewController: YJBaseViewController {
	@IBOutlet var mobileTF: UILabel!

	@IBOutlet var pswTF: UILabel!
	
	@IBOutlet var loginBtn: UIButton!
	
	@IBOutlet weak var forgetBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
		self .setupBarButtonItem()
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func loginBtnClicked(_ sender: UIButton) {
		UserDefaults.standard.set(true, forKey: isLogin)
		dismiss(animated: true, completion: nil)
	}
	func setupBarButtonItem(){
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelButtonClick))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(regiisterButtonClick))
	}
	
	func cancelButtonClick(){
		dismiss(animated: true, completion: nil)
	}
	func regiisterButtonClick(){
		let registerVC = YJRegisterViewController()
		registerVC.title = "注册"
		navigationController?.pushViewController(registerVC, animated: true)
	}
	@IBAction func otherLogin(_ sender: UIButton) {
		if let buttonType = YJOtherLoginType(rawValue:sender.tag)
		{
			switch buttonType {
			case .weibo:
				break
			case .weChat:
				break
			case .qq:
				break
						}
		}
	}

}
