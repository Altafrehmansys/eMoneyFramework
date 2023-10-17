//
//  AddNewBillTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//

import UIKit

class AddNewBillTableViewCell: StandardCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
   
    override func configureCell() {
        if let model = cellModel as? AddNewBillTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleColor
            imgView.image = UIImage(named: model.image)
        }
    }
}

// MARK: - Cell Model
final class AddNewBillTableViewCellModel: StandardCellModel {
    let image: String
    let title: String
    let titleFont: UIFont
    let titleColor: UIColor
   
    init(actions: StandardCellModel.ActionsType = nil,
         image: String,
         title:String,
         titleFont: UIFont = AppFont.appRegular(size: .body3),
         titleColor: UIColor = AppColor.eAnd_Black_80) {
        self.image = image
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return AddNewBillTableViewCell.identifier()
    }
}
