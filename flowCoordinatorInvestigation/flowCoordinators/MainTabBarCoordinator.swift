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

    var homeFlowCoordinator: HomeCoordinator?
    var playbackCoordinator: PlaybackCoordinator?

    init(presenter: UITabBarController) {
        self.presenter = presenter

        presenter.viewControllers = [
            constructHome()
        ]
    }

    func start() {
        homeFlowCoordinator?.start()
    }

    func constructHome() -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        homeFlowCoordinator = HomeCoordinator(presenter: navigationController)
        homeFlowCoordinator?.delegate = self
        return navigationController
    }
}

extension MainTabBarCoordinator: PlaybackRequestDelegate {
    func playbackRequested(for entity: Entity) {
        playbackCoordinator = PlaybackCoordinator(presenter: presenter)
        playbackCoordinator?.start(with: entity)
    }
}

extension MainTabBarCoordinator: DismissalDelegate {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController) {
        presenter.dismiss(animated: true, completion: nil)
    }
}

extension MainTabBarCoordinator: PlaybackViewControllerDelegate, HomeCoordinatorDelegate { }
