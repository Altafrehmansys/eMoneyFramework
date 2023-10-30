//
//  RegistrationRequestModel.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 02/05/2023.
//

import Foundation

class RegistrationRequestModel:Codable{
    
    var msisdn:String?
    var otp:String?
    var email:String?
    var pin:String?
    var dateOfBirth:String?
    var nationality:String?
    var fullName:String?
    var idNumber:String?
    var idExpiryDate:String?
    var firstName:String?
    var middleName:String?
    var lastName:String?
    var nationalitySuffix:String?
    var gender:String?
    var isSingleAccount:Bool?
    var profileName:String?
    var cacheFlow: Bool?
}

class ResetPinRequestModel:Codable{
    
    var repeatNewPin:String?
    var otp:String?
    var newPin:String?
    var pin:String?
    var flowName: String?
    var transactionId: String?
    var credentialType: String?
}


