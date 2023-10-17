//
//  OCRAnalyzeResponseModel.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 16/04/2023.
//

import Foundation

class OCRAnalyzeResponseModel:BaseResponseModel{
    var data : OCRAnalyzeData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(OCRAnalyzeData.self, forKey: .data)
        try super.init(from: decoder)
    }
}


class OCRAnalyzeData:Codable{
    var documentMismatch : Bool?
    var age : String?
    var sex : String?
    var dob : String?
    var fullName : String?
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var nationalityIso3 : String?
    var expiry : String?
    var emiratesId : String?

    enum CodingKeys: String, CodingKey {
        case documentMismatch = "documentMismatch"
        case age = "age"
        case sex = "sex"
        case dob = "dob"
        case fullName = "fullName"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case nationalityIso3 = "nationalityIso3"
        case expiry = "expiry"
        case emiratesId = "emiratesId"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        documentMismatch = try values.decodeIfPresent(Bool.self, forKey: .documentMismatch)
        sex = try values.decodeIfPresent(String.self, forKey: .sex)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        middleName = try values.decodeIfPresent(String.self, forKey: .middleName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        nationalityIso3 = try values.decodeIfPresent(String.self, forKey: .nationalityIso3)
        expiry = try values.decodeIfPresent(String.self, forKey: .expiry)
        emiratesId = try values.decodeIfPresent(String.self, forKey: .emiratesId)
    }
}

