//
//  BankAccountsListResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 19/05/2023.
//

import Foundation

final class BankAccountsListResponseModel: BaseResponseModel {
    
    let data: DataModel?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode(DataModel.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    // MARK: - Data Model
    struct DataModel: Codable {
        let paymentSources: [PaymentSources]?
        
        private enum CodingKeys: String, CodingKey {
            case paymentSources = "paymentSources"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            paymentSources = try? values.decode([PaymentSources].self, forKey: .paymentSources)
        }
        
    }
    
    struct PaymentSources: Codable {
        
        let paymentSourceId: String?
        var paymentSourceStatus: String?
        let bankName: String?
        let paymentSourceCoolOffPeriod: String?
        let bankIdentifier: String?
        let bankLogo: String?
        let bankLogoAlt: String?
        let minLimit: Int?
        let maxLimit: Int?
        let accounts: [Accounts]?
        
        private enum CodingKeys: String, CodingKey {
            case paymentSourceId = "paymentSourceId"
            case paymentSourceStatus = "paymentSourceStatus"
            case bankName = "bankName"
            case paymentSourceCoolOffPeriod = "paymentSourceCoolOffPeriod"
            case bankIdentifier = "bankIdentifier"
            case bankLogo = "bankLogo"
            case bankLogoAlt = "bankLogoAlt"
            case minLimit = "minLimit"
            case maxLimit = "maxLimit"
            case accounts = "accounts"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            paymentSourceId = try? values.decode(String.self, forKey: .paymentSourceId)
            paymentSourceStatus = try? values.decode(String.self, forKey: .paymentSourceStatus)
            bankName = try? values.decode(String.self, forKey: .bankName)
            paymentSourceCoolOffPeriod = try? values.decode(String.self, forKey: .paymentSourceCoolOffPeriod)
            bankIdentifier = try? values.decode(String.self, forKey: .bankIdentifier)
            bankLogo = try? values.decode(String.self, forKey: .bankLogo)
            bankLogoAlt = try? values.decode(String.self, forKey: .bankLogoAlt)
            minLimit = try? values.decode(Int.self, forKey: .minLimit)
            maxLimit = try? values.decode(Int.self, forKey: .maxLimit)
            accounts = try? values.decode([Accounts].self, forKey: .accounts)
        }
        
    }
    
    struct Accounts: Codable {
        
        let accountId: String?
        let accountBalance: Int?
        let maskedAccountNumber: String?
        let accountName: String?
        let currency: String?
        let accountNumber: String?
        let iban: String?
        let lastUsed: Bool?
        
        private enum CodingKeys: String, CodingKey {
            case accountId = "accountId"
            case accountBalance = "accountBalance"
            case maskedAccountNumber = "maskedAccountNumber"
            case accountName = "accountName"
            case currency = "currency"
            case accountNumber = "accountNumber"
            case iban = "iban"
            case lastUsed = "lastUsed"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            accountId = try? values.decode(String.self, forKey: .accountId)
            accountBalance = try? values.decode(Int.self, forKey: .accountBalance)
            maskedAccountNumber = try? values.decode(String.self, forKey: .maskedAccountNumber)
            accountName = try? values.decode(String.self, forKey: .accountName)
            currency = try? values.decode(String.self, forKey: .currency)
            accountNumber = try? values.decode(String.self, forKey: .accountNumber)
            iban = try? values.decode(String.self, forKey: .iban)
            lastUsed = try? values.decode(Bool.self, forKey: .lastUsed)
        }
    }
}
