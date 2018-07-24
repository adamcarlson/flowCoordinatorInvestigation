//
//  HomeFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/22/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate: PlaybackRequestDelegate {
    
}

class HomeCoordinator: FlowCoordinator {

    let presenter: UINavigationController
    var coverStoriesCoordinator: CoverStoriesCoordinator?
    var detailsFlowCoordinators: [DetailsFlowCoordinator] = []

    weak var delegate: HomeCoordinatorDelegate?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        coverStoriesCoordinator = CoverStoriesCoordinator(presenter: presenter)
        coverStoriesCoordinator?.delegate = self
        coverStoriesCoordinator?.start()
    }
}

extension HomeCoordinator: CoverStoriesCoordinatorDelegate {
    func showDetails(for entity: Entity) {
        let detailsFlowCoordinator = DetailsFlowCoordinator(presenter: presenter, entity: entity)
        detailsFlowCoordinators.append(detailsFlowCoordinator)
        detailsFlowCoordinator.delegate = self
        detailsFlowCoordinator.start()
    }
}

extension HomeCoordinator: DetailsCoordinatorDelegate {
    func detailsDidGetRemoved(flowCoordinator: DetailsFlowCoordinator) {
        guard let index = detailsFlowCoordinators.index(where: { $0 === flowCoordinator }) else {
            return
        }

        detailsFlowCoordinators.remove(at: index)
    }
}
