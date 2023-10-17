//
//  Environment.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 02/03/2023.
//

import Foundation

//public enum Environment {
//    // MARK: - Keys
//
//    enum Keys {
//        enum Plist {
//            static let SERVER_URL = "SERVER_URL"
//            static let LOG_ENABELED = "NSLOG_ENABLED"
//            static let FCM_CONFIG_PLIST = "FCM_CONFIG_PLIST"
//            static let ADJUST_ENVIRONMENT = "ADJUST_ENVIRONMENT"
//            static let ADJUST_LOGLEVEL = "ADJUST_LOGLEVEL"
//            static let ADJUST_APPTOKEN = "ADJUST_APPTOKEN"
//            static let LEAN_APP_TOKEN = "LEAN_APP_TOKEN"
//            static let IS_LEAN_SANDBOX_ENABLED = "IS_LEAN_SANDBOX_ENABLED"
//            static let ENVIRONMENT_NAME = "ENVIRONMENT_NAME"
//        }
//    }
//
//    // MARK: - Plist
//
//    private static let infoDictionary: [String: Any] = {
//        guard let dict = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.infoDictionary else {
//            fatalError("Plist file not found")
//        }
//        return dict
//    }()
//
//    // MARK: - Plist values
//
//    static let serverURL: String = {
//        guard var rootURLstring:String = Environment.infoDictionary[Keys.Plist.SERVER_URL] as? String  else {
//            fatalError("Root URL not set in plist for this environment")
//        }
//        rootURLstring = rootURLstring.replacingOccurrences(of: "\\", with: "")
//        return rootURLstring
//    }()
//
//    static let logsEnabled: Bool = {
//        guard let logsString = Environment.infoDictionary[Keys.Plist.LOG_ENABELED] as? String,let logBool = logsString.bool   else {
//            fatalError("LogEnabled not set in plist for this environment")
//        }
//        return logBool
//    }()
//
//    static let FCMConfigPlist: String = {
//        guard let fcmPlistName = Environment.infoDictionary[Keys.Plist.FCM_CONFIG_PLIST] as? String else {
//            fatalError("Root URL not set in plist for this environment")
//        }
//        return fcmPlistName
//    }()
//
//    static let adjustEnvironment: String = {
//        guard let envoirmentString = Environment.infoDictionary[Keys.Plist.ADJUST_ENVIRONMENT] as? String else {
//            fatalError("customHeader not set in plist for this environment")
//        }
//        return envoirmentString
//    }()
//
//    static let adjustLogLevel: Int = {
//        guard let loglevel = Environment.infoDictionary[Keys.Plist.ADJUST_LOGLEVEL] as? Int else {
//            fatalError("customHeader not set in plist for this environment")
//        }
//        return loglevel
//    }()
//
//    static let AdjustAppToken: String = {
//        guard let adjustTokeString = Environment.infoDictionary[Keys.Plist.ADJUST_APPTOKEN] as? String else {
//            fatalError("customHeader not set in plist for this environment")
//        }
//        return adjustTokeString
//    }()
//
//    static let leanAppToken: String = {
//        guard let leanAppToken = Environment.infoDictionary[Keys.Plist.LEAN_APP_TOKEN] as? String else {
//            fatalError("customHeader not set in plist for this environment")
//        }
//        return leanAppToken
//    }()
//
//    static let isLeanSandboxEnabled: Bool = {
//        guard let isSanboxEnabledString = Environment.infoDictionary[Keys.Plist.IS_LEAN_SANDBOX_ENABLED] as? String,let isSanboxEnabled = isSanboxEnabledString.bool else {
//            fatalError("customHeader not set in plist for this environment")
//        }
//        return isSanboxEnabled
//    }()
//
//    static let name: EnvoirmentName = {
//        guard var envoName:String = Environment.infoDictionary[Keys.Plist.ENVIRONMENT_NAME] as? String  else {
//            fatalError("environmentName not set in plist for this environment")
//        }
//        envoName = envoName.replacingOccurrences(of: "\\", with: "")
//        return EnvoirmentName(rawValue: envoName) ?? .UAT
//    }()
//}
