//
//  OptionsViewController.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class OptionsViewModel {
    private var model: Entity

    var title: String {
        return model.name
    }

    var id: String {
        return model.id.uuidString
    }

    init(model: Entity) {
        self.model = model
    }
}

class OptionsViewController: UIViewController, Instantiable {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var idLabel: UILabel!

    weak var delegate: DismissalDelegate?
    var viewModel: OptionsViewModel?

    let animator = OptionsTransitionAnimator()

    override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get { return self }
        set { }
    }

    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .custom }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        titleLabel.text = viewModel?.title
        idLabel.text = viewModel?.id

        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(dismissGesture)
    }

    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        delegate?.viewControllerDidRequestDismissal(self)
    }
}

extension OptionsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = true
        return animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
}

class OptionsTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let scaleTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    let visualEffectView = UIVisualEffectView()
    var presenting = true

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let optionsView = transitionContext.view(forKey: presenting ? .to : .from) else {
            return
        }

        if presenting {
            containerView.addSubview(visualEffectView)
            visualEffectView.frame = containerView.frame

            containerView.addSubview(optionsView)
            optionsView.frame = CGRect(origin: .zero, size: CGSize(width: 250, height: 250))
            optionsView.center = containerView.center

            optionsView.transform = scaleTransform
            optionsView.alpha = 0.0
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: [.curveEaseIn], animations: {
            if self.presenting {
                optionsView.transform = CGAffineTransform.identity
                optionsView.alpha = 1.0
                self.visualEffectView.effect = UIBlurEffect(style: .dark)
            } else {
                optionsView.transform = self.scaleTransform
                optionsView.alpha = 0.0
                self.visualEffectView.effect = nil
            }
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
