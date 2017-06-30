//
//  UIView+Extension.swift
//  Beauty
//
//  Created by 袁杰 on 2017/6/30.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

import UIKit

extension UIView{
	func clipRectCorner(direction:UIRectCorner,cornerRadius:CGFloat){
		let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
		let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
		let maskLayer = CAShapeLayer()
		maskLayer.frame = bounds
		maskLayer.path = maskPath.cgPath
		layer.addSublayer(maskLayer)
		layer.mask = maskLayer
	}
	
	var x: CGFloat{
		get{
			return frame.origin.x
		}
		set(newValue){
			var tempFrame : CGRect = frame
			tempFrame.origin.x = newValue
			frame = tempFrame
		}
	}
	
	var y: CGFloat{
		get{
			return frame.origin.y
		}
		set(newValue){
			var tempFrame : CGRect = frame
			tempFrame.origin.y = newValue
			frame = tempFrame
		}
	}
	var width: CGFloat {
		get {
			return frame.size.width
		}
		set(newValue) {
			var tempFrame: CGRect = frame
			tempFrame.size.width = newValue
			frame = tempFrame
		}
	}
	/// height
	var height: CGFloat {
		get {
			return frame.size.height
		}
		set(newValue) {
			var tempFrame: CGRect = frame
			tempFrame.size.height = newValue
			frame                 = tempFrame
		}
	}
	/// size
	var size: CGSize {
		get {
			return frame.size
		}
		set(newValue) {
			var tempFrame: CGRect = frame
			tempFrame.size = newValue
			frame = tempFrame
		}
	}
	/// centerX
	var centerX: CGFloat {
		get {
			return center.x
		}
		set(newValue) {
			var tempCenter: CGPoint = center
			tempCenter.x = newValue
			center = tempCenter
		}
	}
	
	/// centerY
	var centerY: CGFloat {
		get {
			return center.y
		}
		set(newValue) {
			var tempCenter: CGPoint = center
			tempCenter.y = newValue
			center = tempCenter;
		}
	}

}
