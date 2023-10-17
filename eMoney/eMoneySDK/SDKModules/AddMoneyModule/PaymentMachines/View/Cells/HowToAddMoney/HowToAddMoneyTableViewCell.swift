//
//  HowToAddMoneyTableViewCell.swift
//  e&money
//
//  Created by Qamar Iqbal on 05/05/2023.
//

import UIKit

class HowToAddMoneyTableViewCell: StandardCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func configureCell() {
        if let model = cellModel as? HowToAddMoneyTableViewCellModel {
            titleLbl.text = model.titleLbl
            titleLbl.font = model.titleLblFontAndColor.0
            titleLbl.textColor = model.titleLblFontAndColor.1
            
            subTitlelbl.text = model.subTitlelbl
            subTitlelbl.font = model.subTitleLblFontAndColor.0
            subTitlelbl.textColor = model.subTitleLblFontAndColor.1
        }
    }
}

// MARK: - Cell model
final class HowToAddMoneyTableViewCellModel: StandardCellModel {
    let titleLbl: String
    let titleLblFontAndColor: (UIFont, UIColor)
    
    let subTitlelbl: String
    let subTitleLblFontAndColor: (UIFont, UIColor)
    
    init(actions: StandardCellModel.ActionsType = nil,
         titleLbl: String,
         titleLblFontAndColor: (UIFont, UIColor) = (AppFont.appSemiBold(size: .body2), AppColor.eAnd_Black_80),
         subTitlelbl: String,
         subTitleLblFontAndColor: (UIFont, UIColor) = (AppFont.appRegular(size: . body4), AppColor.eAnd_Grey_100)
    ) {
        
        self.titleLbl = titleLbl
        self.titleLblFontAndColor = titleLblFontAndColor
        
        self.subTitlelbl = subTitlelbl
        self.subTitleLblFontAndColor = subTitleLblFontAndColor

        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return HowToAddMoneyTableViewCell.identifier()
    }
}
