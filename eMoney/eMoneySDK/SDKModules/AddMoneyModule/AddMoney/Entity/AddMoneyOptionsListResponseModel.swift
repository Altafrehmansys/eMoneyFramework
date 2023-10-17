//
//  AddMoneyOptionsListResponseModel.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 17/05/2023.
//

import Foundation

class AddMoneyOptionsListResponseModel: BaseResponseModel {
    
    let data: [AddMoneyOptionsListDataModel]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode([AddMoneyOptionsListDataModel].self, forKey: .data)
        try super.init(from: decoder)
    }
    
    // MARK: - Data Model
    struct AddMoneyOptionsListDataModel: Codable {

        let subResources: [AddMoneyOptionsListOptionModel]?
        let languageCode: String?
        let title: String?
        let identifier: String?
        let osType: String?
        let description: String?
        let iconImageUrl: String?

        enum CodingKeys: String, CodingKey {
            case subResources = "subResources"
            case languageCode = "languageCode"
            case title = "title"
            case identifier = "identifier"
            case osType = "osType"
            case description = "description"
            case iconImageUrl = "iconImageUrl"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            subResources = try? values.decode([AddMoneyOptionsListOptionModel].self, forKey: .subResources)
            languageCode = try? values.decode(String.self, forKey: .languageCode)
            title = try? values.decode(String.self, forKey: .title)
            identifier = try? values.decode(String.self, forKey: .identifier)
            osType = try? values.decode(String.self, forKey: .osType)
            description = try? values.decode(String.self, forKey: .description)
            iconImageUrl = try? values.decode(String.self, forKey: .iconImageUrl)
        }
    }

    struct AddMoneyOptionsListOptionModel: Codable {

        let languageCode: String
        let title: String
        let identifier: String
        let iconImageUrl: String

        enum CodingKeys: String, CodingKey {
            case languageCode = "languageCode"
            case title = "title"
            case identifier = "identifier"
            case iconImageUrl = "iconImageUrl"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            languageCode = try values.decode(String.self, forKey: .languageCode)
            title = try values.decode(String.self, forKey: .title)
            identifier = try values.decode(String.self, forKey: .identifier)
            iconImageUrl = try values.decode(String.self, forKey: .iconImageUrl)
        }
    }
}
