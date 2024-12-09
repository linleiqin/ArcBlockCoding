//
//
//  UIView+Ext.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit

extension UIView {
	
	var centerX: CGFloat {
		get {
			return self.center.x
		}
		set {
			self.center.x = newValue
		}
	}
	
	var centerY: CGFloat {
		get {
			return self.center.y
		}
		set {
			self.center.y = newValue
		}
	}
	
	var x: CGFloat {
		get {
			return self.frame.origin.x
		}
		set {
			self.frame.origin.x = newValue
		}
	}
	
	var y: CGFloat {
		get {
			return self.frame.origin.y
		}
		set {
			self.frame.origin.y = newValue
		}
	}
	
	var width: CGFloat {
		get {
			return self.frame.size.width
		}
		set {
			self.frame.size.width = newValue
		}
	}
	
	var height: CGFloat {
		get {
			return self.frame.size.height
		}
		set {
			self.frame.size.height = newValue
		}
	}
	
	var size: CGSize {
		get {
			return self.frame.size
		}
		set {
			self.frame.size = newValue
		}
	}
}

