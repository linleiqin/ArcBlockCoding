//
//
//  NetworkImageAttachment.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/9.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit

class NetworkImageAttachment: NSTextAttachment {
	
	private let placeholderImage: UIImage = UIImage(named: "Logo")!
	private var imageURL: String?
	
	var onImageLoaded: ((UIImage?) -> Void)?
	
	init(imageURL: String?) {
		self.imageURL = imageURL
		super.init(data: nil, ofType: nil)
		
		self.image = placeholderImage
		let maxWidth = LayoutUtil.screenWidth - 32;
		let ratio = maxWidth / (placeholderImage.size.width)
		self.bounds = CGRect(x: 16, y: 0, width: maxWidth, height: placeholderImage.size.height * ratio)

	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func loadImage() {
		guard let urlString = imageURL else { return }
		
		ImageService.shared.loadImageUrl(urlString: urlString) { [weak self] image, error in
			guard let self = self else { return }

			if let image = image {
				self.image = image
				let maxWidth = LayoutUtil.screenWidth - 32;
				let ratio = maxWidth / (image.size.width)
				self.bounds = CGRect(x: 16, y: 0, width: maxWidth, height: image.size.height * ratio)
				
				self.onImageLoaded?(image)
			} else {
				self.image = self.placeholderImage
			}
		}
	}
}
