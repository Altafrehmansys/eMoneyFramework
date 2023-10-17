//
//  UpdateDocumentRequestModel.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 24/07/2023.
//

import Foundation

struct UpdateDocumentRequestModel:Codable{
    var gender:String?
    var expiryDate:String?
    var eidNumber:String?
    var dateOfBirth:String?
    var fullName:String?
    var nationality:String?
    var profileName:String?
    var previousProfileName:String?
    var isSingleAccount:Bool?
    var pin:String?
    var userId:String?
    var firstName:String?
    var secondName:String?
    var lastName:String?
    var otp:String?

}

