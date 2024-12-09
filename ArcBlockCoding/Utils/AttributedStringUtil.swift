//
//
//  Attfun.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/9.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import Foundation
import UIKit

func generateParagraphAttributedString(from subChild: SubChild) -> NSMutableAttributedString {
	if let subChildren = subChild.children ,subChildren.count > 0 {
		let fontSize = 18.0
		// 创建一个可变的富文本字符串
		let paragraphAttributedText = NSMutableAttributedString()
		for subChild in subChildren {
			let font = subChild.format == 0 ? UIFont.systemFont(ofSize: fontSize) : UIFont.boldSystemFont(ofSize: fontSize)
			let paragraphAttributes: [NSAttributedString.Key: Any] = [
				.foregroundColor: ColorUtil.textColor,
				.font: font
			]
			
			switch subChild.type {
			case "text":
				if let subText = subChild.text {
					paragraphAttributedText.append(NSAttributedString(string: subText, attributes: paragraphAttributes))
				}
			case "link":
				let linkAtt = generateLinkAttributedString(from: subChild);
				linkAtt.addAttributes(paragraphAttributes, range: NSRange(location: 0, length: linkAtt.length))
				paragraphAttributedText.append(linkAtt)
			case "image":
				paragraphAttributedText.append(generateImageAttributedString(from: subChild))
			default:
				paragraphAttributedText.append(NSAttributedString(string:""))
			}

		}
		paragraphAttributedText.append(NSAttributedString(string: "\n\n"))
		return paragraphAttributedText
	}
	return NSMutableAttributedString()
}

func generateLinkAttributedString(from child: TextChild) -> NSMutableAttributedString {
	if let linkText = child.children?.first?.text,
	   let url = child.url {
		let linkAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
		return NSMutableAttributedString(string: "\(linkText)", attributes: linkAttributes)
	}
	return NSMutableAttributedString()
}

func generateImageAttributedString(from subChild: TextChild) -> NSMutableAttributedString {
	let attributedString = NSMutableAttributedString()
	if let src = subChild.src {
		// 加载图片
		let attachment = NetworkImageAttachment(imageURL: src)
		attachment.loadImage()
		
		let imageAttributedString = NSAttributedString(attachment: attachment)
		attributedString.append(imageAttributedString)
		attributedString.append(NSAttributedString(string: "\n"))
	}
	return attributedString
}

func generateHeadingAttributedString(from subChild: SubChild) -> NSMutableAttributedString {
	var fontSize = 18.0
	if let tag = subChild.tag {
		fontSize = tag.fontSize
	}
	
	if let subChildren = subChild.children ,subChildren.count > 0 {
		let paragraphAttributedText = NSMutableAttributedString()
		for textChild in subChildren {
			let font = subChild.bold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
			let kern = subChild.bold ? 0.5 : 0.0
			let paragraphAttributes: [NSAttributedString.Key: Any] = [
				.foregroundColor: ColorUtil.textColor,
				.font: font,
			]

			switch textChild.type {
			case "text":
				if let subText = textChild.text {
					paragraphAttributedText.append(NSAttributedString(string: subText, attributes: paragraphAttributes))
				}
			default:
				paragraphAttributedText.append(NSAttributedString(string:""))
			}

		}
		paragraphAttributedText.append(NSAttributedString(string: "\n\n")) // 每个文本后添加换行符
		return paragraphAttributedText
		
	}
	return NSMutableAttributedString()
}

func generateListAttributedString(from subChild: SubChild) -> NSMutableAttributedString {
	var fontSize = 18.0
	if let tag = subChild.tag {
		fontSize = tag.fontSize
	}
	if let subChildren = subChild.children ,subChildren.count > 0 {
		
		let paragraphAttributedText = NSMutableAttributedString()
		for textChild in subChildren {
			if  let childrenInTextChild = textChild.children,childrenInTextChild.count>0 {
				paragraphAttributedText.append(generateTextChildrenAttributedString(from: childrenInTextChild, tag: subChild.tag,type: textChild.type))
			} else {
				let font = subChild.bold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
				let paragraphAttributes: [NSAttributedString.Key: Any] = [
					.foregroundColor: ColorUtil.textColor,
					.font: font
				]
				switch textChild.type {
				case "text":
					if let subText = textChild.text {
						paragraphAttributedText.append(NSAttributedString(string: subText, attributes: paragraphAttributes))
					}
				default:
					paragraphAttributedText.append(NSAttributedString(string:""))
				}
			}
		}
		paragraphAttributedText.append(NSAttributedString(string: "\n\n")) // 每个文本后添加换行符
		return paragraphAttributedText
		
	}
	return NSMutableAttributedString()
}

func generateTextChildrenAttributedString(from children: [TextChild],tag:TagType? ,type:String?) -> NSMutableAttributedString {
	let fontSize = tag?.fontSize ?? 18.0
	let paragraphAttributedText = NSMutableAttributedString()
	for textChild in children {
		if  let childrenInTextChild = textChild.children,childrenInTextChild.count>0 {
			paragraphAttributedText.append(generateTextChildrenAttributedString(from: childrenInTextChild, tag: tag,type: type))
		} else {
			let blod = tag?.fontSize
			let font = (blod != nil) ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
			let paragraphAttributes: [NSAttributedString.Key: Any] = [
				.foregroundColor: ColorUtil.textColor,
				.font: font
			]

			switch textChild.type {
			case "text":
				if var subText = textChild.text {
					if type == type,type == "listitem" {
						subText = "  •  " + subText
					}
					paragraphAttributedText.append(NSAttributedString(string: subText, attributes: paragraphAttributes))
				}
			default:
				paragraphAttributedText.append(NSAttributedString(string:""))
			}
		}
	}
	paragraphAttributedText.append(NSAttributedString(string: "\n\n"))
	return paragraphAttributedText
}
