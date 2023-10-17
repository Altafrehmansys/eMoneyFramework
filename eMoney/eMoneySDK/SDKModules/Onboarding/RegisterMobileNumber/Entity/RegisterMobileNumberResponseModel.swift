//
//  RegisterMobileNumberResponseModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation


struct RegisterMobileNumberRequestModel:Codable{
    var msisdn:String?
    var identity:String?
}

class RegisterMobileNumberResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
   
    var data : RegisterMobileNumberData?
   
    enum CodingKeys: String, CodingKey {

        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(RegisterMobileNumberData.self, forKey: .data)
        try super.init(from: decoder)
    }

}

class RegisterMobileNumberData: Codable {
    var status : String?
    var oldDeviceId : String?
    var isSingleAccount : Bool?
    var flowName : String?
    var processId : String?
    var eidEnable : Bool?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case oldDeviceId = "oldDeviceId"
        case isSingleAccount = "isSingleAccount"
        case processId = "processId"
        case flowName = "flowName"
        case eidEnable = "eidEnable"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        oldDeviceId = try values.decodeIfPresent(String.self, forKey: .oldDeviceId)
        isSingleAccount = try values.decodeIfPresent(Bool.self, forKey: .isSingleAccount)
        flowName = try values.decodeIfPresent(String.self, forKey: .flowName)
        processId = try values.decodeIfPresent(String.self, forKey: .processId)
        eidEnable = try values.decodeIfPresent(Bool.self, forKey: .eidEnable)
    }
    
    init() {
    }
}
