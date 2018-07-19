//
//  UIView+Extensions.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/18/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addFullViewSubView(_ view: UIView, constrainsToSafeArea: Bool = true) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        if constrainsToSafeArea {
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        } else {
            view.topAnchor.constraint(equalTo: topAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        }
    }
}
