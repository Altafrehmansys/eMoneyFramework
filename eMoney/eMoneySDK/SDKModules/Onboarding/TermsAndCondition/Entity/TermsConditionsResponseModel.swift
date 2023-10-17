//
//  TermsConditionsResponseModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

enum PrivacypolicyType : String {
    case termsCondition = "terms_and_conditions"
    case privacyPolicy = "card_terms_and_conditions"
}

struct TermsConditionsRequestModel:Codable{
    var key:String?
}

class TermsConditionsResponseModel: BaseResponseModel {
    // MARK: - Model Variables
    let data: TermsConditionsDataClass?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(TermsConditionsDataClass.self, forKey: .data)
        try super.init(from: decoder)
    }
}
// MARK: - DataClass
struct TermsConditionsDataClass: Codable {
    let html: String?
    enum CodingKeys: String, CodingKey {
        case html = "html"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        html = try values.decodeIfPresent(String.self, forKey: .html)
    }
    
}
