//
//  HomeFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/22/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

protocol HomeFlowCoordinatorDelegate: class {

}

class HomeFlowCoordinator {

    let presenter: UINavigationController

    weak var delegate: HomeFlowCoordinatorDelegate?

    var detailsFlowCoordinator: DetailsFlowCoordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func initialize() {
        let coverStoriesViewModel = CoverStoriesViewModel(entities: [])
        let coverStoriesViewController = CoverStoriesViewController.instantiate()
        coverStoriesViewController.viewModel = coverStoriesViewModel
        coverStoriesViewController.delegate = self

        presenter.setViewControllers([coverStoriesViewController], animated: false)
        coverStoriesViewModel.simulateNetworkCallToPullEntities()
    }
}

extension HomeFlowCoordinator: CoverStoriesViewControllerDelegate {
    func coverStorySelected(entity: Entity) {
        let detailsViewController = DetailsViewController.instantiate()
        detailsFlowCoordinator = DetailsFlowCoordinator(presenter: detailsViewController)
        detailsFlowCoordinator?.delegate = self
        detailsFlowCoordinator?.initialize(with: entity)
        presenter.pushViewController(detailsViewController, animated: true)
    }
}

extension HomeFlowCoordinator: DetailsFlowCoordinatorDelegate {
    func detailsDidGetRemoved(flowCoordinator: DetailsFlowCoordinator) {
        detailsFlowCoordinator = nil
    }
}
