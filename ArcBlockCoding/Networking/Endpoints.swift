//
//
//  Endpoints.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation

struct Endpoints {
	
	
	static let baseURL: String = {
		// 从 Info.plist 中读取 BASE_URL
		if let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String, !url.isEmpty {
			print("Base URL: \(url)")
			return url
		} else {
			// 如果没有设置 BASE_URL，则提供在Config.xcconfig里设置
			print("在Info.plist里设置BASE_URL")
			return ""
		}
	}()
	
	static let baseImageURL = "\(baseURL)/blog/uploads/"

	struct Service {
		static let blogs = "\(baseURL)/content/api/blogs"
		static let labels = "\(baseURL)/content/api/labels"
		static let detail = "\(baseURL)/content/api/blogs/slug/"
	}
}


