//
//  AvailableBalanceResponse.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 02/06/2023.
//

import Foundation

class AvailableBalanceResponse: BaseResponseModel {
    
    // MARK: - Model Variables
    var data : AvailableBalanceData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(AvailableBalanceData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class AvailableBalanceData: Codable {
    let showNewCardPage: Bool?
    let maskNumber: String?
    let cardIdentifier: String?
    let cardMask: String?
    let cardStatus: String?
    let cardCreationDate: Int?
    let cardDeleted: Bool?
    let currency: String?
    let balance: Double?
    let cardHolderName: String?
    
    private enum CodingKeys: String, CodingKey {
        case showNewCardPage = "showNewCardPage"
        case maskNumber = "maskNumber"
        case cardIdentifier = "cardIdentifier"
        case cardMask = "cardMask"
        case cardStatus = "cardStatus"
        case cardCreationDate = "cardCreationDate"
        case cardDeleted = "cardDeleted"
        case currency = "currency"
        case balance = "balance"
        case cardHolderName = "cardHolderName"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        showNewCardPage = try values.decodeIfPresent(Bool.self, forKey: .showNewCardPage)
        maskNumber = try values.decodeIfPresent(String.self, forKey: .maskNumber)
        cardIdentifier = try values.decodeIfPresent(String.self, forKey: .cardIdentifier)
        cardMask = try values.decodeIfPresent(String.self, forKey: .cardMask)
        cardStatus = try values.decodeIfPresent(String.self, forKey: .cardStatus)
        cardCreationDate = try values.decodeIfPresent(Int.self, forKey: .cardCreationDate)
        cardDeleted = try values.decodeIfPresent(Bool.self, forKey: .cardDeleted)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        balance = try values.decodeIfPresent(Double.self, forKey: .balance)
        cardHolderName = try values.decodeIfPresent(String.self, forKey: .cardHolderName)
    }
}
