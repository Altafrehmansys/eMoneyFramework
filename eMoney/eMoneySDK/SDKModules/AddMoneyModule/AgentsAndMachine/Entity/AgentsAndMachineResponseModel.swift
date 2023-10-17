//
//  AgentsAndMachineResponseModel.swift
//  e&money
//
//  Created by Qamar Iqbal on 04/05/2023.
//  
//

import Foundation


class AgentsAndMachineResponseModel: BaseResponseModel {
    
    var data: DataModel?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(DataModel.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    // MARK: - Data Model
    struct DataModel: Codable {
        let locations: [LocationsDataModel]?
        let pageSize: Int?
        let pageNumber: Int?
        let numberOfElements: Int?
        let totalPages: Int?
        let totalRecords: Int?
        
        enum CodingKeys: String, CodingKey {
            case locations
            case pageSize
            case pageNumber
            case numberOfElements
            case totalPages
            case totalRecords
        }
        
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            locations = try values.decodeIfPresent([LocationsDataModel].self, forKey: .locations)
            pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
            pageNumber = try values.decodeIfPresent(Int.self, forKey: .pageNumber)
            numberOfElements = try values.decodeIfPresent(Int.self, forKey: .numberOfElements)
            totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
            totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
        }
    }
    
    final class LocationsDataModel: Codable {
        
        let id: Int?
        let name: String?
        let branchName: String?
        let addressShort: String?
        let address: String?
        let branch: String?
        let services: String?
        let latitude: Double?
        let longitude: Double?
        let offers: String?
        let popularity: String?
        let imageUrl: String?
        let isOpen: Bool?
        let timing: String?
        let category: String?
        let type: String?
        let distance: Double?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case branchName
            case addressShort
            case address
            case branch
            case services
            case latitude
            case longitude
            case offers
            case popularity
            case imageUrl
            case isOpen
            case timing
            case category
            case type
            case distance
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            branchName = try values.decodeIfPresent(String.self, forKey: .branchName)
            addressShort = try values.decodeIfPresent(String.self, forKey: .addressShort)
            address = try values.decodeIfPresent(String.self, forKey: .address)
            branch = try values.decodeIfPresent(String.self, forKey: .branch)
            services = try values.decodeIfPresent(String.self, forKey: .services)
            latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
            longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
            offers = try values.decodeIfPresent(String.self, forKey: .offers)
            popularity = try values.decodeIfPresent(String.self, forKey: .popularity)
            imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
            isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen)
            timing = try values.decodeIfPresent(String.self, forKey: .timing)
            category = try values.decodeIfPresent(String.self, forKey: .category)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            distance = try values.decodeIfPresent(Double.self, forKey: .distance)
        }
    }
}
