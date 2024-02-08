//
//  TabBarController.swift
//  lesson09
//
//  Created by Кирилл Арефьев on 01.09.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		setupTabBar()
    }
	
	private func setupItemTabBar(view: UIViewController, name: String, systemImageName: String, selectedImageName: String) -> UINavigationController {
		let item = UINavigationController(rootViewController: view)
		item.tabBarItem.title = name
		item.tabBarItem.image = UIImage(systemName: systemImageName)
		item.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
		
		return item
	}
	
	private func setupTabBar() {
		let news = setupItemTabBar(view: ViewController(), name: "News", systemImageName: "newspaper", selectedImageName: "newspaper.fill")
		let saves = setupItemTabBar(view: SavedNewsViewController(), name: "My saves", systemImageName: "heart", selectedImageName: "heart.fill")
		self.setViewControllers([news, saves], animated: false)
		
		tabBar.backgroundColor = .black
		tabBar.tintColor = .white
		tabBar.barTintColor = .black
		tabBar.isTranslucent = false

	}

}
