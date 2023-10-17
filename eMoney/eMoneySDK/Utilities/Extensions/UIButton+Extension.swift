//
//  UIButton+Extension.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 07/07/2023.
//

import Foundation
import UIKit
enum Padding {
    case left(value:CGFloat)
    case right(value:CGFloat)
    case top(value:CGFloat)
    case bottom(value:CGFloat)
    case horizontal(value:CGFloat)
    case vertical(value:CGFloat)
    case all(value:CGFloat)
}
extension UIButton {
    func setPadding(_ padding:Padding = .all(value:0)){
        switch padding {
        case .left(let value):
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: value, bottom: 0, right: 0)
        case .right(let value):
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: value)
        case .top(let value):
            self.titleEdgeInsets = UIEdgeInsets(top: value, left: 0, bottom: 0, right: 0)
        case .bottom(let value):
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        case .horizontal(let value):
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: value, bottom: 0, right: value)
        case .vertical(let value):
            self.titleEdgeInsets = UIEdgeInsets(top: value, left: 0, bottom: value, right: 0)
        case .all(let value):
            if #available(iOS 15.0, *) {
                self.configuration?.imagePadding = value
            } else {
                // Fallback on earlier versions
                self.titleEdgeInsets = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
            }
        }
      
    }
}
