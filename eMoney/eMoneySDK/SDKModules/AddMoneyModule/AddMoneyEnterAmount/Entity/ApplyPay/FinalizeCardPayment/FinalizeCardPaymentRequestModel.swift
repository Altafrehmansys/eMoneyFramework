//
//  FinalizeCardPaymentRequestModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 15/06/2023.
//

import Foundation

struct FinalizeCardPaymentRequestModel: Codable {
    
    var epgTransactionId: String?
    var pin: String?
    
    private enum CodingKeys: String, CodingKey {
        case epgTransactionId
        case pin
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        epgTransactionId = try? values.decode(String.self, forKey: .epgTransactionId)
        pin = try? values.decode(String.self, forKey: .pin)
    }
    
    init() {}
}
