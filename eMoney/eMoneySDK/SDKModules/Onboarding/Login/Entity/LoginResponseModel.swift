//
//  LoginResponseModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

class LoginRequestModel: Codable {
    var isNewLogin:Bool?
    var pin:String?
}

class LoginResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
   
    var data : LoginData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}
class LoginData: Codable {
    let result, userToken, fullName: String?
    let isDigitalKyc: Bool?
    var profileName, upgradeToProfile, upgradeScreen: String?
    let isSingleAccount, isEIDSuspended: Bool?
    let flowName: String?
    let isFirstLogin: Bool?
    let loyaltypointsaccountsfri, fri: String?
    var oldDeviceId:String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case userToken = "userToken"
        case fullName = "fullName"
        case profileName = "profileName"
        case upgradeToProfile = "upgradeToProfile"
        case upgradeScreen = "upgradeScreen"
        case flowName = "flowName"
        case loyaltypointsaccountsfri = "loyaltypointsaccountsfri"
        case fri = "fri"
        case isDigitalKyc = "isDigitalKyc"
        case isSingleAccount = "isSingleAccount"
        case isEIDSuspended = "isEIDSuspended"
        case isFirstLogin = "isFirstLogin"
        case oldDeviceId = "oldDeviceId"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        profileName = try values.decodeIfPresent(String.self, forKey: .profileName)
        upgradeToProfile = try values.decodeIfPresent(String.self, forKey: .upgradeToProfile)
        upgradeScreen = try values.decodeIfPresent(String.self, forKey: .upgradeScreen)
        
        flowName = try values.decodeIfPresent(String.self, forKey: .flowName)
        loyaltypointsaccountsfri = try values.decodeIfPresent(String.self, forKey: .loyaltypointsaccountsfri)
        fri = try values.decodeIfPresent(String.self, forKey: .fri)
        
        isDigitalKyc = try values.decodeIfPresent(Bool.self, forKey: .isDigitalKyc)
        isSingleAccount = try values.decodeIfPresent(Bool.self, forKey: .isSingleAccount)
        isEIDSuspended = try values.decodeIfPresent(Bool.self, forKey: .isEIDSuspended)
        isFirstLogin = try values.decodeIfPresent(Bool.self, forKey: .isFirstLogin)
        oldDeviceId = try values.decodeIfPresent(String.self, forKey: .oldDeviceId)
    }
    
}
