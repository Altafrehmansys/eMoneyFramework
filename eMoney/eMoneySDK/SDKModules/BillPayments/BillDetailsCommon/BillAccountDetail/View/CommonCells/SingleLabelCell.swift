//
//  SingleLabelCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/06/2023.
//

import UIKit

class SingleLabelCell: StandardCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? SingleLabelCellModel {
            titleLabel.text = model.title
            if let font = model.titleFont{
                titleLabel.font = font
            }
            if let color = model.titleColor{
                titleLabel.textColor = color
            }
        }
    }
    
    func setUpUI(){
    }
    
}

// MARK: - Cell Model
final class SingleLabelCellModel: StandardCellModel {

    let title: String
    let titleFont:UIFont?
    let titleColor:UIColor?
   
    init(actions: StandardCellModel.ActionsType = nil,
         title:String,
         titleFont: UIFont? = AppFont.appSemiBold(size: .body2),
         titleColor:UIColor? = AppColor.eAnd_Black_80) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SingleLabelCell.identifier()
    }
}
