//
//  FlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

// Probably a better name for thess...
protocol DismissalDelegate: class {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController)
}

protocol PlaybackRequestDelegate: class {
    func playbackRequested(for entity: Entity)
}
