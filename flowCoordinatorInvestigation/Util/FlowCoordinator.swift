//
//  FlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

// Probably a better name for this...
protocol DismissalDelegate: class {
    func viewControllerDidRequestDismissal(_ viewController: UIViewController)
}
