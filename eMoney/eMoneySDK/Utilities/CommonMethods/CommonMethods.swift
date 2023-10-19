//
//  CommonMethods.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 07/03/2023.
//

import Foundation
import UIKit
import AVFoundation
//import CryptoSwift
import Photos

class CommonMethods: NSObject{
    class func codableToDictionary<T:Codable>(codableObject:T)-> [String: Any]
    {
        var params:[String: Any] = [:]// = Headers.shared.getRequestHeaders() as [String: AnyObject]
        
        let encoder = JSONEncoder()
        do {
            let data:Data = try encoder.encode(codableObject)
            params = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
        } catch {
            //handle error
        }
        return params
    }
    class func checkIfNumberChange(msisd : String) -> Bool {
        if GlobalData.shared.lastNumberInput == nil {
          return true
        }
        else if GlobalData.shared.lastNumberInput == msisd {
            
           return false
        }
        else {
            return true
        }
    }
    

    class func getFormattedMobileNumber(prefix:String,number :String) -> String {
        let prefix = prefix.onlyCharacters(charSet: .decimalDigits)
        let trimmed = number.removeWhitespace()
        let number = prefix + trimmed
        return number
    }
    

    static func getModelFromJsonFile<T : Decodable>(from fileName:String) throws -> T? {
        
        if let bundlePath = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.path(forResource: fileName, ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return try JSONDecoder().decode(T.self, from: jsonData)
        }
        
        return nil
    }
    
    static func setRootViewController(viewController:UIViewController){
        let basNav = BaseNavigationController.instantiate(fromAppStoryboard: .Onboarding)
        basNav.viewControllers = [viewController]
        guard let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        keyWindow.rootViewController = basNav
        keyWindow.makeKeyAndVisible()
    }
    
    static func setRootViewControllerWithoutNavigation(viewController: UIViewController) {
        guard let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        keyWindow.rootViewController = viewController
        keyWindow.makeKeyAndVisible()
    }
    
    static func disableDarkMode(){
        guard let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        keyWindow.overrideUserInterfaceStyle = .light
    }
    
