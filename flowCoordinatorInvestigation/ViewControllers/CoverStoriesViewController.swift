//
//  CoverStoriesViewController.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/22/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class CoverStoriesViewModel {
    var entities: [Entity] {
        didSet {
            bind?(entities)
        }
    }

    var bind: ((_ entities: [Entity]) -> Void)?

    init(entities: [Entity] = []) {
        self.entities = []
    }

    func simulateNetworkCallToPullEntities() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.entities = Entity.generateTestEntities()
        }
    }
}

protocol CoverStoriesViewControllerDelegate: PlaybackRequestDelegate {
    func coverStorySelected(entity: Entity)
}

class CoverStoriesViewController: UIViewController, Instantiable {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    weak var delegate: CoverStoriesViewControllerDelegate?

    var viewModel: CoverStoriesViewModel? {
        didSet {
            viewModel?.bind = { [weak self] _ in
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
                self?.activityIndicatorView.stopAnimating()
                self?.activityIndicatorView.isHidden = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CoverStoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CoverStoryTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self

        title = "Cover Stories"

        if viewModel?.entities.count ?? 0 == 0 {
            tableView.isHidden = true
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.isHidden = true
        }
    }
}

extension CoverStoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.entities.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoverStoryTableViewCell.identifier, for: indexPath) as! CoverStoryTableViewCell
        cell.model = viewModel?.entities[indexPath.row]
        cell.delegate = delegate
        return cell
    }
}

extension CoverStoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let entity = viewModel?.entities[indexPath.row] else {
            return
        }

        delegate?.coverStorySelected(entity: entity)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
