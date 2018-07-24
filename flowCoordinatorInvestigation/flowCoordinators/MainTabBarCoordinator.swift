//
//  MainTabBarFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/22/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarCoordinator: FlowCoordinator {

    let presenter: UITabBarController

    var homeCoordinator: HomeCoordinator?
    var searchCoordinator: SearchCoordinator?
    var playbackCoordinator: PlaybackCoordinator?

    init(presenter: UITabBarController) {
        self.presenter = presenter

        presenter.viewControllers = [
            constructHome(),
            constructSearch()
        ]
    }

    func start() {
        homeCoordinator?.start()
        searchCoordinator?.start()
    }

    func constructHome() -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        homeCoordinator = HomeCoordinator(presenter: navigationController)
        homeCoordinator?.delegate = self
        return navigationController
    }

    func constructSearch() -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchCoordinator = SearchCoordinator(presenter: navigationController)
        searchCoordinator?.delegate = self
        return navigationController
    }
}

extension MainTabBarCoordinator: PlaybackRequestDelegate {
    func playbackRequested(for entity: Entity) {
        playbackCoordinator = PlaybackCoordinator(presenter: presenter)
        playbackCoordinator?.delegate = self
        playbackCoordinator?.start(with: entity)
    }
}

extension MainTabBarCoordinator: DismissalDelegate {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController) {
        presenter.dismiss(animated: true, completion: nil)
    }
}

extension MainTabBarCoordinator: ShowDetailsDelegate {
    func showDetails(for entity: Entity) {
        homeCoordinator?.showDetails(for: entity)
        presenter.selectedIndex = 0
        if playbackCoordinator != nil {
            presenter.dismiss(animated: true, completion: nil)
            playbackCoordinator = nil
        }
    }
}
