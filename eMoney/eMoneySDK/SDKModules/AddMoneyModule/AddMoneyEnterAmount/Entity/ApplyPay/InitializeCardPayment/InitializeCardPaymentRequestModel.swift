//
//  InitializeCardPaymentRequestModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 14/06/2023.
//

import Foundation

struct InitializeCardPaymentRequestModel: Codable {
    
    var status: String?
    var issuer: String?
    var providerName: String?
    var cardNumber: String?
    var maskedCardNumber: String?
    var cardTitle: String?
    var subtype: String?
    var brand: String?
    var providerUserName: String?
    var pin: String?
    var amount: String?
    var reason: String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case issuer = "issuer"
        case providerName = "providerName"
        case cardNumber = "cardNumber"
        case maskedCardNumber = "maskedCardNumber"
        case cardTitle = "cardTitle"
        case subtype = "subtype"
        case brand = "brand"
        case providerUserName = "providerUserName"
        case pin = "pin"
        case amount = "amount"
        case reason = "reason"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decode(String.self, forKey: .status)
        issuer = try? values.decode(String.self, forKey: .issuer)
        providerName = try? values.decode(String.self, forKey: .providerName)
        cardNumber = try? values.decode(String.self, forKey: .cardNumber)
        maskedCardNumber = try? values.decode(String.self, forKey: .maskedCardNumber)
        cardTitle = try? values.decode(String.self, forKey: .cardTitle)
        subtype = try? values.decode(String.self, forKey: .subtype)
        brand = try? values.decode(String.self, forKey: .brand)
        providerUserName = try? values.decode(String.self, forKey: .providerUserName)
        pin = try? values.decode(String.self, forKey: .pin)
        amount = try? values.decode(String.self, forKey: .amount)
        reason = try? values.decode(String.self, forKey: .reason)
    }
    
    init() {}
}
