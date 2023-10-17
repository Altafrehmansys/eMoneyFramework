//
//  WalkthroughIntroResponseModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 14/04/2023.
//  
//

import Foundation
import UIKit


struct WalkthroughRequestModel:Codable{
    var screenName:String?
    var sourcePlatform:String?
}


class WalkthroughIntroResponseModel:BaseResponseModel{
    var data : WalkthroughData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(WalkthroughData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class WalkthroughData:Codable{
    let notifications : [WalkthroughNotifications]?

    enum CodingKeys: String, CodingKey {
        case notifications = "notifications"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notifications = try values.decodeIfPresent([WalkthroughNotifications].self, forKey: .notifications)
    }
}

class WalkthroughNotifications:Codable{
    var imageURL : String?
    var message : String?
    var priority : Int?

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageURL"
        case message = "message"
        case priority = "priority"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        priority = try values.decodeIfPresent(Int.self, forKey: .priority)
    }
}

