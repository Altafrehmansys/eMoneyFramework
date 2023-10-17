//
//  ProviderCellModel.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 26/05/2023.
//

import Foundation

class ProviderCellModel: StandardCellModel {
    let image: String
    let name: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    override func reusableIdentifier() -> String {
        return "\(ProviderTableViewCell.self)"
        
    }
}
