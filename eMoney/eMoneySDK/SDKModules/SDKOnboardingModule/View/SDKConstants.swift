//
//  SDKConstants.swift
//  eMoneySDK
//
//  Created by Saud Waqar on 20/09/2023.
//
import UIKit
import Foundation

public class SDKColors {
    
    static let shared = SDKColors()
    public var clientID: String?
    public var accessToken: String?
    public var msisdn: String?
    public var partnerName: String?
    public var onSuccess: ((String) -> ())?
    public var onFailure: ((String, String) -> ())?
    
    private init() {
        
    }
    
    //    var receivedColor: UIColor?
    var receivedTheme: EWalletTheme?
    
    func setReceivedColor(theme: EWalletTheme?) {
        self.receivedTheme = theme
    }
}

public struct EWalletTheme {
    public var buttonBackgroundColor: String?
    public var buttonTextColor: String?
    public var buttonFont: UIFont?
    
    public var toolBarTitleColor: String?
    public var toolBarLabelColor: String?
    public var toolBarIconColor: String?
    
    public var checkBoxColor: String?
    public var segmentBarColor: String?
    
    public init(buttonBackgroundColor: String? = nil,
                buttonTextColor: String? = nil,
                buttonFont: UIFont? = nil,
                toolBarTitleColor: String? = nil,
                toolBarLabelColor: String? = nil,
                toolBarIconColor: String? = nil,
                checkBoxColor: String? = nil,
                segmentBarColor: String? = nil) {
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

//use the above colors like this UIColor(hex: "#D9ECF5")
