//
//
//  BlogAttributedString.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/9.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation

class BlogAttributedString: NSMutableAttributedString {

	let content:Content

	init(content: Content) {
		self.content = content
		super.init()
		
	}
	
	func generateContentAttributedString() -> BlogAttributedString {
//		var fullAttributedString = NSMutableAttributedString()
		if let rootChildren = self.content.root.children ,rootChildren.count > 0 {
			for var subChild in rootChildren {
				self.append(subChild.attributedString)
			}
		}
		return self
	}
	
//	func generateRootChildrenAttributedString(child:SubChild) -> NSMutableAttributedString {
//		var fullAttributedString = NSMutableAttributedString()
//		if var attributedString = child.attributedString {
//			return attributedString;
//		}
//		return fullAttributedString
//	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

class BlogAttributedStringProvider {
	private let content: Content
	private lazy var blogAttributedString: BlogAttributedString = {
		return BlogAttributedString(content: content)
	}()
	
	init(content: Content) {
		self.content = content
	}
	
	func getBlogAttributedString() -> BlogAttributedString? {
		return blogAttributedString.generateContentAttributedString()
	}
}

