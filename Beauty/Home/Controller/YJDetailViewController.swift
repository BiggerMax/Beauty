//
//  YJDetailViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/30.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SVProgressHUD

class YJDetailViewController: YJBaseViewController,UIWebViewDelegate {

	var homeItem:YJHomeItem?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = UIWebView()
		webView.frame = view.bounds
		webView.scalesPageToFit = true
		webView.dataDetectorTypes = .all
		let url = URL(string: homeItem!.content_url!)
		let request = URLRequest(url: url! as URL)
		webView.loadRequest(request)
		webView.delegate = self
		view.addSubview(webView)
    }
	
	func webViewDidStartLoad(_ webView: UIWebView) {
		SVProgressHUD.setStatus("正在加载...")
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		return true
	}


}
