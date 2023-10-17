//
//  InitializeCardPaymentResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 14/06/2023.
//

import Foundation

final class InitializeCardPaymentResponseModel: BaseResponseModel {
    
    let data: InitializeCardPaymentResponseDataModel?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode(InitializeCardPaymentResponseDataModel.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    // MARK: - Data Model
    struct InitializeCardPaymentResponseDataModel: Codable {
        
        let url: String?
        let epgTransactionId: String?
        let epgSessionId: String?
        let instrumentepgTerminal: String?
        let instrumentProviderFri: String?
        let epgCustomerName: String?
        let epgStore: String?
        let epgTerminal: String?
        let instrumentepgStore: String?
        
        private enum CodingKeys: String, CodingKey {
            case url = "url"
            case epgTransactionId = "epgTransactionId"
            case epgSessionId = "epgSessionId"
            case instrumentepgTerminal = "instrumentepgTerminal"
            case instrumentProviderFri = "instrumentProviderFri"
            case epgCustomerName = "epgCustomerName"
            case epgStore = "epgStore"
            case epgTerminal = "epgTerminal"
            case instrumentepgStore = "instrumentepgStore"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            url = try? values.decode(String.self, forKey: .url)
            epgTransactionId = try? values.decode(String.self, forKey: .epgTransactionId)
            epgSessionId = try? values.decode(String.self, forKey: .epgSessionId)
            instrumentepgTerminal = try? values.decode(String.self, forKey: .instrumentepgTerminal)
            instrumentProviderFri = try? values.decode(String.self, forKey: .instrumentProviderFri)
            epgCustomerName = try? values.decode(String.self, forKey: .epgCustomerName)
            epgStore = try? values.decode(String.self, forKey: .epgStore)
            epgTerminal = try? values.decode(String.self, forKey: .epgTerminal)
            instrumentepgStore = try? values.decode(String.self, forKey: .instrumentepgStore)
        }
    }
}
