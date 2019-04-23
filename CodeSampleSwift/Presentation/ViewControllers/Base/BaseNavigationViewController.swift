//
//  BaseNavigationViewController.swift
//
//  Copyright © 2017 Jelvix. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        self.delegate = self
        view.isMultipleTouchEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = false
        super.pushViewController(viewController, animated: animated)
    }
}

//MARK: Enable Exclusive touch
extension BaseNavigationViewController {
    func setExclusiveTouchToChildren(of subviews: [UIView]) {
        for view in subviews {
            setExclusiveTouchToChildren(of: view.subviews)
            if let button = view as? UIButton {
                button.isExclusiveTouch = true
            }
        }
    }
}

//MARK: UINavigationControllerDelegate
extension BaseNavigationViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = viewControllers.count != 1
        setExclusiveTouchToChildren(of: view.subviews)
    }
}
