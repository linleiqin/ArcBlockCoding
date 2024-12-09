//
//
//  BlogDetailViewController.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation
import UIKit
import SnapKit
import MJRefresh

class BlogDetailViewController: BaseViewController {
	
	let blogModel:BlogModel!
	
	let textView = UITextView()
	
	init(blogModel: BlogModel!) {
		self.blogModel = blogModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = blogModel.title
		setupUI()
		fetchBlogDetail()
	}
	
	private func setupUI() {
		view.backgroundColor = ColorUtil.backgroundColor
		textView.frame = view.bounds
		textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 100, right: 15)
		view.addSubview(textView)
	}
	
	private func fetchBlogDetail() {
		Task {
			do {
				var blogDetail = try await ServiceBlog.shared.fetchDetail(slug: blogModel.slug)
				if let blogDetail = blogDetail {
					var fullAttributedString = NSMutableAttributedString()
					if let rootChildren = blogDetail.contentModel?.root.children ,rootChildren.count > 0 {
						for var subChild in rootChildren {
							fullAttributedString.append(subChild.attributedString)
						}
					}
					textView.attributedText = fullAttributedString
				}
			} catch {
				print("Error fetchDetail: \(error)")
			}
		}
	}
}

