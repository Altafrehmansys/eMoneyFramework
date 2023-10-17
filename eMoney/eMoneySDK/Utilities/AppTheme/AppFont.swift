//
//  AppFont.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 15/03/2023.
//

import Foundation
import UIKit

public enum FontName: String {
    case Regular = "SuisseIntl"
    case SemiBold = "SuisseIntl-SemiBold"
    case Medium = "SuisseIntl-Medium"
    case Light = "SuisseIntl-Light"
}

public enum FontSize: CGFloat {
    /// Size value is 10
    case body5 = 10
    /// Size value is 12
    case body4 = 12
    /// Size value is 14
    case body3 = 14
    /// Size value is 16
    case body2 = 16
    /// Size value is 18
    case body1 = 18
    
    /// Size value is 20
    case h7 = 20
    /// Size value is 24
    case h6 = 24
    /// Size value is 28
    case h5,h4 = 28
    /// Size value is 36
    case h3 = 36
    /// Size value is 42
    case h2 = 42
    /// Size value is 48
    case h1 = 48
}

public struct AppFont {
    @available(*, unavailable) private init() {}
    
    public static func font(name: FontName, size: FontSize) -> UIFont{
        if let font = UIFont(name: name.rawValue, size: size.rawValue) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size.rawValue)
        }
    }
    
    public static func appRegular(size: FontSize) -> UIFont {
        if let _ = SDKColors.shared.receivedTheme?.buttonFont {
            return UIFont.systemFont(ofSize: size.rawValue, weight: .regular)
        } else {
            return AppFont.font(name: .Regular, size: size)
        }
    }
    public static func appSemiBold(size: FontSize) -> UIFont {
        if let _ = SDKColors.shared.receivedTheme?.buttonFont {
            return UIFont.systemFont(ofSize: size.rawValue, weight: .semibold)
        } else {
            return AppFont.font(name: .SemiBold, size: size)
        }
    }
    public static func appMedium(size: FontSize) -> UIFont {
        if let _ = SDKColors.shared.receivedTheme?.buttonFont {
            return UIFont.systemFont(ofSize: size.rawValue, weight: .medium)
        } else {
            return AppFont.font(name: .Medium, size: size)
        }
    }
    public static func appLight(size: FontSize) -> UIFont {
        if let _ = SDKColors.shared.receivedTheme?.buttonFont {
            return UIFont.systemFont(ofSize: size.rawValue, weight: .light)
        } else {
            return AppFont.font(name: .Light, size: size)
        }
    }
    
}


//public extension UIFont {
//
//    static func jbs_registerFont(withFilenameString filenameString: String, bundle: Bundle, size: CGFloat) {
//
//        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
//            print("UIFont+:  Failed to register font - path for resource not found.")
//            return
//        }
//
//        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
//            print("UIFont+:  Failed to register font - font data could not be loaded.")
//            return
//        }
//
//        guard let dataProvider = CGDataProvider(data: fontData) else {
//            print("UIFont+:  Failed to register font - data provider could not be loaded.")
//            return
//        }
//
//        guard let font = CGFont(dataProvider) else {
//            print("UIFont+:  Failed to register font - font could not be loaded.")
//            return
//        }
//
//        var errorRef: Unmanaged<CFError>? = nil
//        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
//            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
//        }
//
//    }
//
//}
