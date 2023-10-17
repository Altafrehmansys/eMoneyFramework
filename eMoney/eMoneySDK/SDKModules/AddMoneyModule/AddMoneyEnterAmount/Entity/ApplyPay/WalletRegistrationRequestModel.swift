//
//  WalletRegistrationRequestRequestModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 14/06/2023.
//

import Foundation

struct WalletRegistrationRequestModel: Codable {
    
    var walletRegistration: String?
    var password: String?
    var currency: String?
    var transactionHint: String?
    var terminal: String?
    var orderID: String?
    var orderInfo: String?
    var store: String?
    var amount: String?
    var customer: String?
    var userName: String?
    var orderName: String?
    var mobileNumber: String?
    var totalPayment: String?
    var transactionType: String?
    var merchantDescriptor: String?
    var walletName: String?
    var extraData: String?
    var pin: String?
    var identity: String?
    
    private enum CodingKeys: String, CodingKey {
        case walletRegistration = "walletRegistration"
        case password = "password"
        case currency = "currency"
        case transactionHint = "transactionHint"
        case terminal = "terminal"
        case orderID = "orderID"
        case orderInfo = "orderInfo"
        case store = "store"
        case amount = "amount"
        case customer = "customer"
        case userName = "userName"
        case orderName = "orderName"
        case mobileNumber = "mobileNumber"
        case totalPayment = "totalPayment"
        case transactionType = "transactionType"
        case merchantDescriptor = "merchantDescriptor"
        case walletName = "walletName"
        case extraData = "extraData"
        case pin = "pin"
        case identity = "identity"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        walletRegistration = try values.decode(String.self, forKey: .walletRegistration)
        password = try values.decode(String.self, forKey: .password)
        currency = try values.decode(String.self, forKey: .currency)
        transactionHint = try values.decode(String.self, forKey: .transactionHint)
        terminal = try values.decode(String.self, forKey: .terminal)
        orderID = try values.decode(String.self, forKey: .orderID)
        orderInfo = try values.decode(String.self, forKey: .orderInfo)
        store = try values.decode(String.self, forKey: .store)
        amount = try values.decode(String.self, forKey: .amount)
        customer = try values.decode(String.self, forKey: .customer)
        userName = try values.decode(String.self, forKey: .userName)
        orderName = try values.decode(String.self, forKey: .orderName)
        mobileNumber = try values.decode(String.self, forKey: .mobileNumber)
        totalPayment = try values.decode(String.self, forKey: .totalPayment)
        transactionType = try values.decode(String.self, forKey: .transactionType)
        merchantDescriptor = try values.decode(String.self, forKey: .merchantDescriptor)
        walletName = try values.decode(String.self, forKey: .walletName)
        extraData = try values.decode(String.self, forKey: .extraData)
        pin = try values.decode(String.self, forKey: .pin)
        identity = try values.decode(String.self, forKey: .identity)
    }
    
    init() {
        
    }
}
