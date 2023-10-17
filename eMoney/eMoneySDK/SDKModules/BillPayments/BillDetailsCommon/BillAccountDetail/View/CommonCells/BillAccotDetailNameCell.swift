//
//  BillAccotDetailNameCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/06/2023.
//

import UIKit

class BillAccotDetailNameCell: StandardCell {

    @IBOutlet weak var billNameTextField: StandardTextField!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? BillAccotDetailNameCellModel {
            billNameTextField.title = model.placeHolderText
            billNameTextField.entryType = model.textFieldType
        
            if let trailButtonIcon = model.trailingButtonIcon{
                billNameTextField.trailingButtonImage = trailButtonIcon
            }
            billNameTextField.text = model.inputValue ?? ""
        }
    }

    func setUpUI(){
        billNameTextField.textChangedCallback = {
            if let model = self.cellModel as? BillAccotDetailNameCellModel {
                model.inputValue = self.billNameTextField.text
                model.actions?.cellSelected(0,model)
            }
        }
    }
    
}

// MARK: - Cell Model
final class BillAccotDetailNameCellModel: StandardCellModel {
  
    let placeHolderText: String
    let trailingButtonIcon:String?
    let textFieldType:StandardTextField.EntryType
    var accountDetailsTextType: BillAccountDetailsTextFieldTypes = .phoneNumber
    var inputValue:String?
    init(actions: StandardCellModel.ActionsType = nil,
         isPreFix: String? = nil,
         placeHolderText:String,
         trailingButtonIcon: String? = nil,
         inputValue:String? = nil,
         textFieldType:StandardTextField.EntryType,
         accountDetailsTextType: BillAccountDetailsTextFieldTypes) {
        self.placeHolderText = placeHolderText
        self.trailingButtonIcon = trailingButtonIcon
        self.textFieldType = textFieldType
        self.accountDetailsTextType = accountDetailsTextType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return BillAccotDetailNameCell.identifier()
    }
}
