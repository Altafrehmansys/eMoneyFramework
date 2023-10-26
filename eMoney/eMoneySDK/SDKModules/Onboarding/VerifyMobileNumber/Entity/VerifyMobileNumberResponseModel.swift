//
//  VerifyMobileNumberResponseModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation

enum UserJourneyFlow {
    case forgotPin
    case onboarding
}
struct InitiatePinRequestModel:Codable{
    var resendFlag:Bool?
    var isSecretQuestionSkip:Bool?
    var isUnblockFlow:Bool?
}

struct VerifyMobileNumberOtpSendRequestModel:Codable{
    var isSingleAccount:Bool?
    var msisdn:String?
    var identity:String?
//    var flowName:String?
}

struct VerifyMobileNumberOtpVerifyRequestModel:Codable{
    var otp:String?
    var msisdn:String?
    var status:String?
//    var flowName:String?
}

class VerifyMobileNumberResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    var data: OtpSendData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(OtpSendData.self   , forKey: .data)
        try super.init(from: decoder)
    }
    

}

class OtpSendData: Codable {
    let message: String?
    let isBlocked: Bool?
    let remainingTimeInSeconds: Int?
    let remainingReattemptTimeInSeconds: Int?
    let email: String?
   

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case isBlocked = "isBlocked"
        case remainingTimeInSeconds = "remainingTimeInSeconds"
        case remainingReattemptTimeInSeconds = "remainingReattemptTimeInSeconds"
        case email = "email"
       
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        isBlocked = try values.decodeIfPresent(Bool.self, forKey: .isBlocked)
        remainingTimeInSeconds = try values.decodeIfPresent(Int.self, forKey: .remainingTimeInSeconds)
        remainingReattemptTimeInSeconds = try values.decodeIfPresent(Int.self, forKey: .remainingReattemptTimeInSeconds)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }
    
}


class InitiatePinResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    
    var data: InitiatePinDataResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(InitiatePinDataResponseModel.self   , forKey: .data)
        try super.init(from: decoder)
    }
   
}

class InitiatePinDataResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    
    var questionText: String?
    var responseMsg: String?
    var questionId: String?
    var email: String?
    let isBlocked: Bool?
    let remainingTimeInSeconds: Int?
    


    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case questionText
        case responseMsg
        case questionId
        case email
        case isBlocked
        case remainingTimeInSeconds
    }

    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        questionText = try values.decodeIfPresent(String.self, forKey: .questionText)
        responseMsg = try values.decodeIfPresent(String.self, forKey: .responseMsg)
        questionId = try values.decodeIfPresent(String.self, forKey: .questionId)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        isBlocked = try values.decodeIfPresent(Bool.self, forKey: .isBlocked)
        remainingTimeInSeconds = try values.decodeIfPresent(Int.self, forKey: .remainingTimeInSeconds)
        try super.init(from: decoder)
    }
}
