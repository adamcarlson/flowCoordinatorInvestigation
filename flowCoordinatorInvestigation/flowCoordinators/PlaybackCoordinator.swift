//
//  PlaybackCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/23/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class PlaybackCoordinator {

    let presenter: UIViewController

    var playbackViewModel: PlaybackViewModel?

    init(presenter: UIViewController) {
        self.presenter = presenter
    }

    func start(with entity: Entity) {
        let playbackViewController = PlaybackViewController.instantiate()
        playbackViewModel = PlaybackViewModel(entity: entity)
        playbackViewController.viewModel = playbackViewModel
        playbackViewController.delegate = self
        presenter.present(playbackViewController, animated: true, completion: nil)
    }
}

extension PlaybackCoordinator: PlaybackViewControllerDelegate {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController) {
        presenter.dismiss(animated: true, completion: nil)
    }
}
