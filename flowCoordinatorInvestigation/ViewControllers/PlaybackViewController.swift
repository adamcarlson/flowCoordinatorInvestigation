//
//  PlaybackViewController.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class PlaybackViewModel {
    var model: Entity {
        didSet {
            bind?()
        }
    }
    let otherEntities: [Entity]

    var title: String {
        return model.name
    }

    var id: String {
        return model.id.uuidString
    }

    var color: UIColor {
        return model.color
    }

    var bind: (() -> Void)?

    init(entity: Entity, otherEntities: [Entity]) {
        self.model = entity
        self.otherEntities = otherEntities
    }
}

class PlaybackViewController: UIViewController, Instantiable {

    let thresholdForDismissal: CGFloat = 0.3
    private let interactor: Interactor = Interactor()
    
    @IBOutlet var playbackScreen: UIView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nowPlayingLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    weak var delegate: (DismissalDelegate & PlaybackRequestDelegate & ShowDetailsDelegate)?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var modalPresentationCapturesStatusBarAppearance: Bool {
        get { return !interactor.hasStarted }
        set { }
    }

    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .overCurrentContext }
        set { }
    }

    override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get { return self }
        set { }
    }

    var viewModel: PlaybackViewModel? {
        didSet {
            viewModel?.bind = { [weak self] in
                self?.setup()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
        playbackScreen.addGestureRecognizer(panGesture)

        let nib = UINib(nibName: "PlaybackTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PlaybackTableViewCell.identifier)

        tableView.dataSource = self
        tableView.delegate = self

        setup()
    }

    func setup() {
        playbackScreen.backgroundColor = viewModel?.color
        idLabel.text = viewModel?.id
        nowPlayingLabel.text = viewModel?.title
    }

    @objc final func handleDismiss(sender: UIPanGestureRecognizer) {
        guard let view = view else {
            interactor.cancel()
            return
        }

        let translation = sender.translation(in: view)
        let downwardProgress = min(max(translation.y / view.bounds.height, 0), 1)

        switch sender.state {
        case .began:
            interactor.hasStarted = true
            delegate?.viewControllerDidRequestDismissal(self)
            // This fixes a bug with AnimatedTransitioning where if an update is not recived quickly enough
            // the interactor will begin its completon animation and cause the dismissing view to visually jump.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) { [weak self] in
                self?.interactor.update(downwardProgress)
            }
        case .changed:
            interactor.shouldFinish = downwardProgress > thresholdForDismissal
            interactor.update(downwardProgress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            // Tell the interactor to finish if the user is swiping down or has passed the threshold and is not swiping up.
            if (interactor.shouldFinish && sender.velocity(in: view).y > -25) || sender.velocity(in: view).y > 600 {
                interactor.finish()
            } else {
                interactor.cancel()
            }
        default:
            break
        }
    }
}

extension PlaybackViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.otherEntities.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaybackTableViewCell.identifier, for: indexPath) as! PlaybackTableViewCell
        cell.model = viewModel?.otherEntities[indexPath.row]
        cell.delegate = delegate
        return cell
    }
}

extension PlaybackViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.0
    }
}

extension PlaybackViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeDownToDismissAnimator()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

private final class Interactor: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false

    override var completionCurve: UIViewAnimationCurve {
        get { return .easeInOut }
        set { }
    }
}

private final class SwipeDownToDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            return
        }

        let screenBounds = fromVC.view.window?.bounds ?? UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: [.curveLinear], animations: {
            fromVC.view.frame = finalFrame
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
