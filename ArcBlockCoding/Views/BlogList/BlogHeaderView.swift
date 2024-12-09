//
//
//  BlogHeaderView.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit
import SnapKit

class BlogHeaderView: UIView {

	let segmentedControl = UISegmentedControl(items: ["最新", "最旧"])
	let blogStyleControl = UISegmentedControl(items: ["全部文章", "Blogs"])

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI() {
		segmentedControl.frame = CGRect(x: LayoutUtil.screenWidth - 116, y: 8, width: 100, height: 40)
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
		addSubview(segmentedControl)
		
		
	}
	
	var onSelected: ((_ selectedIndex :Int) -> Void)?

	
	@objc func segmentChanged(sender: UISegmentedControl) {
		let selectedIndex = sender.selectedSegmentIndex
		onSelected?(selectedIndex)
	}
	
}
