//
//  UIApplicationExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/03/2023.
//

import Foundation
import UIKit

extension UIApplication {
    class func isFirstLaunchAfterUpdate() -> Bool {
        let existingVersion = UserDefaults.standard.object(forKey: "CurrentVersionNumber") as? String
        let appVersionNumber = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.releaseVersionNumber ?? ""

        if existingVersion != appVersionNumber {
            UserDefaults.standard.set(appVersionNumber, forKey: "CurrentVersionNumber")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
