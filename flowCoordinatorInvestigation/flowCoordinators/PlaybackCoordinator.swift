//
//  PlaybackCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation

class PlaybackCoordinator: FlowCoordinator {

    let presenter: PlaybackCoordinator

    weak var parent: FlowCoordinator?

    init(presenter: PlaybackPresenter) {
        self.presenter = presenter
    }

    func navigateUsing(data: FlowCoordinatorData) {

    }
}
