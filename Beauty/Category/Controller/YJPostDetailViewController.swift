//
//  YJPostDetailViewController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

class YJPostDetailViewController: YJBaseViewController,UIWebViewDelegate {

	@IBOutlet weak var webView: UIWebView!
	var post: YJCollectionPost?
    override func viewDidLoad() {
        super.viewDidLoad()
		webView.scalesPageToFit = true
		webView.dataDetectorTypes = .all
		let url = URL(string: post!.content_url!)
		let request = URLRequest(url: url!)
		webView.loadRequest(request)
		view.addSubview(webView)
    }
	func webViewDidStartLoad(_ webView: UIWebView) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}
	func webViewDidFinishLoad(_ webView: UIWebView) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}

}
