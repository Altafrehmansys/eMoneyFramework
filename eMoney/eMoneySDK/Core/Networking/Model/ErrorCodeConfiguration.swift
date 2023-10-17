//
//  ErrorCodeConfiguration.swift
//  e&money
//
//  Created by Qamar Iqbal on 17/05/2023.
//

import Foundation


class ErrorCodeConfiguration: Codable{
    
    var errorDescriptionAr: String?
    var errorDescriptionEn: String?
    var errorCode: String?
    var responseCode: String?
    var errorDescription: String?
    var errorTitle: String?
    var isInlineError: Bool?
    var errors: [BaseErrors]?

    enum CodingKeys: String, CodingKey {
        case errorDescriptionAr = "errorDescriptionAr"
        case errorDescriptionEn = "errorDescriptionEn"
        case errorCode = "errorCode"
        case responseCode = "responseCode"
        case errorDescription = "errorDescription"
        case errorTitle = "errorTitle"
        case isInlineError = "isInlineError"
        case errors = "errors"

    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorDescriptionAr = try values.decodeIfPresent(String.self, forKey: .errorDescriptionAr)
        errorDescriptionEn = try values.decodeIfPresent(String.self, forKey: .errorDescriptionEn)
        errorCode = try values.decodeIfPresent(String.self, forKey: .errorCode)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        errorDescription = try values.decodeIfPresent(String.self, forKey: .errorDescription)
        errorTitle = try values.decodeIfPresent(String.self, forKey: .errorTitle)
        isInlineError = try values.decodeIfPresent(Bool.self, forKey: .isInlineError)
        errors = try values.decodeIfPresent([BaseErrors].self, forKey: .errors)
    }
}




class BaseErrors: Codable{
    
    var errors: String?

    enum CodingKeys: String, CodingKey {
        case errors = "errors"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errors = try values.decodeIfPresent(String.self, forKey: .errors)
    }
}
