
//  e&money
//
//  Created by Shujaat Ali Khan on 13/03/2023.
//

import UIKit

// MARK: Localizable
public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    public var localized: String {
        return LocaleManager.shared.getString(key: self)
    }
}
/*
// MARK: XIBLocalizable
public protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
}

extension UINavigationItem: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}

extension UIBarItem: XIBLocalizable { // Localizes UIBarButtonItem and UITabBarItem
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}

// MARK: Special protocol to localizaze UITextField's placeholder
public protocol UITextFieldXIBLocalizable {
    var xibPlaceholderLocKey: String? { get set }
}

extension UITextField: UITextFieldXIBLocalizable {
    @IBInspectable public var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}
 */

// MARK: Special protocol to localize multiple texts in the same control
//public protocol XIBMultiLocalizable {
//    var xibLocKeys: String? { get set }
//}
//
//extension UISegmentedControl: XIBMultiLocalizable {
//    @IBInspectable public var xibLocKeys: String? {
//        get { return nil }
//        set(keys) {
//            guard let keys = keys?.components(separatedBy: ","), !keys.isEmpty else { return }
//            for (index, title) in keys.enumerated() {
//                setTitle(title.localized, forSegmentAt: index)
//            }
//        }
//    }
//}

extension UILabel {
    @objc public func cstmlayoutSubviews() {
        
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            print("Handle special case with uitextfields")
            return // handle special case with uitextfields
        }
        if self.textAlignment == .center {
            return
        }
        
        if LocaleManager.isRTLLanguage()  {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
    }
}
