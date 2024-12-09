//
//
//  BlogCell.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit
import SnapKit

class BlogCell: BaseTableViewCell {
	
	private let coverImageView = UIImageView()
	private let titleLabel = UILabel()
	var blogModel:BlogModel?

	private let tagView: TagsView = TagsView(frame: CGRect(x: LayoutUtil.marginMedium, y: 0, width: LayoutUtil.screenWidth - LayoutUtil.marginMedium * 2, height: 0))
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		coverImageView.contentMode = .scaleAspectFill
		coverImageView.layer.cornerRadius = 8
		coverImageView.clipsToBounds = true
		contentView.addSubview(coverImageView)
		
		titleLabel.font = .boldSystemFont(ofSize: 16)
		titleLabel.textColor = ColorUtil.textColor
		titleLabel.numberOfLines = 0
		contentView.addSubview(titleLabel)
		
		contentView.addSubview(self.tagView)

		//宽度和高度比为368:207
		let coverImageHeight = LayoutUtil.screenWidth * 207 / 368

		coverImageView.snp.makeConstraints { make in
			make.top.left.right.equalToSuperview().inset(LayoutUtil.marginMedium)
			make.height.equalTo(coverImageHeight)
		}
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(coverImageView.snp.bottom).offset(8)
			make.left.right.equalToSuperview().inset(LayoutUtil.marginMedium)
			make.bottom.equalToSuperview().inset(tagView.height + 8)
		}
	}
	
	func configure(with blog: BlogModel) {
		blogModel = blog
		if let cover = blog.cover, !cover.isEmpty {
			loadImageUrl(imageID: cover ,placeholder: UIImage(named: "Logo"))
		} else {
			// 处理无封面图片的情况
		}
		titleLabel.text = blog.title
		if let labels = blog.labels {
			tagView.labels = labels
		}
		
		titleLabel.snp.updateConstraints { make in
			make.bottom.equalToSuperview().inset(tagView.height +  18)
		}
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		tagView.y = titleLabel.y + titleLabel.height + 8;
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		coverImageView.image = nil
	}
	
	func loadImageUrl(imageID: String, placeholder: UIImage? = nil) {
		coverImageView.image = placeholder
		DispatchQueue.global(qos: .background).async {
			ImageService.shared.loadImage(imageID: imageID) { [weak self] image, error in
				DispatchQueue.main.async {
					RunLoop.main.perform(inModes: [.common]) {
						if imageID == self?.blogModel?.cover {
							self?.coverImageView.image = image
						}
					}
				}
			}
		}
	}
	
}


