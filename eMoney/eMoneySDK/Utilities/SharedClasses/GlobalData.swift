//
//  GlobalData.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 23/04/2023.
//

import Foundation
import UIKit

final class GlobalData: NSObject {
    static let shared = GlobalData()
    
    private override init() { }
    
    //Registration related variables
    var msisdn:String?
    var status:String?
    var otp:String?
    var lastNumberInput:String?
    var timeCounter = 0
    var msisdnStatusData:RegisterMobileNumberData?
    var isVerified = false
    
    var livenessViewLoaded = false
    var userEidInfo:OCRAnalyzeData?
    var registrationType:RegistrationType?
    var livenesRetriesLeft = 3
    var isSingleAccount:Bool = false
    var userEmail:String?
    
    var keyAndConfiguration:EFRKeyAndConfigResponseModel?
    var registerAsAMLFailed:Bool = false
    
    var isDeviceChanged:Bool = false
    
    var loginData:LoginData? {
        didSet{
            userProfile = UserProfile(rawValue: loginData?.profileName ?? "")
        }
    }
    
    var availableBalance:AvailableBalanceData?
    
    var userProfile:UserProfile?
    var addMoneyMetaDataResponse: AddMoneyMetaDataResponseModel?
    
    var isUpgradeRequired:Bool {
        let upgradeScreen = UpgradeScreen(rawValue: loginData?.upgradeScreen ?? "none") ?? .none
        let eidSuspended = loginData?.isEIDSuspended ?? false
        if upgradeScreen != .none && !eidSuspended {
            return true
        }
        return false
    }
    
    var frontImage:UIImage?
    var backImage:UIImage?
}
