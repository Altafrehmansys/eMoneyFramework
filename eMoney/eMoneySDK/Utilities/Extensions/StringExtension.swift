//
//  StringExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 02/03/2023.
//

import Foundation
import UIKit
import CryptoSwift

extension String{
    
    var bool: Bool? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "1":
            return true
        case "false", "0":
            return false
        default:
            return nil
        }
    }
    
    var isDecimal: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        return Set(self).isSubset(of: nums)
    }
    
    var isValidIban: Bool {
        if self.isEmpty {
            return false
        }
        
        do {
            let regExPattern = "^(a|A)(e|E)\\d{21}$"
            let regEx = try NSRegularExpression(pattern: regExPattern, options: .caseInsensitive)
            let regExMatches = regEx.numberOfMatches(in: self, range: NSMakeRange(0, self.count))
            if regExMatches == 0 {
                return false
            }
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    var isCreditCardNumber: Bool {
        if self.isEmpty {
            return false
        }
        
        do {
            let regExPattern = "(?:\\d[ -]*?){13,16}"
            let regEx = try NSRegularExpression(pattern: regExPattern, options: .caseInsensitive)
            let regExMatches = regEx.numberOfMatches(in: self, range: NSMakeRange(0, self.count))
            if regExMatches == 0 {
                return false
            }
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}

extension String {
    func withBoldText(boldPartsOfString: [String],
                      font: UIFont,
                      boldFont: UIFont) -> NSAttributedString
    {
        let nonBoldFontAttribute = [NSAttributedString.Key.font: font]
        let boldFontAttribute = [NSAttributedString.Key.font: boldFont]
        let boldString = NSMutableAttributedString(string: self as String, attributes: nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
}
extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}
extension String {
    
    private func filterCharacters(unicodeScalarsFilter closure: (UnicodeScalar) -> Bool) -> String {
        return String(String.UnicodeScalarView(unicodeScalars.filter { closure($0) }))
    }
    
    private func filterCharacters(definedIn charSets: [CharacterSet], unicodeScalarsFilter: (CharacterSet, UnicodeScalar) -> Bool) -> String {
        if charSets.isEmpty { return self }
        let charSet = charSets.reduce(CharacterSet()) { return $0.union($1) }
        return filterCharacters { unicodeScalarsFilter(charSet, $0) }
    }
    
    func removeCharacters(charSets: [CharacterSet]) -> String { return filterCharacters(definedIn: charSets) { !$0.contains($1) } }
    func removeCharacters(charSet: CharacterSet) -> String { return removeCharacters(charSets: [charSet]) }
    
    func onlyCharacters(charSets: [CharacterSet]) -> String { return filterCharacters(definedIn: charSets) { $0.contains($1) } }
    func onlyCharacters(charSet: CharacterSet) -> String { return onlyCharacters(charSets: [charSet]) }
}

extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
extension String {
    var isMonotonous: Bool {
        var hash = [Character:Int]()
        self.forEach { hash[$0] = 1 }
        return hash.count < 2
    }
}

extension Array where Element == Int {
    func numbersAreConsecutive() -> Bool {
        for (num, nextNum) in zip(self, dropFirst())
        where (nextNum - num) != 1 { return false }
        return true
    }
}

extension String {
    var isOnlyAlpha: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
    var isOnlyNumbers: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }
    
    // Date Pattern MM/YY or MM/YYYY
    var isDate: Bool {
        let arrayDate = components(separatedBy: "/")
        if arrayDate.count == 2 {
            let currentYear = Calendar.current.component(.year, from: Date())
            if let month = Int(arrayDate[0]), let year = Int(arrayDate[1]) {
                if month > 12 || month < 1 {
                    return false
                }
                if year < (currentYear - 2000 + 20) && year >= (currentYear - 2000) { // Between current year and 20 years ahead
                    return true
                }
                if year >= currentYear && year < (currentYear + 20) { // Between current year and 20 years ahead
                    return true
                }
            }
        }
        return false
    }
}

extension String {
    func aesEncrypt(key: String) throws -> String {
        
        var result = ""
        
        do {
            
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            
            let aes = try! AES(key: key, blockMode: ECB() , padding:.pkcs5) // AES128 .ECB pkcs7
            
            let encrypted = try aes.encrypt(Array(self.utf8))
            
            result = encrypted.toBase64()
            
            
            print("AES Encryption Result: \(result)")
            
        } catch {
            
            print("Error: \(error)")
        }
        
        return result
    }
    
    func aesDecrypt(key: String) throws -> String {
        
        var result = ""
        
        do {
            
            let encrypted = self
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            let aes = try! AES(key: key, blockMode: ECB(), padding: .pkcs5) // AES128 .ECB pkcs7
            let decrypted = try aes.decrypt(Array(base64: encrypted))
            
            result = String(data: Data(decrypted), encoding: .utf8) ?? ""
            
            print("AES Decryption Result: \(result)")
            
        } catch {
            
            print("Error: \(error)")
        }
        
        return result
    }
}
extension String {
    func toDouble()->Double {
        return Double(self) ?? 0.0
    }
    func addCurrency()->String {
        //FIXME: Handle RTL case.
        if self.hasPrefix("AED") {
            return self
        }
        return "AED \(/Double(self)?.formattedAmountWithComma)"
    }
    func removeCountryCode() -> String {
        self.replace(string: "+971", replacement: "0")
    }
}
