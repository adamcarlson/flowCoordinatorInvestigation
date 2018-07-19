//
//  SignInFlowCoordinator.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class SignInFlowCoordinator: FlowCoordinator {

    let presenter: SignInPresenter

    weak var parent: FlowCoordinator?

    init(presenter: SignInPresenter) {
        self.presenter = presenter
    }

    func navigateUsing(data: FlowCoordinatorData) {
        
    }
}
