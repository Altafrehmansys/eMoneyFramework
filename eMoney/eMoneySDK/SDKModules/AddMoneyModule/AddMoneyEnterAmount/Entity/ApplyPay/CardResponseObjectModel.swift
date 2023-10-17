//
//  CardResponseObjectModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 14/06/2023.
//

import Foundation

final class CardResponseObjectModel: BaseResponseModel {
    
    let data: [CardResponseObjectDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode([CardResponseObjectDataModel].self, forKey: .data)
        try super.init(from: decoder)
    }
    
    // MARK: - Data Model
    struct CardResponseObjectDataModel: Codable {
        let issuer: String?
        let providerName: String?
        let cardNumber: String?
        let maskedCardNumber: String?
        let cardTitle: String?
        let subtype: String?
        let brand: String?
        let providerUserName: String?
        let reason: String?
        let imageUrl: String?
        let status: String?
        let lastUsed: Bool?
        
        private enum CodingKeys: String, CodingKey {
            case issuer = "issuer"
            case providerName = "providerName"
            case cardNumber = "cardNumber"
            case maskedCardNumber = "maskedCardNumber"
            case cardTitle = "cardTitle"
            case subtype = "subtype"
            case brand = "brand"
            case providerUserName = "providerUserName"
            case reason = "reason"
            case imageUrl = "imageUrl"
            case status = "status"
            case lastUsed = "lastUsed"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            issuer = try? values.decode(String.self, forKey: .issuer)
            providerName = try? values.decode(String.self, forKey: .providerName)
            cardNumber = try? values.decode(String.self, forKey: .cardNumber)
            maskedCardNumber = try? values.decode(String.self, forKey: .maskedCardNumber)
            cardTitle = try? values.decode(String.self, forKey: .cardTitle)
            subtype = try? values.decode(String.self, forKey: .subtype)
            brand = try? values.decode(String.self, forKey: .brand)
            providerUserName = try? values.decode(String.self, forKey: .providerUserName)
            reason = try? values.decode(String.self, forKey: .reason)
            imageUrl = try? values.decode(String.self, forKey: .imageUrl)
            status = try? values.decode(String.self, forKey: .status)
            lastUsed = try? values.decode(Bool.self, forKey: .lastUsed)
        }
    }
}
