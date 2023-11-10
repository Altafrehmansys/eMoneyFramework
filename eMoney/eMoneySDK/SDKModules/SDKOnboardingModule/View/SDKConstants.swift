//
//  SDKConstants.swift
//  eMoneySDK
//
//  Created by Saud Waqar on 20/09/2023.
//
import UIKit
import Foundation

class SDKColors {
    
    static let shared = SDKColors()
    public var clientID: String?
    public var accessToken: String?
    public var msisdn: String?
    public var flowName: String?
    public var partnerName: String?
    public var onSuccess: ((String) -> ())?
    public var onFailure: ((String, String) -> ())?
    private var isLogEnable: Bool = true
    public var onLoginSuccess: ((BaseResponse) -> ())?
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
    
    var authorizationToken: String {
        return "bW9iaWxlLWZlOnBhc3N3b3JkMTIz"
    }
}

public class SDKNavigationStack {
    static let shared  = SDKNavigationStack()
    var baseViewController: UIViewController?
    
    private init() {
        
    }
    
    
}


//use the above colors like this UIColor(hex: "#D9ECF5")
