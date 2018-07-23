//
//  MainTabBarFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/22/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarFlowCoordinator {

    let presenter: UITabBarController

    var homeFlowCoordinator: HomeFlowCoordinator?

    init(presenter: UITabBarController) {
        self.presenter = presenter
    }

    func initialize() {
        let navigationController = UINavigationController()
        homeFlowCoordinator = HomeFlowCoordinator(presenter: navigationController)
        homeFlowCoordinator?.delegate = self
        homeFlowCoordinator?.initialize()

        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)

        presenter.viewControllers = [navigationController]
    }
}

extension MainTabBarFlowCoordinator: PlaybackRequestDelegate {
    func playbackRequested(for entity: Entity) {
        let playbackViewController = PlaybackViewController.instantiate()
        playbackViewController.viewModel = PlaybackViewModel(entity: entity)
        playbackViewController.delegate = self
        presenter.present(playbackViewController, animated: true, completion: nil)
    }
}

extension MainTabBarFlowCoordinator: DismissalDelegate {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController) {
        presenter.dismiss(animated: true, completion: nil)
    }
}

extension MainTabBarFlowCoordinator: PlaybackViewControllerDelegate, HomeFlowCoordinatorDelegate { }
