//
//  ApplicationPresenter.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/23/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class ApplicationPresenter: UIViewController {
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return childViewControllers.last
    }
}
