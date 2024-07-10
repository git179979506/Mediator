//
//  TabBarController.swift
//  Mediator_Example
//
//  Created by zhaoshouwen on 2024/7/4.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Home
import Portfolio

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        homeVC.navigationItem.title = "首页"
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem.title = "首页"
        
        let portfolioVC = PortfolioListViewController()
        portfolioVC.navigationItem.title = "自选"
        let portfolioNav = UINavigationController(rootViewController: portfolioVC)
        portfolioNav.tabBarItem.title = "自选"
        
        viewControllers = [homeNav, portfolioNav]
    }
}
