//
//
//  Data+Ext.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/8.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation

extension Data {
	
	func deCodable<T: Decodable>(type: T.Type) -> T? {
		let decoder = JSONDecoder()
		do {
			let decodedObject = try decoder.decode(T.self, from: self)
			return decodedObject
		} catch {
			print("Error decoding JSON: \(error)")
			return nil
		}
	}
}
