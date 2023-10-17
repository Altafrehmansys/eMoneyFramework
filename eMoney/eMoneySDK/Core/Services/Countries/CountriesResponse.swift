//
//  CountriesResponse.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/06/2023.
//

import Foundation

class CountriesResponse: BaseResponseModel {
    
    let data: [CountryData]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([CountryData].self, forKey: .data) ?? []
        try super.init(from: decoder)
    }
    
}

struct CountryData: Codable {
    let countryISO: String?
    let countryName: String?
    let minimumAllowed: Int?
    let maximumAllowed: Int?
    let countryCodeList: [String]
}
