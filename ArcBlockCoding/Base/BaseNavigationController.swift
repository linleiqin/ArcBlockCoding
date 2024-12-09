//
//
//  BaseNavigationController.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit
import SVGKit
class BaseNavigationController: UINavigationController {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationBar.barTintColor = ColorUtil.backgroundColor
		self.navigationBar.isTranslucent = false

		let backButtonImage = SVGKImage(named: "icon_general_leftarrow").uiImage
		
		let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
		backButton.tintColor = ColorUtil.textColor

		self.navigationItem.leftBarButtonItem = backButton
		
	}

	@objc func backButtonTapped() {
		navigationController?.popViewController(animated: true)
	}
}

