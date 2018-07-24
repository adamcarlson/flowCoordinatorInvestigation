//
//  PlaybackTableViewCell.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/23/18.
//  Copyright © 2018 adam. All rights reserved.
//

import UIKit

class PlaybackTableViewCell: UITableViewCell {

    static let identifier = "flowCoordinatorInvestigation.PlaybackTableViewCell"

    @IBOutlet var titleLabel: UILabel!

    weak var delegate: (PlaybackRequestDelegate & ShowDetailsDelegate)?

    var model: Entity? {
        didSet {
            titleLabel.text = model?.name
            backgroundColor = model?.color
        }
    }

    @IBAction func playButton(_ sender: UIButton) {
        if let entity = model {
            delegate?.playbackRequested(for: entity)
        }
    }

    @IBAction func detailsButton(_ sender: UIButton) {
        if let entity = model {
            delegate?.showDetails(for: entity)
        }
    }
}
