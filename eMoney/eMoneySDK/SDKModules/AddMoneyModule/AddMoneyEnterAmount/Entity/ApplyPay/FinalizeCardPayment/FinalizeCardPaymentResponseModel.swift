//
//  FinalizeCardPaymentResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 15/06/2023.
//

import Foundation

final class FinalizeCardPaymentResponseModel: BaseResponseModel {
    
    let transaction: FinalizeCardPaymentResponseDataModel?
    
    enum CodingKeys: String, CodingKey {
        case transaction
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transaction = try? values.decode(FinalizeCardPaymentResponseDataModel.self, forKey: .transaction)
        try super.init(from: decoder)
    }
    
    // MARK: - Data Model
    struct FinalizeCardPaymentResponseDataModel: Codable {
        
        let responseDescription: String?
        let responseClassDescription: String?
        let approvalCode: String?
        let account: String?
        let orderID: String?
        let cardNumber: String?
        let cardToken: String?
        let cardBrand: String?
        let balance: String?
        var amount: String?
        var fees: String?
        var cardExpiry: String?
        var cardType: String?
        var isWalletUsed: String?
        var walletName: String?
        var uniqueID: String?
        var sessionID: String?
        var transactionID: String?
        
        private enum CodingKeys: String, CodingKey {
            case responseDescription = "responseDescription"
            case responseClassDescription = "responseClassDescription"
            case approvalCode = "approvalCode"
            case account = "account"
            case orderID = "orderID"
            case cardNumber = "cardNumber"
            case cardToken = "cardToken"
            case cardBrand = "cardBrand"
            case balance = "balance"
            case amount = "amount"
            case fees = "fees"
            case cardExpiry = "cardExpiry"
            case cardType = "cardType"
            case isWalletUsed = "isWalletUsed"
            case walletName = "walletName"
            case uniqueID = "uniqueID"
            case sessionID = "sessionID"
            case transactionID = "transactionID"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            responseDescription = try? values.decode(String.self, forKey: .responseDescription)
            responseClassDescription = try? values.decode(String.self, forKey: .responseClassDescription)
            approvalCode = try? values.decode(String.self, forKey: .approvalCode)
            account = try? values.decode(String.self, forKey: .account)
            orderID = try? values.decode(String.self, forKey: .orderID)
            cardNumber = try? values.decode(String.self, forKey: .cardNumber)
            cardToken = try? values.decode(String.self, forKey: .cardToken)
            cardBrand = try? values.decode(String.self, forKey: .cardBrand)
            balance = try? values.decode(String.self, forKey: .balance)
            amount = try? values.decode(String.self, forKey: .amount)
            fees = try? values.decode(String.self, forKey: .fees)
            cardExpiry = try? values.decode(String.self, forKey: .cardExpiry)
            cardType = try? values.decode(String.self, forKey: .cardType)
            isWalletUsed = try? values.decode(String.self, forKey: .isWalletUsed)
            walletName = try? values.decode(String.self, forKey: .walletName)
            uniqueID = try? values.decode(String.self, forKey: .uniqueID)
            sessionID = try? values.decode(String.self, forKey: .sessionID)
            transactionID = try? values.decode(String.self, forKey: .transactionID)
        }
    }
}
