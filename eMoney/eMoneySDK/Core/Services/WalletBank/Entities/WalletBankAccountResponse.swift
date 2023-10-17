//
//  WalletBankAccountResponse.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//

import Foundation

class WalletBankAccountResponse: BaseResponseModel {
    
    let data: WalletBankAccountData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(WalletBankAccountData.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}

struct WalletBankAccountData: Codable {
    let paymentSources: [WalletBankData]
}

struct WalletBankData: Codable {
    let paymentSourceId: String?
    let paymentSourceStatus: String?
    let bankName: String?
    let bankIdentifier: String?
    let bankLogo: String?
    let bankLogoAlt: String?
    let minLimit: Int?
    let maxLimit: Int?
    let accounts: [WalletBankAccount]
}

struct WalletBankAccount: Codable {
    let accountId: String?
    let accountName: String?
    let accountBalance: Double?
    let maskedAccountNumber: String?
    let currency: String?
    let accountNumber: String?
    let iban: String?
}
