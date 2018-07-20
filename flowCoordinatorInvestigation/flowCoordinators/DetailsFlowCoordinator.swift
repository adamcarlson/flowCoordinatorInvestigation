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
        let detailsViewModel = DetailsViewModel()
        presenter.viewModel = detailsViewModel
        presenter.delegate = self

        // Simulate network call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            detailsViewModel.model = Entity(name: "Test Details", description: "Test Description", id: UUID(), color: .green)
        }
    }
}

extension DetailsFlowCoordinator: DetailsViewControllerDelegate {
    func optionsSelected(for entity: Entity) {
        let optionsViewController = OptionsViewController()
        optionsViewController.delegate = self
        optionsViewController.modalPresentationStyle = .custom
        optionsViewController.transitioningDelegate = optionsViewController
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
