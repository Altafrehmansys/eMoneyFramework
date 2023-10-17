
import Foundation

class LanguageInformation: Codable {
    
    var languageName: String?
    var languageCode: String?
    var languageVersion: String?
    var createdDateTime: String?
    
    enum CodingKeys: String, CodingKey {
        case languageName = "languageName"
        case languageCode = "languageCode"
        case languageVersion = "languageVersion"
        case createdDateTime = "createdDateTime"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        languageName = try values.decodeIfPresent(String.self, forKey: .languageName)
        languageCode = try values.decodeIfPresent(String.self, forKey: .languageCode)
        languageVersion = try values.decodeIfPresent(String.self, forKey: .languageVersion)
        createdDateTime = try values.decodeIfPresent(String.self, forKey: .createdDateTime)
    }
    
}
