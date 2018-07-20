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
    var model: Entity? = nil {
        didSet {
            if let model = model {
                bind?(model)
            }
        }
    }

    var bind: ((_ model: Entity) -> Void)? = nil

    init() { }
}

protocol DetailsViewControllerDelegate: class {
    func optionsSelected(for entity: Entity)
}

class DetailsViewController: UIViewController, Instantiable {

    @IBOutlet var pageTitle: UILabel!
    @IBOutlet var subtitle: UILabel!
    
    var viewModel: DetailsViewModel?
    weak var delegate: DetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.bind = { [weak self] model in
            self?.pageTitle.text = model.name
            self?.subtitle.text = model.description
            self?.view.backgroundColor = model.color
        }
    }

    @IBAction func showDetails(_ sender: UIButton) {
        guard let model = viewModel?.model else {
            return
        }

        delegate?.optionsSelected(for: model)
    }

}
