//
//  SelectLanguageModel.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 11/04/2023.
//

import Foundation


struct SelectLanguageModel {
     var  name: String
     var  isSelected: Bool
    
    static func getDummyData() -> [SelectLanguageModel] {
        var languageArray = [SelectLanguageModel]()
        let languageObj = SelectLanguageModel(name: "English", isSelected: false)
        languageArray.append(languageObj)
        let languageObj1 = SelectLanguageModel(name: "العربية", isSelected: false)
        languageArray.append(languageObj1)
        let languageObj2 = SelectLanguageModel(name: "اردو", isSelected: false)
        languageArray.append(languageObj2)
        let languageObj3 = SelectLanguageModel(name: "हिंदी", isSelected: false)
        languageArray.append(languageObj3)
        let languageObj4 = SelectLanguageModel(name: "മലയാളം", isSelected: false)
        languageArray.append(languageObj4)
        let languageObj5 = SelectLanguageModel(name: "Tagalog", isSelected: false)
        languageArray.append(languageObj5)
        return languageArray
    }
    
}


