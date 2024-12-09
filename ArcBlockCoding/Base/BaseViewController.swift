//
//
//  BaseViewController.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit


public class BaseViewController: UIViewController {

	
	public override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = ColorUtil.backgroundColor

		navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}

	deinit {
		
	}


}

