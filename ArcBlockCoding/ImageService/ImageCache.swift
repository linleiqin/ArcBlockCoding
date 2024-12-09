//
//
//  ImageCache.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit

class ImageCache {
	static let shared = ImageCache()

	private init() {}

	// 内存缓存
	private let memoryCache = NSCache<NSString, UIImage>()

	// 磁盘缓存路径
	private lazy var imageCacheDirectory: URL = {
		let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
			.appendingPathComponent("ImageCache/Images")
		if !FileManager.default.fileExists(atPath: directory.path) {
			try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
		}
		return directory
	}()

	// 压缩图缓存路径
	private lazy var thumbCacheDirectory: URL = {
		let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
			.appendingPathComponent("ImageCache/Thumbs")
		if !FileManager.default.fileExists(atPath: directory.path) {
			try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
		}
		return directory
	}()

	func image(forKey key: String) -> UIImage? {
		// 先查内存缓存
		if let memoryImage = memoryCache.object(forKey: key as NSString) {
			return memoryImage
		}

		// 查缩图缓存
		let thumbPath = thumbCacheDirectory.appendingPathComponent(key)
		if let thumbData = try? Data(contentsOf: thumbPath), let thumbImage = UIImage(data: thumbData) {
			// 加载到内存缓存
			memoryCache.setObject(thumbImage, forKey: key as NSString)
			return thumbImage
		}
		
		// 再查原图缓存
		let diskPath = imageCacheDirectory.appendingPathComponent(key)
		if let diskData = try? Data(contentsOf: diskPath), let diskImage = UIImage(data: diskData) {
			// 加载
			memoryCache.setObject(diskImage, forKey: key as NSString)
			return diskImage
		}



		return nil
	}

	// 存储图片
	func store(image: UIImage, forKey key: String, isThumbnail: Bool = false) {
		// 存储到内存缓存
		memoryCache.setObject(image, forKey: key as NSString)

		// 存储到磁盘
		DispatchQueue.global(qos: .background).async {
			let directory = isThumbnail ? self.thumbCacheDirectory : self.imageCacheDirectory
			let diskPath = directory.appendingPathComponent(key)

			if let data = image.pngData() {
				try? data.write(to: diskPath)
			}
		}
	}

	// 清除缓存
	func clearCache() {
		memoryCache.removeAllObjects()
		try? FileManager.default.removeItem(at: imageCacheDirectory)
		try? FileManager.default.removeItem(at: thumbCacheDirectory)
	}
}
