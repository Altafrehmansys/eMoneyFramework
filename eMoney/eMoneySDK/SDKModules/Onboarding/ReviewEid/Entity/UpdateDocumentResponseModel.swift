//
//  UpdateDocumentResponseModel.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 25/07/2023.
//

import Foundation

class UpdateDocumentResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
   
    var data : UpdateDocumentData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UpdateDocumentData.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}
class UpdateDocumentData: Codable {

    let profileName, upgradeToProfile, upgradeScreen: String?

    enum CodingKeys: String, CodingKey {
        case profileName = "profileName"
        case upgradeToProfile = "upgradeToProfile"
        case upgradeScreen = "upgradeScreen"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profileName = try values.decodeIfPresent(String.self, forKey: .profileName)
        upgradeToProfile = try values.decodeIfPresent(String.self, forKey: .upgradeToProfile)
        upgradeScreen = try values.decodeIfPresent(String.self, forKey: .upgradeScreen)
        
    }
    
}
