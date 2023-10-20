//
//  LocaleManager.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/03/2023.
//

import Foundation
import UIKit

//enum LanguageFileName{
//    static let langEn = "LangEn"
//    static let langAr = "LangAr"
//}
private let APPLE_LANGUAGE_KEY = "AppleLanguages"

class LocaleManager {
    static let shared: LocaleManager = LocaleManager()
    
    private var languageInfo:LanguageInformation?
    private var languagePack:[String:String] = [:]
    
    private var langFileName:String{
        return getFileName()
    }
    
    private init() {
    }
    
    var appLocale:String {
        get{
            LocaleManager.currentLanguage()
        }
    }
    
    func getString(key:String) -> String {
        if let val = languagePack[key],!val.isEmpty {
            return val
        }
        return key
    }
    
    func loadLanguagePack(){
        print("Language file Name: \(langFileName)")
        let langData = [String:LanguagePackData].load(fromFileName: langFileName) ?? [:]
        
        languageInfo = langData["langData"]?.languageInformation
        languagePack = langData["langData"]?.languagePack ?? [:]
    }
    
    func saveLanguagePack(data:LanguagePackData){
        languageInfo = data.languageInformation
        languagePack = data.languagePack ?? [:]
        
        let langData:[String:LanguagePackData] = ["langData":data]
        do {
            try langData.saveToDisk(withName: langFileName)
        } catch {
            print(error.localizedDescription)
        }
    }


    
    func isLanguageUpdateRequired(serverVersion:String) -> Bool{
        let appVersion = self.languageInfo?.languageVersion ?? ""
        if serverVersion.compare(appVersion, options: .numeric) == .orderedDescending {
            return true
        }
        return false
    }
    
    func getLanguagePackFromServer(langCode:String? = nil) async -> Bool{
        do {
            let response:LanguagePackResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.languagePack(langCode: langCode))
            if let langData = response?.data {
//                let appVersion = self.languageInfo?.languageVersion ?? ""
//                let serverVersion = langData.languageInformation?.languageVersion ?? ""
//                if serverVersion.compare(appVersion, options: .numeric) == .orderedDescending {
                    self.saveLanguagePack(data: langData)
//                }
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    private func getFileName() -> String{
        switch appLocale{
        case LanguageCode.english.rawValue:
            return LanguageFileName.english.rawValue
        case LanguageCode.arabic.rawValue:
            return LanguageFileName.arabic.rawValue
        default:
            return LanguageFileName.english.rawValue
        }
    }
    
    func LoadLanguagePackFromLocalFile() {
        do {
            for fileName in LanguageFileName.allCases {
                print("LoadLanguage from local\n fileName: \(fileName)")
                if let bundlePath = Bundle.main.path(forResource: fileName.rawValue, ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    print("Get data from local file")
                    let decodedData = try JSONDecoder().decode(LanguagePackResponseModel.self, from: jsonData)
                    print("Data Decode")
                    if let langData = decodedData.data {
                        print("Get data")
                        try ["langData":langData].saveToDisk(withName: fileName.rawValue)
                        print("Language saved to disk")
                        if fileName.rawValue == getFileName(){
                            print("Load language pack data \(langData.languagePack)")
                            languageInfo = langData.languageInformation
                            languagePack = langData.languagePack ?? [:]
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}


extension LocaleManager {
    /// get current app language
    public class func currentLanguage() -> String {
        let current = preferredLanguage.first!
        if let hyphenIndex = current.firstIndex(of: "-") {
            return String(current[..<hyphenIndex])
        } else {
            return current
        }
    }
    /**
     Get the current language with locae e.g. ar-KW
     @return language identifier string
     */
    private class func currentLocaleIdentifier() -> String {
        let current = preferredLanguage.first!
        return current
    }
    
    /// set @lang to be the first in AppleLanguages list
    public class func setAppleLanguageTo(_ lang: String) {
        
        let isLanguageRTL = Locale.characterDirection(forLanguage: lang) == .rightToLeft
        
        UIView.appearance().semanticContentAttribute = isLanguageRTL == true ? .forceRightToLeft : .forceLeftToRight
        let userDefaults = UserDefaults.standard
        userDefaults.set(isLanguageRTL,   forKey: "AppleTe  zxtDirection")
        userDefaults.set(isLanguageRTL,   forKey: "NSForceRightToLeftWritingDirection")
        userDefaults.set([lang,currentLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userDefaults.synchronize()
        LocaleManager.DoTheMagic()
        LocaleManager.shared.loadLanguagePack()
    }
    
    /**
     Check if the current language is a right to left language
     
     @return true if its a right to left language
     */
    public static func isRTLLanguage() -> Bool {
        let isLanguageRTL = Locale.characterDirection(forLanguage: currentLanguage()) == .rightToLeft
        return isLanguageRTL
//        return !RTLLanguages.filter{$0 == currentLocaleIdentifier() || $0 == currentLanguage()}.isEmpty
    }
    
//    /**
//     Check if the current language is a right to left language
//
//     @param language to be tested
//     @return true if its a right to left language
//     */
//    public static func isRTLLanguage(language: String) -> Bool {
//        return !RTLLanguages.filter{language == $0}.isEmpty
//    }
    
    private static let RTLLanguages = ["ar",
                                       "fa",
                                       "he",
                                       "ckb-IQ",
                                       "ckb-IR",
                                       "ur",
                                       "ckb",
                                       "ku"]
    
    private static var preferredLanguage: [String] {
        let userDefaults = UserDefaults.standard
        let langArray = userDefaults.object(forKey: APPLE_LANGUAGE_KEY)
        return langArray as? [String] ?? []
    }
    
    private static func DoTheMagic() {
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
    }
}

/// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    if let origMethod: Method = class_getInstanceMethod(cls, originalSelector),  let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector){
        if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
            class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, overrideMethod);
        }
    }
}
