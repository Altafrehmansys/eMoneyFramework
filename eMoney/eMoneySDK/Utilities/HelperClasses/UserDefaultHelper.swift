//
//  UserDefaultHelper.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 02/05/2023.
//

import UIKit

private enum Defaults: String {
    case msisdn = "msisdn"
    case userSessionToken = "user_token"
    case userName = "user_name"
    case isLangSelected = "isLangSelected"
    case deviceId = "device_id"
    case userBiomatricToken = "user_pin_Biomatric"
    case userLoginPin = "user_login_pin"
    case showAddMoneyTrayOnBack = "show_addmoney_tray_on_back"
    case toolTipFirstTimeShow = "tooltip_first_time_show"
}

final class UserDefaultHelper {
    
    static var deviceId: String? {
        set{
            _set(value: newValue, key: .deviceId)
        } get {
            return _get(valueForKay: .deviceId) as? String
        }
    }
    
    static var msisdn: String? {
        set{
            _set(value: newValue, key: .msisdn)
        } get {
            return _get(valueForKay: .msisdn) as? String
        }
    }
    
    static var userSessionToken: String? {
        set{
            _set(value: newValue, key: .userSessionToken)
        } get {
            return _get(valueForKay: .userSessionToken) as? String
        }
    }
    
    static var userName: String? {
        set{
            _set(value: newValue, key: .userName)
        } get {
            return _get(valueForKay: .userName) as? String
        }
    }
    
    static var isLangSelected: Bool {
        set{
            _set(value: newValue, key: .isLangSelected)
        } get {
            return _get(valueForKay: .isLangSelected) as? Bool ?? false
        }
    }
    
    static var toolTipFirstTimeShow: Bool {
        set{
            _set(value: newValue, key: .toolTipFirstTimeShow)
        } get {
            return _get(valueForKay: .toolTipFirstTimeShow) as? Bool ?? false
        }
    }
    
    static var userBiomatricToken: String? {
        set{
            if let newString = newValue {
                let val = try? newString.aesEncrypt(key:EncryptionKey.pinKey)
                _set(value: val, key: .userBiomatricToken)
            }
        } get {
            if let val = _get(valueForKay: .userBiomatricToken) as? String{
                let str = try? val.aesDecrypt(key: EncryptionKey.pinKey)
                return str
            }
            return nil
        }
    }
    
    static var userLoginPin: String? {
        set{
            if let newString = newValue {
                let val = try? newString.aesEncrypt(key:EncryptionKey.pinKey)
                _set(value: val, key: .userLoginPin)
            }
        } get {
            if let val = _get(valueForKay: .userLoginPin) as? String {
                return val
            }
            return nil
        }
    }
    
    private static func _set(value: Any?, key: Defaults) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    private static func _get(valueForKay key: Defaults)-> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
//    static func deleteMsisdn() {
//        UserDefaults.standard.removeObject(forKey: Defaults.msisdn.rawValue)
//    }
    static func deleteUserSessionToken() {
        UserDefaults.standard.removeObject(forKey: Defaults.userSessionToken.rawValue)
    }
    static func deleteUsername() {
        UserDefaults.standard.removeObject(forKey: Defaults.userName.rawValue)
    }
    
}
