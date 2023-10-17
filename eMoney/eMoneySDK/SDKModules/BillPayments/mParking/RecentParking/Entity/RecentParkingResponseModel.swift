//
//  RecentParkingResponseModel.swift
//  e&money
//
//  Created by Usama Zahid Khan on 15/06/2023.
//  
//

import Foundation

class RecentParkingResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    
    var data: [Parking]?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Parking].self, forKey: .data)
        try super.init(from: decoder)
    }
}
// MARK: - VehicleDetail
// MARK: - Parking
struct Parking: Codable {
    var vehicleDetail: VehicleDetail?
    var parkingRegion, parkingZone: String?
    var noOfHours: Double?
    var parkingType, dateTime: String?
    var timeLeft:String {
        return "\(Int(/self.noOfHours)) \(Strings.BillPayment.hours)"
    }
    var regionWithZone:String {
        return "\(/self.parkingRegion) \(/self.parkingZone)"
    }
    var numberPlate:String {
        let region = /self.vehicleDetail?.additionalInfo?.first(where: { $0.name == "region"})?.value
        return "\(/self.vehicleDetail?.accountTitle) \(region) \(/self.vehicleDetail?.accountNumber)"
    }
//    var formattedDate:String {
//        return self.dateTime?.format(to: <#T##String#>)
//    }
    enum CodingKeys: String, CodingKey {
        case vehicleDetail, parkingRegion, parkingZone
        case noOfHours, parkingType, dateTime
    }
}

// MARK: - VehicleDetail
struct VehicleDetail: Codable {
    var id: Int?
    var accountNumber, accountTitle: String?
    var billTypeID: Int?
    var billTypeName: String?
    var parentBillType: Int?
    var additionalInfo: [VehicleDetailAdditionalInfo]?

    enum CodingKeys: String, CodingKey {
        case id, accountNumber, accountTitle
        case billTypeID = "billTypeId"
        case billTypeName, parentBillType, additionalInfo
    }
}

// MARK: - AdditionalInfo
struct VehicleDetailAdditionalInfo: Codable {
    var name, value: String?
}

// MARK: - Parking
struct ParkingRequestModel {
    var billerContactID, noOfHours, parkingRegion, parkingType, parkingZone, flowName: String?
    var dictionary:[String:Any] {
        return  [
            "billerContactId":/self.billerContactID,
            "noOfHours":/self.noOfHours,
            "parkingRegion":/self.parkingRegion,
            "parkingType":/self.parkingType,
            "parkingZone":/self.parkingZone,
            "flowName":/self.flowName
        
        ]
    }
}

struct BillRequestModel {
    var billTypeId, billTypeName: String
    var dictionary:[String:Any] {
        return  [
            "billTypeName":/self.billTypeName,
            "billTypeId":/self.billTypeId
        
        ]
    }
}

class BillResponse: BaseResponseModel {
    
    var data: [BillData]?

    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([BillData].self, forKey: .data)
        try super.init(from: decoder)
    }
}

struct BillData: Codable {
    let id: Int
    let accountNumber: String?
    let accountTitle: String
    let billTypeId: Int
    let billTypeName: String?
    let parentBillType: Int
   // let additionalInfo: [String]?
}
