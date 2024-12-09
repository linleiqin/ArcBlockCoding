//
//
//  ViewController.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit

class ViewController: BaseViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		if Endpoints.baseURL.isEmpty {
			let hint = UILabel(frame: CGRect(x: 0, y: 100, width: LayoutUtil.screenWidth, height: 100))
			hint.textColor = ColorUtil.textColor
			hint.numberOfLines = 0
			hint.textAlignment = .center
			hint.text = "- 在项目的 `Info.plist` 文件中添加一个名为 `BASE_URL` 的字符串值\n`BASE_URL`值为 `https://www.xxxxxxxx.io`"
			view.addSubview(hint)
		} else {
			let entryBtn = UIButton(frame: CGRect(x: (LayoutUtil.screenWidth - 100) / 2, y: (view.height - 88 - 100) / 2, width: 100, height: 100));
			entryBtn.layer.cornerRadius = 10;
			entryBtn.backgroundColor = .yellow;
			entryBtn.setTitleColor(.black, for: .normal);
			entryBtn.setTitle("Enter", for: .normal)
			entryBtn.addAction(UIAction { _ in
				self.entryBtnClicked()
			}, for: .touchUpInside)
			self.view.addSubview(entryBtn);
		}

		


		
	}


	func entryBtnClicked() {
		let vc = BlogListViewController();
		self.navigationController?.pushViewController(vc, animated: true)
	}

	

}

