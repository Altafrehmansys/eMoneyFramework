//
//  LivenessRhserResponseModel.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 27/04/2023.
//

import Foundation


class LivenessRhserResponseModel: BaseResponseModel{
    var data : LivenessRhserData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(LivenessRhserData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class LivenessRhserData: Codable {

    var profileName: String?
    var upgradeScreen: String?
    var upgradeToProfile: String?
    var message: String?

    private enum CodingKeys: String, CodingKey {
        case profileName = "profileName"
        case upgradeScreen = "upgradeScreen"
        case upgradeToProfile = "upgradeToProfile"
        case message = "message"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profileName = try values.decodeIfPresent(String.self, forKey: .profileName)
        upgradeScreen = try values.decodeIfPresent(String.self, forKey: .upgradeScreen)
        upgradeToProfile = try values.decodeIfPresent(String.self, forKey: .upgradeToProfile)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
