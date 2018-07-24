//
//  CoverStoriesFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/23/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

protocol CoverStoriesCoordinatorDelegate: PlaybackRequestDelegate {
    func showDetails(for entity: Entity)
}

class CoverStoriesCoordinator: FlowCoordinator {

    let presenter: UIViewController

    let viewModel: CoverStoriesViewModel

    weak var delegate: CoverStoriesCoordinatorDelegate?

    init(presenter: UIViewController) {
        self.presenter = presenter
        viewModel = CoverStoriesViewModel(entities: [])
        viewModel.simulateNetworkCallToPullEntities()
    }

    func start() {
        let coverStoriesViewController = CoverStoriesViewController.instantiate()
        coverStoriesViewController.viewModel = viewModel
        coverStoriesViewController.delegate = self
        presenter.show(coverStoriesViewController, sender: self)
    }
}

extension CoverStoriesCoordinator: CoverStoriesViewControllerDelegate {
    func coverStorySelected(entity: Entity) {
        delegate?.showDetails(for: entity)
    }
}
