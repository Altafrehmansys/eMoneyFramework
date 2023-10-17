//
//  UINavigationControllerExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/04/2023.
//

import UIKit

internal extension UINavigationController {

    func popToViewController(ofClass: AnyClass, animated: Bool = true, isReversed:Bool = true) {
        let viewControllers = isReversed ? viewControllers.reversed():viewControllers
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).first {
            popToViewController(vc, animated: animated)
        }
    }

    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
    func removeMiddleViewControllersExceptFirstAndLast() {
        guard let firstVC = viewControllers.first, let lastVC = viewControllers.last else { return }
        self.viewControllers = [firstVC, lastVC]
    }
}
