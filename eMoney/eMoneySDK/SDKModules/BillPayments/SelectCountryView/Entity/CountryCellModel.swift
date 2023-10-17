//
//  CountryCellModel.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 26/05/2023.
//

import Foundation

class CountryCellModel: StandardCellModel {
    let image: String
    let name: String
    let iso: String
    var codes: [String]
    
    init(name: String, image: String, iso: String, codes: [String]) {
        self.name = name
        self.image = image
        self.iso = iso
        self.codes = codes
    }
    
    override func reusableIdentifier() -> String {
        return "\(CountriesTableViewCell.self)"
    }
}
