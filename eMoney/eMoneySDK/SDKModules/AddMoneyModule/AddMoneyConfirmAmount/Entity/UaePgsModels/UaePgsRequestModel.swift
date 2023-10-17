//
//  UaePgsRequestModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 09/06/2023.
//

import Foundation

final class UaePgsRequestModel: Codable {
    let amount: String?
    let isDebitCard: Bool?

    
    enum CodingKeys: String, CodingKey {
        case amount
        case isDebitCard
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        isDebitCard = try values.decodeIfPresent(Bool.self, forKey: .isDebitCard)
    }
    
    init(amount: String, isDebitCard: Bool) {
        self.amount = amount
        self.isDebitCard = isDebitCard
    }
}
