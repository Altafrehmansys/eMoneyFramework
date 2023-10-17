//
//  KeyValueTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//

import UIKit

final class KeyValueTableViewCell: StandardCell {
    
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var topSpace: NSLayoutConstraint!
    // MARK: - Outlets
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    // MARK: - Override Methods
    override func configureCell() {
        if let model = cellModel as? KeyValueTableViewCellModel {
            keyLabel.text = model.key
            keyLabel.font = model.keyFont
            keyLabel.textColor = model.keyTextColor
            
            valueLabel.text = model.value
            valueLabel.font = model.valueFont
            valueLabel.textColor = model.valueTextColor
            if let top = model.topSpace{
                topSpace.constant = top
            }
            if let bottom = model.bottomSpace{
                bottomSpace.constant = bottom
            }
            
        }
    }
}


// MARK: - Cell Model
final class KeyValueTableViewCellModel: StandardCellModel {
    let key: String
    let keyFont: UIFont
    let keyTextColor: UIColor
    let value: String
    let valueFont: UIFont
    let valueTextColor: UIColor

    let topSpace: CGFloat?
    let bottomSpace: CGFloat?
    
    
    init(actions: StandardCellModel.ActionsType = nil,
         key: String,
         keyFont: UIFont = AppFont.appRegular(size: .body3),
         keyTextColor: UIColor = AppColor.eAnd_Black_80,
         value: String,
         valueFont: UIFont = AppFont.appSemiBold(size: .body3),
         valueTextColor: UIColor = AppColor.eAnd_Black_80,
         topSpace: CGFloat? = 10,
         bottomSpace: CGFloat? = 10) {
        self.key = key
        self.keyFont = keyFont
        self.keyTextColor = keyTextColor
        self.value = value
        self.valueFont = valueFont
        self.valueTextColor = valueTextColor
        self.topSpace = topSpace
        self.bottomSpace = bottomSpace
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return KeyValueTableViewCell.identifier()
    }
}
