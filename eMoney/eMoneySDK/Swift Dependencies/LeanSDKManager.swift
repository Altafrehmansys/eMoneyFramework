//
//  LeanSDKManager.swift
//  etisalatWallet
//
//  Created by Awais Iqbal on 26/09/2022.
//  Copyright © 2022 Etisalat UAE. All rights reserved.
//

import Foundation
import LeanSDK
import UIKit

protocol LeanSDKManagerDelegate {
    func dismissWithSuccess(status: LeanSDKStatusEnum)
    func dismissWithError(status: LeanSDKStatusEnum)
}

class LeanSDKManager {
    
    // MARK: Lean Keys
    let leanAppToken: String = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.object(forInfoDictionaryKey: "LEAN_APP_TOKEN") as? String ?? "" //"7c1dcbcd-4020-472d-8532-dcbac905e239"
    
    // MARK: Lean Properties
    let linkPermissions = [LeanPermission.Identity, LeanPermission.Accounts,
                           LeanPermission.Transactions, LeanPermission.Balance, LeanPermission.Payments]
    let leanVersion: String = "latest"
    let isSandBox: Bool = (Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.object(forInfoDictionaryKey: "IS_LEAN_SANDBOX_ENABLED") as? NSString ?? "").boolValue
    
    // MARK: Theme
    let themeColor: String = "#E00800"
    let buttonTextColor: String = "#DFEFDD"
    
    typealias result<LeanStatus> = (Result<LeanStatus, Error>) -> Void
    
    static let shared = LeanSDKManager()
    var delegate: LeanSDKManagerDelegate!
    init(){}
    
    func setupLeanSDK() {
        Lean.manager.setup(appToken: self.leanAppToken, sandbox: self.isSandBox, version: self.leanVersion)
    }
    
    func connectSourceAccount(presentOn: UIViewController, customerID: String, bankID: String, paymentDestinationID: String?) {
        let customConfig = LeanCustomization(
            themeColor: self.themeColor, buttonTextColor: self.buttonTextColor,
            linkColor: self.themeColor
        )
        
        Lean.manager.connect(
            presentingViewController: presentOn,
            customerId: customerID,
            permissions: linkPermissions, paymentDestinationId: paymentDestinationID,
            bankId: bankID,
            customization: customConfig,
            success: { (status) in
                print("LeanSDK Status: \(status)")
                self.delegate.dismissWithSuccess(status: LeanSDKStatusEnum(from: status.status))
            },
            error: { (status) in
                print("LeanSDK Status: \(status)")
                self.delegate.dismissWithError(status: LeanSDKStatusEnum(from: status.status))
            }
        )
    }
    
    func payFromLeanSDK(presentOn: UIViewController, paymentIntentID: String, bankID: String) {
        
        let customConfig = LeanCustomization(
            themeColor: self.themeColor, buttonTextColor: self.buttonTextColor,
            linkColor: self.themeColor
        )
        
        Lean.manager.pay(
            presentingViewController: presentOn,
            paymentIntentId: paymentIntentID,
            accountId: bankID,
            customization: customConfig,
            success: { (status) in
                print("Lean Pay SDK Response: \(status)")
                self.delegate.dismissWithSuccess(status: LeanSDKStatusEnum(from: status.status))
            },
            error: { (status) in
                print("Lean Pay SDK Response: \(status)")
                self.delegate.dismissWithError(status: LeanSDKStatusEnum(from: status.status))
            }
        )
    }
}

enum LeanSDKStatusEnum {
    case Ok
    case Cancelled
    case ReconnectRequired
    case Pending
    case Success
    case Error
    
    //    case Active
    //    case AcceptedByBank
    //    case PendingWithBank
    //    case Failed
    //    case Unknown
    //    case RejectedByBank
    //    case MFAAttemptsExhausted
    //    case InavlidCrediantials
    //    case CrediantialsUpdateRequired
    //    case MFARequired
    //    case InavlidMFA
    //    case RequiresLoginMFA
    //    case AwaitingLoginMFAToken
    //    case InvalidPaymetnMFA
    //    case RequiresbenefeciaryMFA
    //    case InavlidBenefeciaryMFA
    //    case RequiresMFA
    //    case AwaitingAppAuth
    //    case pendingBenefeciaryCoolOff
    //    case AwaitingEndUserAuthentication
    //    case RequiredLoginSecurityQuestions
    //    case InValidLoginSecurityQuestions
    //    case RequiresBenefeciarySecurityQuestions
    //    case InavlidBenefeciarySecurityQuestionAnswer
    //    case SecurityQuestionAttempExahusted
    //    case SecurityQuestionAnswerRequired
    //    case InvalidSecurityQuestionAnswer
    //    case AwaitingPaymentSecurityQuestions
    //    case InvalidPaymentSecurityAnswers
    //    case PaymentSourceAccountBanalceFailed
    
    init(from type: String) {
        switch (type) {
        case "RECONNECT_REQUIRED":
            self = .ReconnectRequired
        case "OK":
            self = .Ok
        case "CANCELLED":
            self = .Cancelled
        case "SUCCESS":
            self = .Success
        case "ERROR":
            self = .Error
        case "PENDING":
            self = .Pending
        default:
            self = .Error
        }
    }
}
