//
//  LeanAccountsResponseModel.swift
//  e&money
//
//  Created by Qamar Iqbal on 17/05/2023.
//

import Foundation



// PaymentIntentResponseModel
class LeanAccountsResponseModel: BaseResponseModel {
    let data: LeanAccountsData?
//    let displayAppRating: Bool?
//    let responseCode: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
//        case displayAppRating = "displayAppRating"
//        case responseCode = "responseCode"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(LeanAccountsData.self, forKey: .data)
//        displayAppRating = try values.decodeIfPresent(Bool.self, forKey: .displayAppRating)
//        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        try super.init(from: decoder)
    }
}



class LeanAccountsData: Codable{
    
    var accountList: [LeanAccountList]?
    var disclaimer: String?
    
    enum CodingKeys: String, CodingKey {
        case accountList = "accountList"
        case disclaimer = "disclaimer"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountList = try values.decodeIfPresent([LeanAccountList].self, forKey: .accountList)
        disclaimer = try values.decodeIfPresent(String.self, forKey: .disclaimer)
    }
}


class LeanAccountList: Codable{
    var accounBalance: Int?
    var accountId: String?
    var accountType: String?
    var balanceLastUpdated: String?
    var bankIdentifier: String?
    var bankLogo: String?
    var bankLogoAlt: String?
    var iban: String?
    var accountNumber: String?
    var bankName: String?
    var currency: String?
    var internationalTransferLimits: [InternationalTransferLimits]?
    var maskedAccountNumber: String?
    var paymentSourceCoolOffPeriod: String?
    var paymentSourceId: String?
    var paymentSourceStatus: String?
    var transferLimits: [InternationalTransferLimits]?
    var isDeleteDisabled: Bool?

    enum CodingKeys: String, CodingKey {
        case accounBalance = "accounBalance"
        case accountId = "accountId"
        case accountType = "accountType"
        case balanceLastUpdated = "balanceLastUpdated"
        case bankIdentifier = "bankIdentifier"
        case bankLogo = "bankLogo"
        case bankLogoAlt = "bankLogoAlt"
        case iban = "iban"
        case accountNumber = "accountNumber"
        case bankName = "bankName"
        case currency = "currency"
        case internationalTransferLimits = "internationalTransferLimits"
        case maskedAccountNumber = "maskedAccountNumber"
        case paymentSourceCoolOffPeriod = "paymentSourceCoolOffPeriod"
        case paymentSourceId = "paymentSourceId"
        case paymentSourceStatus = "paymentSourceStatus"
        case transferLimits = "transferLimits"
        case isDeleteDisabled = "isDeleteDisabled"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accounBalance = try values.decodeIfPresent(Int.self, forKey: .accounBalance)
        accountId = try values.decodeIfPresent(String.self, forKey: .accountId)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        balanceLastUpdated = try values.decodeIfPresent(String.self, forKey: .balanceLastUpdated)
        bankIdentifier = try values.decodeIfPresent(String.self, forKey: .bankIdentifier)
        bankLogo = try values.decodeIfPresent(String.self, forKey: .bankLogo)
        bankLogoAlt = try values.decodeIfPresent(String.self, forKey: .bankLogoAlt)
        iban = try values.decodeIfPresent(String.self, forKey: .iban)
        accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
        bankName = try values.decodeIfPresent(String.self, forKey: .bankName)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        internationalTransferLimits = try values.decodeIfPresent([InternationalTransferLimits].self, forKey: .internationalTransferLimits)
        maskedAccountNumber = try values.decodeIfPresent(String.self, forKey: .maskedAccountNumber)
        paymentSourceCoolOffPeriod = try values.decodeIfPresent(String.self, forKey: .paymentSourceCoolOffPeriod)
        paymentSourceId = try values.decodeIfPresent(String.self, forKey: .paymentSourceId)
        paymentSourceStatus = try values.decodeIfPresent(String.self, forKey: .paymentSourceStatus)
        transferLimits = try values.decodeIfPresent([InternationalTransferLimits].self, forKey: .transferLimits)
        isDeleteDisabled = try values.decodeIfPresent(Bool.self, forKey: .isDeleteDisabled)
    }
}


class InternationalTransferLimits: Codable{
    
    var currency: String?
    var max: Int?
    var min: Int?

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case max = "max"
        case min = "min"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        max = try values.decodeIfPresent(Int.self, forKey: .max)
        min = try values.decodeIfPresent(Int.self, forKey: .min)
    }
}
