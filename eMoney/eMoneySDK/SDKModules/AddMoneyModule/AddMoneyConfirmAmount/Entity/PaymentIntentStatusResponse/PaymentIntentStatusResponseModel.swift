//
//  PaymentIntentStatusResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 10/07/2023.
//

import Foundation

final class PaymentIntentStatusResponseModel: BaseResponseModel {
    var data: PaymentIntentStatusResponseDataModel?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(PaymentIntentStatusResponseDataModel.self   , forKey: .data)
        try super.init(from: decoder)
    }
    
    struct PaymentIntentStatusResponseDataModel: Codable {
        var paymentIntentID: String?
        var bankTransactionReference: String?
        var status: String?
        
        enum CodingKeys: String, CodingKey {
            case paymentIntentID
            case bankTransactionReference
            case status
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            paymentIntentID = try values.decodeIfPresent(String.self, forKey: .paymentIntentID)
            bankTransactionReference = try values.decodeIfPresent(String.self, forKey: .bankTransactionReference)
            status = try values.decodeIfPresent(String.self, forKey: .status)
        }
    }
}
