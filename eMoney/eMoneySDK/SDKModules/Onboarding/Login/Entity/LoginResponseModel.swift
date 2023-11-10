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


public class LoginModel {
    public let result, userToken, fullName: String?
    public let isDigitalKyc: Bool?
    public var profileName: String?
    public let isSingleAccount, isEIDSuspended: Bool?
    public let isFirstLogin: Bool?
    public let loyaltyPointsAccountsFri, fri: String?
    public let oldDeviceId:String?
    public var pin: String
    public var retriesLeft: Int?
    public var remainingDays: Int?
    public var noOfDaysPendingForPhysicalVer: Int?
    public var upgradeScreen: String?
    public var upgradeToProfile: String?
    public var flowName: String?
    public var survey: String?
    public var errors: [String]?
    
    
    init(withLoginData data: LoginData, pin: String) {
        self.result = data.result
        self.userToken = data.userToken
        self.fullName = data.fullName
        self.isDigitalKyc = data.isDigitalKyc
        self.profileName = data.profileName
        self.isSingleAccount = data.isSingleAccount
        self.isEIDSuspended = data.isEIDSuspended
        self.isFirstLogin = data.isFirstLogin
        self.loyaltyPointsAccountsFri = data.loyaltypointsaccountsfri
        self.fri = data.fri
        self.oldDeviceId = data.oldDeviceId
        self.pin = pin
        self.upgradeScreen = data.upgradeScreen
        self.upgradeToProfile = data.upgradeToProfile
        self.flowName = data.flowName
    }
}

public class BaseResponse {
    public let responseCode: Int = 0
    public var responseMessage: String?
    public var title: String?
    public var message: String?
    public var displayAppRating: Bool?
    public let data: LoginModel
    
    init(withLoginData data: LoginData, pin: String) {
        let loginData = LoginModel.init(withLoginData:data, pin: pin)
        self.data = loginData
        self.responseMessage = nil
        self.displayAppRating = false
        self.message = nil
        self.title = nil
    }
}
