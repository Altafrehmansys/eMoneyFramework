//
//  GenericTitleAndImageTableViewCell.swift
//  e&money
//
//  Created by Qamar Iqbal on 02/05/2023.
//

import UIKit

class GenericTitleAndImageTableViewCell: StandardCell {

    @IBOutlet weak var paymentAcceptedLbl: UILabel!
    @IBOutlet weak var moneyImage: UIImageView!
    @IBOutlet weak var topBackGroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell() {
        if let model = cellModel as? GenericTitleAndImageTableViewCellModel {
            paymentAcceptedLbl.text = model.title
            paymentAcceptedLbl.font = model.titleFontAndColor.0
            paymentAcceptedLbl.textColor = model.titleFontAndColor.1
        
        }
    }
}


// MARK: - Cell model
final class GenericTitleAndImageTableViewCellModel: StandardCellModel {
    let title: String
    let titleFontAndColor: (UIFont, UIColor)
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFontAndColor: (UIFont, UIColor) = (AppFont.appRegular(size: .body4), AppColor.eAnd_Black_80)) {
        self.title = title
        self.titleFontAndColor = titleFontAndColor
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return GenericTitleAndImageTableViewCell.identifier()
    }
}
