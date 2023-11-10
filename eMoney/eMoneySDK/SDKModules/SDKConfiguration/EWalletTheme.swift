//
//  EWalletTheme.swift
//  eMoneySDK
//
//  Created by Altaf Ur Rehman on 09/11/2023.
//

import Foundation
import UIKit

public struct EWalletTheme {
    public var buttonBackgroundColor: UIColor?
    public var buttonTextColor: UIColor?
    public var buttonFont: UIFont?
    
    public var toolBarTitleColor: UIColor?
    public var toolBarLabelColor: UIColor?
    public var toolBarIconColor: UIColor?
    
    public var checkBoxColor: UIColor?
    public var segmentBarColor: UIColor?
    
    public init(buttonBackgroundColor: UIColor? = nil,
                buttonTextColor: UIColor? = nil,
                buttonFont: UIFont? = nil,
                toolBarTitleColor: UIColor? = nil,
                toolBarLabelColor: UIColor? = nil,
                toolBarIconColor: UIColor? = nil,
                checkBoxColor: UIColor? = nil,
                segmentBarColor: UIColor? = nil) {
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonTextColor = buttonTextColor
        self.buttonFont = buttonFont
        self.toolBarTitleColor = toolBarTitleColor
        self.toolBarLabelColor = toolBarLabelColor
        self.toolBarIconColor = toolBarIconColor
        self.checkBoxColor = checkBoxColor
        self.segmentBarColor = segmentBarColor
    }
}
