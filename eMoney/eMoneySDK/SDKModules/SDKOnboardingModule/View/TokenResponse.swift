//
//  TokenResponse.swift
//  eMoneySDK
//
//  Created by Altaf Ur Rehman on 10/10/2023.
//

import Foundation

struct TokenRequestModel:Codable {
    var authorization: String?
}

class TokenResponseModel: BaseResponseModel {
    var data: TokenResponse?
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(TokenResponse.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class TokenResponse: Codable {
    let accessToken: String?
    let refreshToken: String?
    let tokenType: String?
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
        case tokenType = "tokenType"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
        tokenType = try values.decodeIfPresent(String.self, forKey: .tokenType)
    }
}
