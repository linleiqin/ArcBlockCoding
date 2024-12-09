//
//
//  ArticleElementType.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/8.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation
import UIKit

struct Content: Decodable {
	let root: Root
}

struct Root: Decodable {
	let children: [SubChild]?
	let direction: String?
	let format: String?
	let indent: Int?
	let type: String?
	let version: Int?
}

enum TagType: String, Decodable {
	case h2 = "h2"  // 大标题
	case h3 = "h3"  // 小标题
	case ul = "ul"  // 无序列表
	case ol = "ol"
	
	case unknown = ""  // 未知类型
	var fontSize: CGFloat {
		switch self {
		case .h2:
			return 22.0
		case .h3:
			return 20.0
		default:
			return 18.0
		}
	}
	
	var bold: Bool {
		switch self {
		case .h2,.h3:
			return true
		default:
			return false
		}
	}
	
}

struct SubChild: Decodable {
	let children: [TextChild]?
	let direction: String?
	let format: Int?
	let indent: Int?
	let type: String?//paragraph,heading,image,list,tab,post-link,mention
	let version: Int?
	let tag: TagType?

	var bold: Bool {
		if let format = format, format == 1 {
			return true
		}
		return tag?.bold ?? false
	}
	
	
	lazy var attributedString: NSMutableAttributedString = {
		switch self.type {
		case "paragraph":
			return generateParagraphAttributedString(from: self)
		case "heading":
			return generateHeadingAttributedString(from: self)
		case "list":
			return generateListAttributedString(from: self)
		default:
			return NSMutableAttributedString()
		}
	}()
	
	
	enum CodingKeys: String, CodingKey {
		case direction, type, version,format,children,indent,tag
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		direction = try container.decodeIfPresent(String.self, forKey: .direction)
		type = try container.decodeIfPresent(String.self, forKey: .type)
		version = try container.decodeIfPresent(Int.self, forKey: .version)
		indent = try container.decodeIfPresent(Int.self, forKey: .indent)
		children = try container.decodeIfPresent([TextChild].self, forKey: .children)
		tag = try container.decodeIfPresent(TagType.self, forKey: .tag)
		
		//将 format 统一转换为 Int
		if let type = type {
			if type == "text" {
				format = try container.decodeIfPresent(Int.self, forKey: .format)
			} else {
				format = 0
			}
		} else {
			format = 0
		}
	}
}

struct TextChild: Decodable {
	let children: [TextChild]?
	let detail: Int?
	let format: Int?
	let mode: String?
	let style: String?
	let text: String?
	let type: String?
	let version: Int?
	let url: String?
	let src: String?
	
	enum CodingKeys: String, CodingKey {
		case detail, mode, style, text, type, version,format,children,url,src
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		src = try container.decodeIfPresent(String.self, forKey: .src	)
		mode = try container.decodeIfPresent(String.self, forKey: .mode)
		style = try container.decodeIfPresent(String.self, forKey: .style)
		text = try container.decodeIfPresent(String.self, forKey: .text)
		url = try container.decodeIfPresent(String.self, forKey: .url)
		version = try container.decodeIfPresent(Int.self, forKey: .version)
		children = try container.decodeIfPresent([TextChild].self, forKey: .children)
		detail = try container.decodeIfPresent(Int.self, forKey: .detail)
		type = try container.decodeIfPresent(String.self, forKey: .type)

		if let type = type {
			if type == "text" {
				format = try container.decodeIfPresent(Int.self, forKey: .format)
			} else {
				print("type = \(type)")
				format = 0
			}
		} else {
			print("type = \(type)")
			format = 0
		}
	}
}
