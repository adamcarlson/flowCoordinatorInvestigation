//
//  FlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

protocol FlowCoordinator {
    associatedtype Delegate = Any
    var delegate: Delegate? { get }
}

extension FlowCoordinator {
    var delegate: Delegate? {
        return nil
    }
}

// Probably a better name for these...
protocol DismissalDelegate: class {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController)
}

protocol PlaybackRequestDelegate: class {
    func playbackRequested(for entity: Entity)
}

extension PlaybackRequestDelegate where Self: FlowCoordinator {
    func playbackRequested(for entity: Entity) {
        if let playbackRequestDelegate = delegate as? PlaybackRequestDelegate {
            playbackRequestDelegate.playbackRequested(for: entity)
        }
    }
}
