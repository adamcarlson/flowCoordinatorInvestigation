//
//  DetailsFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsCoordinatorDelegate: PlaybackRequestDelegate {
    func detailsDidGetRemoved(flowCoordinator: DetailsFlowCoordinator)
}

class DetailsFlowCoordinator: FlowCoordinator {

    let presenter: UIViewController

    let viewModel: DetailsViewModel

    weak var delegate: DetailsCoordinatorDelegate?

    init(presenter: UIViewController, entity: Entity) {
        self.presenter = presenter
        viewModel = DetailsViewModel(model: entity)
    }

    func start() {
        let detailsViewController = DetailsViewController.instantiate()
        detailsViewController.viewModel = viewModel
        detailsViewController.delegate = self
        presenter.show(detailsViewController, sender: self)
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
