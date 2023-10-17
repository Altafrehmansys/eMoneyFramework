//
//  PaymentIntent.swift
//  e&money
//
//  Created by Qamar Iqbal on 16/05/2023.
//

import Foundation


// PaymentIntentResponseModel
class PaymentIntentResponseModel: BaseResponseModel {
    let data: PaymentIntentData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(PaymentIntentData.self, forKey: .data)
        try super.init(from: decoder)
    }
}


// PaymentIntentData
class PaymentIntentData: BaseResponseModel{
    
    var paymentIntentID: String?
    
    enum CodingKeys: String, CodingKey {
        case paymentIntentID = "paymentIntentID"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paymentIntentID = try values.decodeIfPresent(String.self, forKey: .paymentIntentID)
        try super.init(from: decoder)
    }
}

class PaymentIntentRequestModel: Codable {
    let paymentIntentRequestModelAccountID: String?
    let paymentIntentRequestModelAccountName: String?
    let paymentIntentRequestModelAccountNumber: String?
    let paymentIntentRequestModelAmount: Double?
    let paymentIntentRequestModelCurrency: String?
    let paymentIntentRequestModelEWalletBalance: String?
    let paymentIntentRequestModelIban: String?
    let paymentIntentRequestModelBankIdentifier: String?

    
    enum CodingKeys: String, CodingKey {
        case paymentIntentRequestModelAccountID = "accountID"
        case paymentIntentRequestModelAccountName = "accountName"
        case paymentIntentRequestModelAccountNumber = "accountNumber"
        case paymentIntentRequestModelAmount = "amount"
        case paymentIntentRequestModelCurrency = "currency"
        case paymentIntentRequestModelEWalletBalance = "eWalletBalance"
        case paymentIntentRequestModelIban = "iban"
        case paymentIntentRequestModelBankIdentifier = "bankIdentifier"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paymentIntentRequestModelAccountID = try values.decodeIfPresent(String.self, forKey: .paymentIntentRequestModelAccountID)
        paymentIntentRequestModelAccountName = try values.decodeIfPresent(String.self, forKey: .paymentIntentRequestModelAccountName)
        paymentIntentRequestModelAccountNumber = try values.decodeIfPresent(String.self, forKey: .paymentIntentRequestModelAccountNumber)
        paymentIntentRequestModelAmount = try values.decodeIfPresent(Double.self, forKey: .paymentIntentRequestModelAmount)
        paymentIntentRequestModelCurrency = try values.decodeIfPresent(String.self, forKey: .paymentIntentRequestModelCurrency)
        paymentIntentRequestModelEWalletBalance = try values.decodeIfPresent(String.self, forKey: .paymentIntentRequestModelEWalletBalance)
        paymentIntentRequestModelIban = try values.decodeIfPresent(String.self, forKey: .paymentIntentRequestModelIban)
        paymentIntentRequestModelBankIdentifier = try values.decodeIfPresent(String.self, forKey: .paymentIntentRequestModelBankIdentifier)
    }
    
    init(accountID: String, accountName: String, accountNumber: String, amount: Double, currency: String, eWalletBalance: String, iban: String, bankIdentifier: String) {
        self.paymentIntentRequestModelAccountID = accountID
        self.paymentIntentRequestModelAccountName = accountName
        self.paymentIntentRequestModelAccountNumber = accountNumber
        self.paymentIntentRequestModelAmount = amount
        self.paymentIntentRequestModelCurrency = currency
        self.paymentIntentRequestModelEWalletBalance = eWalletBalance
        self.paymentIntentRequestModelIban = iban
        self.paymentIntentRequestModelBankIdentifier = bankIdentifier
    }
}

struct GetLocationListModel: Codable{
    var latitude: Double?
    var longitude: Double?
    var locationType: String?
    var radius: Double?
    var pageNumber: Int?
    var pageSize: Int?
}
