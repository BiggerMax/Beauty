//
//  YJTmallViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/3.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJTmallViewController: YJBaseViewController,UIWebViewDelegate {

	var product :YJProduct?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupNav()
		
		webView.scalesPageToFit = true
		webView.dataDetectorTypes = .all
		let url = URL(string: product!.purchase_url!)
		let request = URLRequest(url:url!)
		webView.loadRequest(request)
    }
	func setupNav() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(navigationBackClick))
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"GiftShare_icon_18x22_"), style: .plain, target: self, action: #selector(shareBBItemClick))
	}
	
	func shareBBItemClick() {
		YJActionSheet.show()
	}
	func navigationBackClick() {
		dismiss(animated: true, completion: nil)
	}
	private lazy var webView:UIWebView = {
		let webView = UIWebView()
		webView.frame = UIScreen.main.bounds
		return webView
	}()
	
	//MARK --WebView
	func webViewDidStartLoad(_ webView: UIWebView) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}
	func webViewDidFinishLoad(_ webView: UIWebView) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = false
	}

}
