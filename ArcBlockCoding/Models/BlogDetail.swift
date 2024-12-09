//
//
//  BlogDetail.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/8.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation
import UIKit

// MARK: - Root Model
struct BlogDetailResponse: Decodable {
	let id, title: String
	let content: String
	let contentModel: Content?
	
	enum CodingKeys: String, CodingKey {
		case id,title,content
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decodeIfPresent(String.self, forKey: .id)!
		title = try container.decodeIfPresent(String.self, forKey: .title)!
		content = try container.decodeIfPresent(String.self, forKey: .content)!

		if let contentData = content.parseJSON() as? [String: Any] {
			do {
				let jsonData = try contentData.toJSONData()
				contentModel = jsonData.deCodable(type: Content.self)!
			} catch {
				contentModel = nil
				print("parse contentModel: \(error)")
			}
		} else {
			contentModel = nil
		}
	}
	
}

// MARK: - Author
struct Author: Decodable {
	let did, fullName, avatar: String
	let passports: [String]
	let locale: String
	let pointInfo: PointInfo
}

// MARK: - PointInfo
struct PointInfo: Decodable {
	let maxPoints, unUsedPoints: Int
	let grade: Grade
}

// MARK: - Grade
struct Grade: Decodable {
	let name: String
	let icon: String
	let id: String
	let isDisabled: Int
}

// MARK: - Board
struct Board: Decodable {
	let id, title, desc: String
	let type: String
	let createdBy: String
	let createdAt, updatedAt: String
}
