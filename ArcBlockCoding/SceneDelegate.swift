//
//
//  SceneDelegate.swift
//  ArcBlockCoding
//
//  Created by linleiqin on 2024/12/7.
//  Copyright © 2024 linleiqin. All rights reserved.
	

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: windowScene)
		
		let rootViewController = ViewController()
		let navigationController = BaseNavigationController(rootViewController: rootViewController)
		
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		guard let windowScene = scene as? UIWindowScene else { return }
		
		let traitCollection = windowScene.traitCollection
		if traitCollection.userInterfaceStyle == .dark {
			window?.rootViewController?.view.backgroundColor = ColorUtil.backgroundColor
		} else {
			window?.rootViewController?.view.backgroundColor = ColorUtil.backgroundColor
			
		}
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		guard let windowScene = scene as? UIWindowScene else { return }
		let traitCollection = windowScene.traitCollection
		
		if traitCollection.userInterfaceStyle == .dark {
			window?.rootViewController?.view.backgroundColor = ColorUtil.backgroundColor
		} else {
			window?.rootViewController?.view.backgroundColor = ColorUtil.backgroundColor
		}
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}


}

