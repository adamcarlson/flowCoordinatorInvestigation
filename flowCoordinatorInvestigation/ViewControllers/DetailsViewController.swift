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
}

class DetailsViewController: UIViewController, Instantiable {

    @IBOutlet var pageTitle: UILabel!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var showOptionsButton: UIButton!
    
    var viewModel: DetailsViewModel?
    weak var delegate: DetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        showOptionsButton.isHidden = true

        viewModel?.bind = { [weak self] model in
            self?.showOptionsButton.isHidden = model == nil
            self?.pageTitle.text = self?.viewModel?.title
            self?.subtitle.text = self?.viewModel?.description
            self?.view.backgroundColor = self?.viewModel?.backgroundColor
        }
    }

    @IBAction func showDetails(_ sender: UIButton) {
        guard let model = viewModel?.model else {
            return
        }

        delegate?.optionsSelected(for: model)
    }

}
