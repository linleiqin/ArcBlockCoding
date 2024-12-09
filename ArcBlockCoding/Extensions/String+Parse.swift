//
//
//  String+Parse.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/8.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation

extension String {
	func deCodable<T: Decodable>(type: T.Type) -> T? {
		guard let data = self.data(using: .utf8) else {
			return nil
		}
		return data.deCodable(type: type)
	}
	
	func parseJSON() -> Any? {
		guard let data = self.data(using: .utf8) else {
			print("Invalid string data, could not convert to Data.")
			return nil
		}
		
		do {
			let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
			return jsonObject
		} catch let error as NSError {
			print("Error parsing JSON: \(error.localizedDescription), Code: \(error.code), UserInfo: \(error.userInfo)")
			return nil
		}
	}
}
