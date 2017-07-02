//
//  YJProductDetailTopView.swift
//  Beauty
//
//  Created by 袁杰 on 2017/7/2.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

let detailCollectionViewCellID = "detailCollectionViewCellID"
class YJProductDetailTopView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
	var imageURLs = [String]()
	var product: YJProduct? {
		didSet{
			imageURLs = product!.image_urls!
			colletionView.reloadData()
			pageControl.numberOfPages = imageURLs.count
			titileLabel.text = product!.name
			priceLabel.text = "￥\(product!.price!)"
			describeLable.text = product!.describe
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(colletionView)
		addSubview(titileLabel)
		addSubview(pageControl)
		addSubview(priceLabel)
		addSubview(describeLable)
		
		pageControl.snp.makeConstraints { (make) in
			make.centerX.equalTo(self)
			make.centerY.equalTo(colletionView.snp.bottom).offset(-20)
		}
	}
	
	private lazy var colletionView: UICollectionView = {
		let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 375),collectionViewLayout:YJDetailLayout())
		let nib = UINib(nibName: String(describing: YJDetailCollectionViewCell.self), bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: detailCollectionViewCellID)
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.backgroundColor = GlobalColor()
		return collectionView
	}()
//pageControl
	private lazy var pageControl : UIPageControl = {
		let pageControl = UIPageControl()
		pageControl.currentPageIndicatorTintColor = UIColor.white
		pageControl.pageIndicatorTintColor = UIColor.gray
		return pageControl
	}()
	//标题
	private lazy var titileLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.numberOfLines = 0
		titleLabel.textColor = UIColor.black
		return titleLabel
	}()
	//价格
	private lazy var priceLabel: UILabel = {
		let priceLabel = UILabel()
		priceLabel.numberOfLines = 0
		priceLabel.textColor = GlobalRedColor()
		priceLabel.font = UIFont.systemFont(ofSize: 16)
		return priceLabel
	}()
	//描述
	private lazy var describeLable: UILabel = {
		let describeLabel = UILabel()
		describeLabel.numberOfLines = 0
		describeLabel.textColor = COLOR(r: 0, g: 0, b: 0, a: 0.6)
		describeLabel.font = UIFont.systemFont(ofSize: 15)
		return describeLabel
	}()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//	mark: UICollectionView Delegate
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return imageURLs.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCollectionViewCellID, for: indexPath as IndexPath) as! YJDetailCollectionViewCell
		let url = imageURLs[indexPath.row]
		cell.bgImageView.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageUrls) in
			cell.placeholderBtn.isHidden = true
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetX = scrollView.contentOffset.x
		let page = offsetX / scrollView.width
		pageControl.currentPage = Int(page + 0.5)
	}

}
private class YJDetailLayout: UICollectionViewFlowLayout {
	fileprivate override func prepare()
	{
		itemSize = CGSize(width: SCREENW, height: 375)
		minimumLineSpacing = 0
		minimumInteritemSpacing = 0
		scrollDirection = .horizontal
		collectionView?.showsHorizontalScrollIndicator = false
		collectionView?.showsVerticalScrollIndicator = true
		collectionView?.bounces = false
		collectionView?.isPagingEnabled = true
	}
}
