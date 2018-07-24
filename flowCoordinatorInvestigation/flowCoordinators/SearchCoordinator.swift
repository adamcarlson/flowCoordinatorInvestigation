//
//  SearchCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/23/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class SearchCoordinator: FlowCoordinator {

    let presenter: UIViewController

    weak var delegate: PlaybackRequestDelegate?

    init(presenter: UIViewController) {
        self.presenter = presenter
    }

    func start() {
        let searchViewController = SearchViewController.instantiate()
        presenter.show(searchViewController, sender: self)
    }
}
