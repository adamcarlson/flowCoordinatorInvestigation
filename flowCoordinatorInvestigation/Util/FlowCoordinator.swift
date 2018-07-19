//
//  FlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation

enum FlowCoordinatorData {
    case signIn
    case mainTabBar
    case play(String)
    case details(String)
    case search
}

protocol FlowCoordinator: class {
    var parent: FlowCoordinator? { get set }

    func navigateUsing(data: FlowCoordinatorData)
}
