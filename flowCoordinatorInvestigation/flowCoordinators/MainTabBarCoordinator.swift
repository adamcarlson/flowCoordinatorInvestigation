//
//  MainTabBarCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation

class MainTabBarCoordinator: FlowCoordinator {

    let presenter: MainTabBarPresenter

    weak var parent: FlowCoordinator?

    init(presenter: MainTabBarPresenter) {
        self.presenter = presenter
    }

    func navigateUsing(data: FlowCoordinatorData) {

    }
}
