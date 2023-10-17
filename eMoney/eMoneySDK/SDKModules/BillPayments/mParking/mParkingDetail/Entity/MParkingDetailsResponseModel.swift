//
//  MParkingDetailsResponseModel.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation

class MParkingDetailsRegionResponseeModel: BaseResponseModel {
    
    // MARK: - Model Variables
    var data:[ParkingRegion]?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ParkingRegion].self, forKey: .data)
        try super.init(from: decoder)
    }
}
class MParkingDetailsZoneResponseeModel: BaseResponseModel {
    
    // MARK: - Model Variables
    var data:[RegionZone]?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([RegionZone].self, forKey: .data)
        try super.init(from: decoder)
    }
}
class ParkingRegion:Codable {
    // MARK: - Model Variables
    var id: Int?
    var title: String?
    var imageURL: String?
    var isCharity: Bool?
//    var regionZones:[RegionZone]?
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case id,title,imageURL,isCharity//,regionZones
    }
    // MARK: - Model mapping
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        isCharity = try values.decodeIfPresent(Bool.self, forKey: .isCharity)
//        regionZones = try values.decodeIfPresent([RegionZone].self, forKey: .regionZones)
    }
}
// MARK: - RegionZone
class RegionZone: Codable {
    var regionId: Int?
    var id: Int?
    var title, zoneNumber, zoneArea, zoneStatus: String?
    var zoneHours: [ZoneHour]?
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case regionId,id,title,zoneNumber,zoneArea,zoneStatus,zoneHours
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        regionId = try values.decodeIfPresent(Int.self, forKey: .regionId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        zoneNumber = try values.decodeIfPresent(String.self, forKey: .zoneNumber)
        zoneArea = try values.decodeIfPresent(String.self, forKey: .zoneArea)
        zoneStatus = try values.decodeIfPresent(String.self, forKey: .zoneStatus)
        zoneHours = try values.decodeIfPresent([ZoneHour].self, forKey: .zoneHours)
    }
}

// MARK: - ZoneHour
struct ZoneHour: Codable {
    var standardHourFee:String?
    var id: Int?
    var title:String?
    var premiumHourFee:String?
//    var displayText, hourFee: String?
}

class AddParkingResponseeModel: BaseResponseModel {
    
    // MARK: - Model Variables
    var data:VehicleDetail?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(VehicleDetail.self, forKey: .data)
        try super.init(from: decoder)
    }
}
