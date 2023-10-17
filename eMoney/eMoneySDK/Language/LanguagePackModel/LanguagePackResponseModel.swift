
import Foundation

class LanguagePackResponseModel: BaseResponseModel {
    
    var data: LanguagePackData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(LanguagePackData.self   , forKey: .data)
        try super.init(from: decoder)
    }
    
}
