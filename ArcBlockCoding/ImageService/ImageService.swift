//
//
//  ImageService.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit

class ImageService {
	static let shared = ImageService()
	
	private init() {}
	
	private let cache = ImageCache.shared

	func loadImage(imageID: String, completion: @escaping (UIImage?, Error?) -> Void) {
		let urlString = Endpoints.baseImageURL + imageID
		loadImageUrl(urlString: urlString, completion: completion)
	}
	
	func loadImageUrl(urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
		
		if let cachedImage = cache.image(forKey: urlString) {
			completion(cachedImage, nil)
			return
		}
		
		// 下载图片
		guard let url = URL(string: urlString) else {
			completion(nil, NSError(domain: "ImageService", code: -1, userInfo: nil))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
			if let error = error {
				completion(nil, error)
				return
			}
			
			guard let data = data, let image = UIImage(data: data) else {
				completion(nil, NSError(domain: "ImageService", code: -2, userInfo: nil))
				return
			}
			
			self?.cache.store(image: image, forKey: urlString, isThumbnail: false)
			if let compressedImage = self?.compressImage(image) {
				self?.cache.store(image: compressedImage, forKey: urlString, isThumbnail: true)
			}
			
			// 返回下载后的原图
			completion(image, nil)
		}
		
		task.resume()
	}

	/// 压缩图片
	private func compressImage(_ image: UIImage) -> UIImage? {
		let screenWidth = UIScreen.main.bounds.width
		
		let targetWidth = screenWidth
		let aspectRatio = image.size.width / image.size.height
		let targetHeight = targetWidth / aspectRatio
		
		UIGraphicsBeginImageContextWithOptions(CGSize(width: targetWidth, height: targetHeight), false, image.scale)
		image.draw(in: CGRect(origin: .zero, size: CGSize(width: targetWidth, height: targetHeight)))
		let compressedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return compressedImage
	}
}

