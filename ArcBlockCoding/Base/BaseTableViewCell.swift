//
//
//  BaseTableViewCell.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit

class BaseTableViewCell: UITableViewCell {
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupViews()
	}
	
	func setupViews() {
		backgroundColor = ColorUtil.backgroundColor
		selectionStyle = .none
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
	}
}
