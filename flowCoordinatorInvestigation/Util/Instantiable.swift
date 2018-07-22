//
//  Instantiable.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

protocol Instantiable { }

extension Instantiable where Self: UIViewController {
    static func instantiate() -> Self {
        let name = String(describing: self)
        let controller = ViewControllers(rawValue: name)!
        return controller.instantiate() as! Self
    }
}

enum ViewControllers: String {
    case details = "DetailsViewController"
    case player = "PlayerViewController"
    case options = "OptionsViewController"

    var storyboard: UIStoryboard {
        var name = self.rawValue
        name.removeLast("ViewController".count)
        return UIStoryboard(name: name, bundle: nil)
    }

    func instantiate() -> UIViewController {
        return storyboard.instantiateInitialViewController()!
    }
}
