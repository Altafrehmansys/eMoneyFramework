
import Foundation

class LanguagePackData: Codable {
    
    var languageInformation : LanguageInformation?
    var languagePack: [String:String]?
    
    enum CodingKeys: String, CodingKey {
        case languageInformation = "languageInformation"
        case languagePack = "languagePack"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        languageInformation = try values.decodeIfPresent(LanguageInformation.self, forKey: .languageInformation )
        languagePack = try values.decodeIfPresent([String:String].self, forKey: .languagePack)
    }
}
