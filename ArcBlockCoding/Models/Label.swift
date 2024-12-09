//
//
//  Label.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation

struct Label: Decodable {
	let id: String
	let name: String
	let icon: String?
	let color: String?
	let type: String?
	let parentId: String?
	let translation: String?
	let createdAt: String
	let updatedAt: String

	var isSelected: Bool = false  // 默认值为 false

	enum CodingKeys: String, CodingKey {
		case id, name, icon, color, type, parentId, translation, createdAt, updatedAt
	}
	
}

// 单个 Stat 模型
struct Stat: Decodable {
	let id: String
	let count: Int
}

// 整体响应模型
struct LabelsResponse: Decodable {
	let labels: [Label]
	let stats: [Stat]
}
