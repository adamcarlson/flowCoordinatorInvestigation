//
//  DetailsFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsFlowCoordinatorDelegate: PlaybackRequestDelegate {
    func detailsDidGetRemoved(flowCoordinator: DetailsFlowCoordinator)
}

class DetailsFlowCoordinator {

    let presenter: DetailsViewController

    weak var delegate: DetailsFlowCoordinatorDelegate?

    init(presenter: DetailsViewController) {
        self.presenter = presenter
    }

    func initialize(with entity: Entity) {
        // Should the flowCoordinator keep a reference to the viewModel?
        let detailsViewModel = DetailsViewModel(model: entity)
        presenter.viewModel = detailsViewModel
        presenter.delegate = self
    }
}

extension DetailsFlowCoordinator: DetailsViewControllerDelegate {
    func optionsSelected(for entity: Entity) {
        let optionsViewController = OptionsViewController.instantiate()
        optionsViewController.delegate = self
        optionsViewController.viewModel = OptionsViewModel(model: entity)
        presenter.present(optionsViewController , animated: true, completion: nil)
    }

    func detailsViewControllerDidGetRemoved(_ viewController: DetailsViewController) {
        delegate?.detailsDidGetRemoved(flowCoordinator: self)
    }
}

extension DetailsFlowCoordinator: DismissalDelegate {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController) {
        if viewController is OptionsViewController {
            presenter.dismiss(animated: true, completion: nil)
        }
    }
}

extension DetailsFlowCoordinator: PlaybackRequestDelegate {
    func playbackRequested(for entity: Entity) {
        delegate?.playbackRequested(for: entity)
    }
}
