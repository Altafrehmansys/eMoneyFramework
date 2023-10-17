//
//  NetworkProvidersResponse.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 14/06/2023.
//

import Foundation

class NetworkProvidersResponse: BaseResponseModel {
    
    let data: [NetworkProviderData]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([NetworkProviderData].self   , forKey: .data) ?? []
        try super.init(from: decoder)
    }
    
}

struct NetworkProviderData: Codable {
    let providerCode: String?
    let providerName: String?
    let validationRegex: String?
    let logoUrl: String?
    let providerStatus: Bool?
}

