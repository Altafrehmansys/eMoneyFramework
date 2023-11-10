//
//  BillAccountDetailCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//

import UIKit
import Kingfisher
class BillAccountDetailCell: StandardCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    // MARK: - Override Methods
    override func configureCell() {
        if let model = cellModel as? BillAccountDetailCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleColor
            let url = URL(string: model.imageURL ?? "")
            self.imgView.kf.setImage(with: url)
        }
    }
    
}

// MARK: - Cell Model
final class BillAccountDetailCellModel: StandardCellModel {
    let imageURL: String
    let title: String
    let titleFont: UIFont
    let titleColor: UIColor
   
    init(actions: StandardCellModel.ActionsType = nil,
         imageURL: String,
         title:String,
         titleFont: UIFont = AppFont.appSemiBold(size: .body2),
         titleColor: UIColor = AppColor.eAnd_Black_80) {
        self.imageURL = imageURL
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return BillAccountDetailCell.identifier()
    }
}

