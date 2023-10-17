//
//  AESDataEncryption.swift
//  e&money
//
//  Created by Qamar Iqbal on 13/06/2023.
//

import Foundation
import CommonCrypto

class AESDataEncryption {
    
    private static let kChosenCipherBlockSize = kCCBlockSizeAES128
    private static let kChosenCipherKeySize = kCCKeySizeAES128
    private static let kChosenDigestLength = Int(CC_SHA1_DIGEST_LENGTH)
    private static let kDCSecretKeyForEncryption = "v%Ww9_#|f3xAG#:-"
    
    static func AESEncrypt(for secretText: String) -> Data? {
        var padding = CCOptions(kCCOptionPKCS7Padding)
        
        guard let secretKeyData = kDCSecretKeyForEncryption.data(using: .utf8),
              let secretTextData = secretText.data(using: .utf8) else {
            return nil
        }
        
        return doCipher(secretTextData, key: secretKeyData, context: CCOperation(kCCEncrypt), padding: &padding)
    }
    
    static func AESDecrypt(for encryptedData: Data) -> String? {
        var padding = CCOptions(kCCOptionPKCS7Padding)
        
        guard let secretKeyData = kDCSecretKeyForEncryption.data(using: .utf8) else {
            return nil
        }
        
        guard let decryptedTextData = doCipher(encryptedData, key: secretKeyData, context: CCOperation(kCCDecrypt), padding: &padding) else { return "" }
        return String(bytes: decryptedTextData, encoding: .utf8)
    }
    
    private static func doCipher(_ plainText: Data, key: Data, context: CCOperation, padding: inout CCOptions) -> Data? {
        var ccStatus = CCCryptorStatus(kCCSuccess)
        var thisEncipher: CCCryptorRef?
        var cipherOrPlainText: Data?
        var bufferPtr: UnsafeMutablePointer<UInt8>?
        var bufferPtrSize: Int = 0
        var remainingBytes: Int = 0
        var movedBytes: Int = 0
        var plainTextBufferSize: Int = 0
        var totalBytesWritten: Int = 0
        var ptr: UnsafeMutablePointer<UInt8>?
        
        var iv = Array<UInt8>(repeating: 0x0, count: kChosenCipherBlockSize)
        
        plainTextBufferSize = plainText.count
        
        if context == kCCEncrypt {
            if padding != kCCOptionECBMode {
                if (plainTextBufferSize % kChosenCipherBlockSize) == 0 {
                    padding = 0x0000
                } else {
                    padding = CCOptions(kCCOptionPKCS7Padding)
                }
            }
        } else if context != kCCDecrypt {
            return nil
        }
        
        ccStatus = CCCryptorCreate(context,
                                   CCAlgorithm(kCCAlgorithmAES128),
                                   padding,
                                   (key as NSData).bytes,
                                   kChosenCipherKeySize,
                                   &iv,
                                   &thisEncipher
                                   )
        
        bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true)
        bufferPtr = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferPtrSize)
        bufferPtr?.initialize(repeating: 0x0, count: bufferPtrSize)
        
        ptr = bufferPtr
        
        remainingBytes = bufferPtrSize
        
        ccStatus = CCCryptorUpdate(thisEncipher,
                                   (plainText as NSData).bytes,
                                   plainTextBufferSize,
                                   ptr,
                                   remainingBytes,
                                   &movedBytes
                                   )
        
//        ptr += movedBytes
        remainingBytes -= movedBytes
        totalBytesWritten += movedBytes
        
        ccStatus = CCCryptorFinal(thisEncipher,
                                  ptr,
                                  remainingBytes,
                                  &movedBytes
                                  )
        
        totalBytesWritten += movedBytes
        
        if thisEncipher != nil {
            CCCryptorRelease(thisEncipher!)
            thisEncipher = nil
        }
        
        if ccStatus == kCCSuccess {
            cipherOrPlainText = Data(bytes: bufferPtr!, count: totalBytesWritten)
        } else {
            cipherOrPlainText = nil
        }
        
        bufferPtr?.deinitialize(count: bufferPtrSize)
        bufferPtr?.deallocate()
        
        return cipherOrPlainText
    }
    
    static func AES128Encrypt(with secretText: String) -> String? {
        guard let encryptedData = AESEncrypt(for: secretText) else {
            return nil
        }
        
        let encryptedString = encryptedData.base64EncodedString(options: [])
        return encryptedString
    }
}
