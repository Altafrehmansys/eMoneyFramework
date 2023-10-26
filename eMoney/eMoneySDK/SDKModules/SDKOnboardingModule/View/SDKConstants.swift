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
    public var flowName: String?
    public var partnerName: String?
    public var onSuccess: ((String) -> ())?
    public var onFailure: ((String, String) -> ())?
    private var isLogEnable: Bool = true
    public var environment: Environment?
    
    private init() {
        
    }
    
    //    var receivedColor: UIColor?
    var receivedTheme: EWalletTheme?
    
    func setReceivedColor(theme: EWalletTheme?) {
        self.receivedTheme = theme
    }
    
    public var logsEnabled: Bool {
        set {
            isLogEnable = newValue
        }
        get {
            isLogEnable
        }
    }
}

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

public class SDKNavigationStack {
    static let shared  = SDKNavigationStack()
    var baseViewController: UIViewController?
    
    private init() {
        
    }
    
    
}
//use the above colors like this UIColor(hex: "#D9ECF5")
