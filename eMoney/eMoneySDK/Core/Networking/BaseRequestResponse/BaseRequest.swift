//
//  BaseRequest.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 07/03/2023.
//
import UIKit
import Foundation


class BaseRequest:Codable{
    
    var buildNumber : String?
    var osVersion : String?
    var osType : String?
    var lang: String?
    var deviceId : String?
    var userToken : String?
    var msisdn : String?
    var identity : String?
    var fcmToken : String?
    var processId : String?
    var flowName : String?
    var resourceName : String?
    var code : String?
    
//    {
//      "buildNumber": 0,
//      "deviceId": "string",
//      "fcmToken": "string",
//      "flowName": "string",
//      "languageCode": "en",
//      "osType": "string",
//      "osVersion": "string",
//      "processId": 0
//    }
//
    init() {
        self.buildNumber = "266"
//        self.buildNumber = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.releaseBuildNumber
        self.osVersion = UIDevice.current.systemVersion
        self.osType = "iOS"
        self.lang = LocaleManager.shared.appLocale
        self.deviceId = getDeviceId()
        if let msisdn = SDKColors.shared.msisdn?.planPhoneNumberString {
            self.msisdn = msisdn
            self.identity = msisdn
        }
        
        if let flowName = SDKColors.shared.flowName {
            self.flowName = flowName
        }
//        if let msisdn = UserDefaultHelper.msisdn {
//            self.msisdn = msisdn
//            self.identity = msisdn
//        }else if let msisdn = GlobalData.shared.msisdn {
//            self.msisdn = msisdn
//            self.identity = msisdn
//        }
        if let processId = GlobalData.shared.msisdnStatusData?.processId {
            self.processId = processId
        }
//        if let flowName = GlobalData.shared.msisdnStatusData?.flowName {
//            self.flowName = flowName
//        }else if let flowName = GlobalData.shared.loginData?.flowName {
//            self.flowName = flowName
//        }
        if let partnerName = SDKColors.shared.partnerName {
            self.code = partnerName
        }
        
        self.fcmToken = "abcd"
        self.userToken = UserDefaultHelper.userSessionToken
        
    }
    
    func getDeviceId() -> String{
        if UserDefaultHelper.deviceId == nil {
            if let uuid = UIDevice.current.identifierForVendor?.uuidString {
                UserDefaultHelper.deviceId = String(format: "%d-%@", Int64(Date().timeIntervalSince1970),uuid)
            }else{
                UserDefaultHelper.deviceId = "0000000000000000000000000000404"
            }
        }
        return UserDefaultHelper.deviceId ?? ""
        
    }
}
