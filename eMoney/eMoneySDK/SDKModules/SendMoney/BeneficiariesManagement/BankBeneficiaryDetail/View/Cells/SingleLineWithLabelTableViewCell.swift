//
//  SingleLineWithLabelTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 16/05/2023.
//

import UIKit

class SingleLineWithLabelTableViewCell: StandardCell {

    @IBOutlet weak var dateLabel: UILabel!
    override func configureCell() {
        if let model = cellModel as? SingleLineWithLabelTableViewCellModel {
            dateLabel.text = model.date
            dateLabel.font = model.dateFont
            dateLabel.textColor = model.dateColor
        }
    }
}

// MARK: - Cell Model
final class SingleLineWithLabelTableViewCellModel: StandardCellModel {
    
    let date: String
    let dateFont:UIFont
    let dateColor:UIColor

    init(actions: StandardCellModel.ActionsType = nil,
         date: String,
         dateFont: UIFont = AppFont.appRegular(size: .body5),
         dateColor: UIColor = AppColor.eAnd_Grey_100) {
        self.date = date
        self.dateFont = dateFont
        self.dateColor = dateColor
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SingleLineWithLabelTableViewCell.identifier()
    }
}
