//
//  ApplicationCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/23/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: FlowCoordinator {

    let applicationPresenter: ApplicationPresenter
    let window: UIWindow

    var tabBarCoordinator: MainTabBarCoordinator?

    init(window: UIWindow) {
        self.window = window
        applicationPresenter = ApplicationPresenter()
    }

    func start() {
        window.rootViewController = applicationPresenter
        window.makeKeyAndVisible()

        showMainTabBar()
    }

    func showMainTabBar() {
        let tabBar = UITabBarController()
        applicationPresenter.addFullViewChild(child: tabBar)
        tabBarCoordinator = MainTabBarCoordinator(presenter: tabBar)
        tabBarCoordinator?.start()
    }
}
