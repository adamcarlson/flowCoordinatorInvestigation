//
//  OptionsViewController.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

class OptionsViewController: UIViewController {

    weak var delegate: DismissalDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(dismissGesture)
    }

    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        delegate?.viewControllerDidRequestDismissal(self)
    }
}

extension OptionsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissalAnimator()
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class PresentationController: UIPresentationController {
    override var shouldPresentInFullscreen: Bool {
        return false
    }
}

class PresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        transitionContext.containerView.translatesAutoresizingMaskIntoConstraints = false
        transitionContext.containerView.addSubview(toView)
        toView.centerXAnchor.constraint(equalTo: transitionContext.containerView.centerXAnchor)
        toView.centerYAnchor.constraint(equalTo: transitionContext.containerView.centerYAnchor)
        toView.widthAnchor.constraint(equalToConstant: 260)
        toView.heightAnchor.constraint(equalToConstant: 260)

        toView.alpha = 0

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseInOut], animations: {
            transitionContext.containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            toView.alpha = 1
            toView.widthAnchor.constraint(equalToConstant: 250)
            toView.heightAnchor.constraint(equalToConstant: 250)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class DismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseInOut], animations: {
            transitionContext.containerView.backgroundColor = .clear
            fromView.alpha = 0
            fromView.widthAnchor.constraint(equalToConstant: 260)
            fromView.heightAnchor.constraint(equalToConstant: 260)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
