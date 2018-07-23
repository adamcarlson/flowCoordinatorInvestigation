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

    weak var delegate: PlaybackRequestDelegate?

    var model: Entity? {
        didSet {
            titleLabel.text = model?.name
            descriptionLabel.text = model?.description
            backgroundColor = model?.color
        }
    }

    @IBAction func playCoverStory(_ sender: UIButton) {
        guard let model = model else {
            return
        }
        
        delegate?.playbackRequested(for: model)
    }
}
