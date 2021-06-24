//
//  RootTabBarController.swift
//  NewsApiClient
//
//  Created by user on 17/06/2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .gray
        self.viewControllers = [
            createNavigationController(for: NewsFeedViewController(), tabBarItemTitle: nil, title: "Новости", image: #imageLiteral(resourceName: "list"))
        ]
    }
    
    private func createNavigationController(for rootViewController: UIViewController, tabBarItemTitle: String?, title: String?, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = tabBarItemTitle
        navigationVC.tabBarItem.image = image
        navigationVC.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationVC
    }
}
