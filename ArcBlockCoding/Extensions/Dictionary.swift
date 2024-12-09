//
//
//  Dictionary.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/8.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation

extension Dictionary {
	func toJSONData() throws -> Data {
		return try JSONSerialization.data(withJSONObject: self, options: [])
	}
}
