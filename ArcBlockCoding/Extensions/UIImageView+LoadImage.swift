//
//
//  UIImageView+LoadImage.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit

extension UIImageView {
	/// 异步加载图片并设置到 `UIImageView` 上
	/// - Parameters:
	///   - imageID: 图片的唯一标识（如 `c5052c80d72b1a4d4eea14bd84cc61ff.png`）
	///   - placeholder: 占位图（默认值为 `nil`）
	func loadImageUrl(imageID: String, placeholder: UIImage? = nil) {
		// 设置占位图
		self.image = placeholder
		ImageService.shared.loadImage(imageID: imageID) { [weak self] image, error in
			DispatchQueue.main.async {
				if let error = error {
					print("加载图片失败: \(error)")
				} else if let image = image {
					self?.image = image
				}
			}
		}
	}
}

