//
//  YJProductBottomView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SnapKit

let commentCellID = "commentCellID"

class YJProductBottomView: UIView,UITableViewDelegate,UITableViewDataSource,YJDetailChoiceButtonViewDelegate,UIWebViewDelegate {
	
	var comments = [YJComment]()
	
	var product: YJProduct? {
		didSet {
			weak var weakSelf = self
			YJNetworkTool.shareNetworkTool.loadProductDetailData(id: product!.id!) { (productDetail) in
				weakSelf?.choiceButtonView.commentBtn.setTitle("评论(\(productDetail.comments_count!))", for: .normal)
				weakSelf!.webView.loadHTMLString(productDetail.detail_html!, baseURL: nil)
			}
			YJNetworkTool.shareNetworkTool.loadProductDetailComments(id: product!.id!) { (comments) in
				weakSelf!.comments = comments
				weakSelf!.tableView.reloadData()
			}
		}
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	func setupUI(){
		addSubview(choiceButtonView)
		addSubview(tableView)
		addSubview(webView)
		 choiceButtonView.snp.makeConstraints { (make) in
			make.size.equalTo(CGSize(width:SCREENW,height: 44))
			make.top.equalTo(self)
			make.leading.equalTo(self)
		}
		tableView.snp.makeConstraints { (make) in
			make.top.equalTo(choiceButtonView.snp.bottom)
			make.left.right.bottom.equalTo(self)
		}
		webView.snp.makeConstraints { (make) in
			make.top.equalTo(choiceButtonView.snp.bottom)
			make.left.right.bottom.equalTo(self)
		}
	}
	
	
	private lazy var choiceButtonView: YJDetailChoiceButtonView = {
		let choiceBtnVIew = YJDetailChoiceButtonView.choiceBtnView()
		choiceBtnVIew.delegate = self
		return choiceBtnVIew
	}()
	private lazy var tableView:UITableView = {
		let tableView = UITableView()
		tableView.isHidden = true
		let nib = UINib(nibName: String(describing:YJCommentCell.self), bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: commentCellID)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorStyle = .none
		tableView.rowHeight = 64
		return tableView
	}()
	
	private lazy var webView:UIWebView = {
		let webView = UIWebView()
		webView.scalesPageToFit = true
		webView.dataDetectorTypes = .all
		webView.delegate = self
		return webView
	}()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK --YJDetailChoiceButtonViewDelegate
	func choiceIntroduceButtonClick() {
		tableView.isHidden = true
		webView.isHidden = false
	}
	func choiceCommentButtonClick() {
		tableView.isHidden = false
		webView.isHidden = true
	}
	
	//	mark UIWebViewDelegate
	func webViewDidStartLoad(_ webView: UIWebView) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}
	func webViewDidFinishLoad(_ webView: UIWebView) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = false
	}
	//	mark --UITableViewDelegate
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return comments.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: commentCellID, for: indexPath) as! YJCommentCell
		cell.comment = comments[indexPath.row]
		return cell
	}
	
	

	

}
