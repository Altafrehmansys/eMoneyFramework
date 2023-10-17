//
//  EFRServerValidationRequest.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 25/04/2023.
//

import Foundation

class EFRServerValidationRequest:Codable{
    
    var faces:[EFRServerValidationFaces]?
    var pin:String?
    var screenName:String?
    var sourcePlatform:String?
    
    var isSingleAccount:Bool?
    var previousProfileName:String?
    var profileName:String?
    
    var gender:String?
    var expiryDate:String?
    var registrantNumber:String?
    var dateOfBirth:String?
    var fullName:String?
    var nationality:String?
    var firstName:String?
    var middleName:String?
    var lastName:String?
}

class EFRServerValidationFaces:Codable{
    var data:String?
    var dataHash:String?
}
