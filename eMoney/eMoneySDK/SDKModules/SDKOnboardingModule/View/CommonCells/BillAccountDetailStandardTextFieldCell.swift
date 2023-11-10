//
//  BillAccountDetailStandardTextFieldCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/06/2023.
//

import UIKit

enum BillAccountDetailsTextFieldTypes {
    case phoneNumber
    case nickname
    case easypayNumber
    case billNumber
    case ebsNumber
    case pinNumber
    case salikAccountNumber
    case PVTNumber
}

class BillAccountDetailStandardTextFieldCell: StandardCell {

    @IBOutlet weak var billStandardTextField: StandardTextField!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? BillAccountDetailStandardTextFieldCellModel {
            billStandardTextField.title = model.placeHolderText
            billStandardTextField.entryType = model.textFieldType
            if let prefix = model.isPreFix{
                billStandardTextField.prefix = prefix
            }
            if let trailButtonIcon = model.trailingButtonIcon{
                billStandardTextField.trailingButtonImage = trailButtonIcon
                billStandardTextField.setupConfigurations()
            }
            billStandardTextField.text = model.inputValue ?? ""
        }
    }

    func setUpUI(){
        billStandardTextField.prefixColor = AppColor.eAnd_Black_80
        billStandardTextField.textChangedCallback = {
            
            if let model = self.cellModel as? BillAccountDetailStandardTextFieldCellModel {
                model.inputValue = self.billStandardTextField.text
                model.actions?.cellSelected(0,model)

            }
        }
        
        billStandardTextField.trailingButtonTappedCallback = {

            if let model = self.cellModel as? BillAccountDetailStandardTextFieldCellModel {

                model.actions?.cellSelected(1,model)
            }
        }

    }
}
// MARK: - Cell Model
final class BillAccountDetailStandardTextFieldCellModel: StandardCellModel {
    var isPreFix: String?
    let placeHolderText: String
    var trailingButtonIcon:String?
    var textFieldType:StandardTextField.EntryType
    var accountDetailsTextType: BillAccountDetailsTextFieldTypes = .phoneNumber
    var inputValue:String?
    init(actions: StandardCellModel.ActionsType = nil,
         isPreFix: String? = nil,
         placeHolderText:String,
         trailingButtonIcon: String? = nil,
         inputValue:String? = nil,
         textFieldType:StandardTextField.EntryType,
         accountDetailsTextType: BillAccountDetailsTextFieldTypes) {
        self.isPreFix = isPreFix
        self.placeHolderText = placeHolderText
        self.trailingButtonIcon = trailingButtonIcon
        self.textFieldType = textFieldType
        self.accountDetailsTextType = accountDetailsTextType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return BillAccountDetailStandardTextFieldCell.identifier()
    }
}
