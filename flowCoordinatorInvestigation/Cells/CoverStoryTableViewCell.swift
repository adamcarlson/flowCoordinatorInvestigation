//
//  CoverStoryTableViewCell.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/22/18.
//  Copyright © 2018 adam. All rights reserved.
//

import UIKit

class CoverStoryTableViewCell: UITableViewCell {

    static let identifier = "flowCoordinatorInvestigation.CoverStoryTableViewCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    var model: Entity? {
        didSet {
            titleLabel.text = model?.name
            descriptionLabel.text = model?.description
            backgroundColor = model?.color
        }
    }
}
