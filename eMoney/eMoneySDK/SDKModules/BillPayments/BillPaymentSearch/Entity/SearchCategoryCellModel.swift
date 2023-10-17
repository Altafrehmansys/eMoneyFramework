//
//  SearchCategoryCellModel.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 09/06/2023.
//

import Foundation


class SearchCategoryCellModel: StandardCellModel {
    let item:ListItems?
    init(item: ListItems) {
        self.item = item
    }
    override func reusableIdentifier() -> String {
        return "\(SearchCategoriesTableViewCell.self)"
    }
}
