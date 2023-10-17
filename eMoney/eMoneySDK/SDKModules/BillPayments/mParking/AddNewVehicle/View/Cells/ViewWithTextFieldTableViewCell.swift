//
//  ViewWithTextFieldTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 02/06/2023.
//

import UIKit

class ViewWithTextFieldTableViewCell: StandardCell {
    @IBOutlet weak var TextField: StandardTextField!
    
    override func configureCell() {
        setUpTextField()
        if let model = cellModel as? ViewWithTextFieldTableViewCellModel {
            TextField.placeholder = model.plateTypePlaceholder

            }
    }
    
    func setUpTextField(){
        TextField.textFieldFont = AppFont.appRegular(size: .body4)
        TextField.textFieldTextColor = AppColor.eAnd_Black_80
     
    }

}

// MARK: - Cell Model
final class ViewWithTextFieldTableViewCellModel: StandardCellModel {
    let plateTypePlaceholder:String
    init(plateTypePlaceholder:String,actions: StandardCellModel.ActionsType = nil) {
        self.plateTypePlaceholder = plateTypePlaceholder
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ViewWithTextFieldTableViewCell.identifier()
    }
}
