//
//  DetailsViewController.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewModel {
    private(set) var model: Entity? {
        didSet {
            bind?(model)
        }
    }

    var title: String? {
        return model?.name
    }

    var description: String? {
        return model?.description
    }

    var backgroundColor: UIColor? {
        return model?.color
    }

    var bind: ((_ model: Entity?) -> Void)? = nil

    init(model: Entity?) {
        self.model = model
    }

    func simulateNetworkCallUsing(entity: Entity) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.model = entity
        }
    }
}

protocol DetailsViewControllerDelegate: class {
    func optionsSelected(for entity: Entity)
    func detailsViewControllerDidGetRemoved(_ viewController: DetailsViewController)
}

class DetailsViewController: UIViewController, Instantiable {

    @IBOutlet var pageTitle: UILabel!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var showOptionsButton: UIButton!

    weak var delegate: DetailsViewControllerDelegate?

    var viewModel: DetailsViewModel? {
        didSet {
            viewModel?.bind = { [weak self] _ in
                self?.updateView()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()

        title = "Details"
    }

    private func updateView() {
        showOptionsButton.isHidden = viewModel?.model == nil
        pageTitle.text = viewModel?.title
        subtitle.text = viewModel?.description
        view.backgroundColor = viewModel?.backgroundColor
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if parent == nil {
            delegate?.detailsViewControllerDidGetRemoved(self)
        }
    }

    @IBAction func showDetails(_ sender: UIButton) {
        guard let model = viewModel?.model else {
            return
        }

        delegate?.optionsSelected(for: model)
    }

}
