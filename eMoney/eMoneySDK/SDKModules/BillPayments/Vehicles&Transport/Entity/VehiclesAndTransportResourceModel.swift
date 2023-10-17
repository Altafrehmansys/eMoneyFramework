//
//  VehiclesAndTransportDetailResponseModel.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
class VehiclesAndTransportValidateModel:BaseResponseModel {
    var data:FinePayBillsResponse?
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(FinePayBillsResponse.self, forKey: .data)
        try super.init(from: decoder)
    }
}
        
class VehiclesAndTransportResourceModel: BaseResponseModel {
    
    // MARK: - Model Variables
    var data:[VehicleResource]?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([VehicleResource].self, forKey: .data)
        try super.init(from: decoder)
    }
}

class VehicleResource:Codable {
    // MARK: - Model Variables
    var id: Int?
    var title: String?
    var imageURL: String?
    var isCharity: Bool?
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case id,title,imageURL,isCharity
    }
    // MARK: - Model mapping
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        isCharity = try values.decodeIfPresent(Bool.self, forKey: .isCharity)
    }
}

class VehiclesAndTransportLookupModel: BaseResponseModel {
    
    // MARK: - Model Variables
    var data:[VehicleLookup]?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([VehicleLookup].self, forKey: .data)
        try super.init(from: decoder)
    }
}

class VehicleLookup:Codable {
    // MARK: - Model Variables
    var id: String?
    var value: String?
    var name: String?
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case id,value,name
    }
    // MARK: - Model mapping
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try? values.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }else if let id = try? values.decodeIfPresent(Int.self, forKey: .id){
            self.id = String(id)
        }
        id = try values.decodeIfPresent(String.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}

// MARK: - FinePayBillsReponse
struct FinePayBillsResponse: Codable {
    var transactionID, providerReferenceID: String?
    var serviceDetails: [ServiceDetail]?

    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionId"
        case providerReferenceID = "providerReferenceId"
        case serviceDetails
    }
}

// MARK: - ServiceDetail
struct ServiceDetail: Codable {
    var date, amount, penaltyFineAmount, transactionFee: String?
    var issuedBy: String?
    var additionalInfo: [AdditionalInfo]?
    var fineNumber, title: String?
    var paymentDetails: [AdditionalInfo]?
    var paidAmount, ticketFineAmount: String?
    var isSelected = false
    enum CodingKeys: String, CodingKey {
        case date, amount, penaltyFineAmount, transactionFee,issuedBy,additionalInfo,fineNumber,title,paymentDetails,paidAmount, ticketFineAmount
    }
}

// MARK: - AdditionalInfo
struct AdditionalInfo: Codable {
    var name, value: String?
}
