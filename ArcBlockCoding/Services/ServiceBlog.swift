//
//
//  ServiceBlog.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation

class ServiceBlog {
	static let shared = ServiceBlog()
	
//	content/api/blogs?page=1&size=20&locale=zh&tagMatchStrategy=all&sort=-publishTime
//	/content/api/blogs?page=1&size=20&locale=zh&boardId=blog-default&tagMatchStrategy=all&sort=-publishTime

	func fetchBlogList(page: Int = 1, size: Int = 20, showAll:Bool = true,filterIds:[String] = [] ,newest:Bool = true) async throws -> [BlogModel] {
		var urlComponents = URLComponents(string: Endpoints.Service.blogs)!
		urlComponents.queryItems = [
			URLQueryItem(name: "page", value: "\(page)"),
			URLQueryItem(name: "size", value: "\(size)"),
			URLQueryItem(name: "locale", value: "zh"),
			URLQueryItem(name: "sort", value: newest ? "-publishTime" : "publishTime"),
		]
		if showAll {
			urlComponents.queryItems?.append(URLQueryItem(name: "tagMatchStrategy", value: "all"))
		} else {
			urlComponents.queryItems?.append(URLQueryItem(name: "boardId", value: "blog-default"))
		}
		if filterIds.count > 0 {
			filterIds.forEach { id in
				urlComponents.queryItems?.append(URLQueryItem(name: "labels[]", value: id))
			}
		}

		let url = urlComponents.url!
		
		print("url = \(url)")

		let response = try await NetworkManager.shared.get(BlogResponse.self, url: url)
		if let response = response {
			return response.data
		} else {
			return []
		}
	}
	
	func fetchLabels() async throws -> [Label] {
		let urlComponents = URLComponents(string: Endpoints.Service.labels)!
		
		let url = urlComponents.url!
		let response = try await NetworkManager.shared.get(LabelsResponse.self, url: url)
		if let response = response {
			return response.labels
		} else {
			return []
		}
	}
	
	func fetchDetail(slug:String) async throws -> BlogDetailResponse? {
		var urlComponents = URLComponents(string: "\(Endpoints.Service.detail)\(slug)")!
		urlComponents.queryItems = [
			URLQueryItem(name: "locale", value: "zh"),
		]
		
		let url = urlComponents.url!
		let response = try await NetworkManager.shared.get(BlogDetailResponse.self, url: url)
		if let response = response {
			return response
		} else {
			return nil
		}
	}
}
