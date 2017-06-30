//
//  YJNewfeatureController.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/29.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class YJNewfeatureController: UICollectionViewController {

	private var layout:UICollectionViewFlowLayout = YJNewfeatureLayout()
	
	init() {
		super.init(collectionViewLayout: layout)
		collectionView?.showsHorizontalScrollIndicator = false
	}
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
}
private class YJNewfeatureCell: UICollectionViewCell{
	private var imageIndex:Int?{
		didSet{
			
		}
	}
	
	override init(frame:CGRect){
		super.init(frame: frame)
		
		setupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		contentView.addSubview(iconView)
	}
	
	private lazy var iconView = UIImageView()
	
	private lazy var startButton:UIButton = {
		let btn = UIButton()
		btn.setBackgroundImage(UIImage(named:"btn_begin"), for: .normal)
		btn.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
		btn.layer.masksToBounds = true
		btn.isHidden = true
		return btn
	}()
	
	@objc func startButtonClick(){
		UIApplication.shared.keyWindow?.rootViewController = YJTabBarController()
	}
}
private class YJNewfeatureLayout:UICollectionViewFlowLayout{
	fileprivate override func prepare() {
		itemSize = UIScreen.main.bounds.size
		minimumLineSpacing = 0
		minimumInteritemSpacing = 0
		scrollDirection = .horizontal
		collectionView?.showsVerticalScrollIndicator = false
		collectionView?.bounces = false
		collectionView?.isPagingEnabled = true
	}
}
