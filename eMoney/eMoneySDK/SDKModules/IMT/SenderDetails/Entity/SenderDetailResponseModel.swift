//
//  SenderDetailResponseModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

class test {
    
   class func createDataSource() -> [StandardCellModel] {
        var cellAction: StandardCellActions?
        var dataSource: [StandardCellModel] = []
        let labelCellModel = SenderDetailTableViewCellModel(title: "home_address".localized, text: "", textFieldEntryType: .text, textFieldType: "text", image: "")
       
        let labelCellModel1 = SenderDetailTableViewCellModel(title: "residing_emirate".localized, text: "", textFieldEntryType: .text, textFieldType: "dropdown", image: "arrow-down",dropDownDataSource: ["a","c","c","q"])
        let labelCellModel2 = SenderDetailTableViewCellModel(title: "occupation".localized, text: "", textFieldEntryType: .text, textFieldType: "dropdown", image: "arrow-down",dropDownDataSource: ["a","a","c","a"])
        let labelCellModel3 = SenderDetailTableViewCellModel(title: "source_of_funds".localized, text: "", textFieldEntryType: .text, textFieldType: "text", image: "info-circle-bank")
        
        dataSource.append(labelCellModel)
        dataSource.append(labelCellModel1)
        dataSource.append(labelCellModel2)
        dataSource.append(labelCellModel3)
        
        return dataSource
       
    }
}


class SenderDetailResponseModel: BaseResponseModel {
    
    // MARK: - Model Variables
    
    var value1: String?
    var value2: String?
    
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey {
        case value1
        case value2
    }
    
    // MARK: - Model mapping
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value1 = try values.decodeIfPresent(String.self, forKey: .value1)
        value2 = try values.decodeIfPresent(String.self, forKey: .value2)
        try super.init(from: decoder)
    }
}
