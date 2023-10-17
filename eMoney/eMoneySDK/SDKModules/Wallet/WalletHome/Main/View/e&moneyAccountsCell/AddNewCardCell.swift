//
//  AddNewCardCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//

import UIKit

class AddNewCardCell: StandardCell {

    @IBOutlet weak var addNewCardLabel: UILabel!
    @IBOutlet weak var parentVIew: UIView!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? AddNewCardCellModel {
            self.addNewCardLabel.text = model.addNewCardTitle
        }
    }
    func setUpUI() {
        parentVIew.cornerRadius = 12
        parentVIew.borderColor = AppColor.eAnd_Grey_30
        parentVIew.borderWidth = 1
        addNewCardLabel.font = AppFont.appRegular(size:.body3)
        addNewCardLabel.textColor = AppColor.eAnd_Black_80
    }
    
}
// MARK: - Cell Model
final class AddNewCardCellModel: StandardCellModel {
    
    let addNewCardTitle: String
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         addNewCardTitle: String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.addNewCardTitle = addNewCardTitle
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return AddNewCardCell.identifier()
    }
}
