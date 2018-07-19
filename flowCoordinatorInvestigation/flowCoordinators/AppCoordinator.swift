//
//  AppCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation

class AppCoordinator: FlowCoordinator {

    let presenter: AppPresenter

    var signInCoordinator: FlowCoordinator?
    var mainTabBarCoordinator: FlowCoordinator?
    var playbackCoordinator: FlowCoordinator?

    weak var parent: FlowCoordinator?

    init(presenter: AppPresenter) {
        self.presenter = presenter
    }

    func navigateUsing(data: FlowCoordinatorData) {
        switch data {
        case .signIn:
            let signInPresenter = SignInPresenter()
            signInCoordinator = SignInFlowCoordinator(presenter: signInPresenter)
            signInCoordinator?.parent = self
            presenter.presentSignIn(signInPresenter: signInPresenter)
        case .mainTabBar:
            initializeAndPresentMainTabBar(completion: nil)
        case .play, .details, .search:
            guard let mainTabBarCoordinator = mainTabBarCoordinator else {
                initializeAndPresentMainTabBar { mainTabBarCoordinator in
                    mainTabBarCoordinator.navigateUsing(data: data)
                }
                return
            }
            mainTabBarCoordinator.navigateUsing(data: data)
        }
    }

    private func initializeAndPresentMainTabBar(completion: ((FlowCoordinator) -> Void)?) {
        let mainTabBarPresenter = MainTabBarPresenter()
        mainTabBarCoordinator = MainTabBarCoordinator(presenter: mainTabBarPresenter)
        mainTabBarCoordinator?.parent = self
        presenter.presentMainTabBar(mainTabBarPresenter: mainTabBarPresenter, completion: completion)
    }
}