    static func isValidatedByRegex(text:String, regex:String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
//    static func getUserPinInDefault() -> String? {
//        guard let userName = UserDefaults.standard.string(forKey: "user_pin") else {
//            return nil
//        }
//        return userName
//    }
    
    static func validateUAEMobileNumber(phoneNumber:String) -> Bool {
        var number = phoneNumber
        number = number.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
        number = number.replacingOccurrences(of: "(", with: "", options: .literal, range: nil)
        number = number.replacingOccurrences(of: ")", with: "", options: .literal, range: nil)
        number = number.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        if number.hasPrefix("+971") {
            number = String(number.dropFirst(4))
            number = "0" + number
        }
        if number.hasPrefix("00971") {
            number = String(number.dropFirst(5))
            number = "0" + number
        }
        
        return CommonMethods.isValidatedByRegex(text: phoneNumber, regex: "^(5)[0-9]{8,8}$")
    }
    
    static func validateUAEMobileNumberWithOutCode(phoneNumber:String,regex:String = "^(5)[0-9]{8,8}$") -> Bool {
        let num = CommonMethods.removeWhiteSpacesFromString(text: phoneNumber)
        return CommonMethods.isValidatedByRegex(text: num, regex: regex)
    }
    static func validateInternationalMobileNo(phoneNumber:String,regex:String) -> Bool {
        let num = CommonMethods.removeWhiteSpacesFromString(text: phoneNumber)
        return CommonMethods.isValidatedByRegex(text: num, regex: regex)
    }
    
    static func removeWhiteSpacesFromString(text:String) -> String {
        var trimmed = text
        trimmed = trimmed.replacingOccurrences(of: " ", with: "")
        trimmed = trimmed.replacingOccurrences(of: "(", with: "")
        trimmed = trimmed.replacingOccurrences(of: ")", with: "")
        return trimmed
    }
    
    static func getFormattedPhoneNumberWithOutCode(phoneNumber:String) -> String {
        var num = phoneNumber
        num.insert(" ", at: num.index(num.startIndex, offsetBy: 2))
        num.insert(" ", at: num.index(num.startIndex, offsetBy: 6))
        return num
    }
    
    static func getInternationalMobileNoFormatted(phoneNo:String) ->String {
        return phoneNo.replacingOccurrences(of: "(\\d{2})(\\d{3})(\\d+)", with: "$1 $2 $3", options: .regularExpression, range: nil)
    }
    
    static func getFormattedStringForPhoneNumberWithCode(phoneNumber:String) -> String {
        var codeString = "+971"
        var numberString = phoneNumber
        if phoneNumber.hasPrefix("+971") {
            numberString = phoneNumber.components(separatedBy: "+971").last ?? ""
        }else if phoneNumber.hasPrefix("0"){
            numberString.remove(at: phoneNumber.startIndex)
        }

        numberString.insert(" ", at: numberString.index(numberString.startIndex, offsetBy: 2))
        numberString.insert(" ", at: numberString.index(numberString.startIndex, offsetBy: 6))
        
        
        return codeString + " " + numberString
    }
    
    static func showInternetConnectionErrorScreen(){
        if let topVC = UIApplication.getTopViewController() as? BaseViewController {
            topVC.showInternetErrorScreen()
        }
    }
//    static func loadJSON(withFilename filename: String) throws -> Any? {
//        let fm = FileManager.default
//        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
//        if let url = urls.first {
//            var fileURL = url.appendingPathComponent(filename)
//            fileURL = fileURL.appendingPathExtension("json")
//            let data = try Data(contentsOf: fileURL)
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
//            return jsonObject
//        }
//        return nil
//    }
//
//    static func save(jsonObject: Any, toFilename filename: String) throws -> Bool{
//        let fm = FileManager.default
//        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
//        if let url = urls.first {
//            var fileURL = url.appendingPathComponent(filename)
//            fileURL = fileURL.appendingPathExtension("json")
//            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
//            try data.write(to: fileURL, options: [.atomicWrite])
//            return true
//        }
//
//        return false
//    }
    
    
    static func checkCameraAccess(completion: @escaping (_ success:Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
            completion(false)
        case .restricted:
            print("Restricted, device owner must approve")
            completion(false)
        case .authorized:
            print("Authorized, proceed")
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                    completion(true)
                } else {
                    print("Permission denied")
                    completion(false)
                }
            }
        @unknown default:
            break
        }
    }

    static func presentCameraSettings() {
        let alertController = UIAlertController(title: "noti_permision_title".localized,
                                                message: "emoney_accesscamera".localized,
                                      preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "cancel".localized, style: .default))
        alertController.addAction(UIAlertAction(title: "settings".localized, style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })

        if let topVC = UIApplication.getTopViewController() as? BaseViewController {
            topVC.present(alertController, animated: true)
        }
    }
    
    static func checkGalleryAccess(completion: @escaping (_ success:Bool) -> Void) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // Request read-write access to the user's photo library.
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .notDetermined:
                        completion(false)
                    case .restricted:
                        completion(false)
                    case .denied:
                        print("Denied, request permission from settings")
                        presentGallerySettings()
                        completion(false)
                    case .authorized:
                        completion(true)
                        
                    case .limited:
                        completion(false)
                    @unknown default:
                        fatalError()
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    static func presentGallerySettings() {
        let alertController = UIAlertController(title: "noti_permision_title".localized,message: "Please grant permission to use the Gallery so that you can select your QR Code Photo.".localized,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "cancel".localized, style: .default))
        alertController.addAction(UIAlertAction(title: "settings".localized, style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
    }
    static func openSettingsForFaceId(title:String,message:String) {
        let alertController = UIAlertController(title: title.localized,
                                                message: message.localized,
                                      preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "cancel".localized, style: .default))
        alertController.addAction(UIAlertAction(title: "settings".localized, style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })

        //present(alertController, animated: true)
    }
    class func openMessagesApp(withReceiver receiver: String, messageText: String) {
        guard let url = URL(string: "sms:\(receiver)&body=\(messageText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            print("Failed to create URL for opening Messages app.")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Failed to open Messages app.")
        }
    }
    class func openURL(_ url:URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Failed to open Messages app.")
        }
    }
    class func callCustomerSpport() {
        let phoneNumber = "8003925538"
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
          let application:UIApplication = UIApplication.shared
          if (application.canOpenURL(phoneCallURL)) {
              application.open(phoneCallURL, options: [:], completionHandler: nil)
          }
        }
      }
}
