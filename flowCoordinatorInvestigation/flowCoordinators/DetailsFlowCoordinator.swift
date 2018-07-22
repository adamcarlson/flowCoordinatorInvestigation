//
//  DetailsFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class DetailsFlowCoordinator {

    let presenter: DetailsViewController

    var delegate: DismissalDelegate?

    init(presenter: DetailsViewController) {
        self.presenter = presenter
    }

    func initialize() {
        // Should the flowCoordinator keep a reference to the viewModel?
        let detailsViewModel = DetailsViewModel(model: nil)
        presenter.viewModel = detailsViewModel
        presenter.delegate = self

        detailsViewModel.simulateNetworkCallUsing(entity: Entity(name: "Lord of the Rings", description: "Hobbits and stuff", id: UUID(), color: .green))
    }
}

extension DetailsFlowCoordinator: DetailsViewControllerDelegate {
    func optionsSelected(for entity: Entity) {
        let optionsViewController = OptionsViewController.instantiate()
        optionsViewController.delegate = self
        optionsViewController.viewModel = OptionsViewModel(model: entity)
        presenter.present(optionsViewController , animated: true, completion: nil)
    }
}

extension DetailsFlowCoordinator: DismissalDelegate {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController) {
        if viewController is OptionsViewController {
            presenter.dismiss(animated: true, completion: nil)
        }

        if viewController is DetailsViewController {
            delegate?.viewControllerDidRequestDismissal(viewController)
        }
    }
}
