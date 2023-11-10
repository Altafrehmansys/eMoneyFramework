//
//  DEWAStandardTextFieldCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 16/06/2023.
//

import UIKit

class DEWAStandardTextFieldCell: StandardCell {
    
    @IBOutlet weak var billStandardTextField: StandardTextField!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? DEWAStandardTextFieldCellModel {
            billStandardTextField.title = model.placeHolderText
            billStandardTextField.entryType = model.textFieldType
            if let trailButtonIcon = model.trailingButtonIcon{
                billStandardTextField.trailingButtonImage = trailButtonIcon
            }
            billStandardTextField.text = model.inputValue ?? ""
        }
    }

    func setUpUI(){
        billStandardTextField.prefixColor = AppColor.eAnd_Black_80
        billStandardTextField.textChangedCallback = {
            if let model = self.cellModel as? DEWAStandardTextFieldCellModel {
                model.inputValue = self.billStandardTextField.text
                model.actions?.cellSelected(0,model)
            }
        }
        billStandardTextField.trailingButtonTappedCallback = {
            if let model = self.cellModel as? DEWAStandardTextFieldCellModel {
                model.actions?.cellSelected(1,model)
            }
        }
        
    }
}

// MARK: - Cell Model
final class DEWAStandardTextFieldCellModel: StandardCellModel {
    
    let placeHolderText: String
    let trailingButtonIcon:String?
    let textFieldType:StandardTextField.EntryType
    var inputValue:String?
    init(actions: StandardCellModel.ActionsType = nil,
         placeHolderText:String,
         trailingButtonIcon: String? = nil,
         inputValue:String? = nil,
         textFieldType:StandardTextField.EntryType ) {
        self.placeHolderText = placeHolderText
        self.trailingButtonIcon = trailingButtonIcon
        self.textFieldType = textFieldType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return DEWAStandardTextFieldCell.identifier()
    }
}
