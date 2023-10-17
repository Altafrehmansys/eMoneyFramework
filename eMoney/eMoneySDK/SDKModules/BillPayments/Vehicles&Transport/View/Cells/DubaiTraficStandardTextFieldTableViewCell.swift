//
//  DubaiTraficStandardTextFieldTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 21/06/2023.
//

import UIKit

class DubaiTraficStandardTextFieldTableViewCell: StandardCell {

    @IBOutlet weak var dubaiTraficStandardTextField: StandardTextField!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? DubaiTraficStandardTextFieldTableViewCellModel {
            if model.showError {
                self.dubaiTraficStandardTextField.showError(with: model.errorText ?? "error")
            }else{
                self.dubaiTraficStandardTextField.hideError()
            }
            dubaiTraficStandardTextField.title = model.placeHolderText
            dubaiTraficStandardTextField.entryType = model.textFieldType
            if let prefix = model.isPreFix{
                dubaiTraficStandardTextField.prefix = prefix
            }
            if let trailButtonIcon = model.trailingButtonIcon{
                dubaiTraficStandardTextField.trailingButtonImage = trailButtonIcon
                dubaiTraficStandardTextField.setupConfigurations()
            }
            dubaiTraficStandardTextField.text = model.inputValue ?? ""
        }
    }

    func setUpUI(){
        dubaiTraficStandardTextField.prefixColor = AppColor.eAnd_Black_80
        dubaiTraficStandardTextField.textChangedCallback = {
            if let model = self.cellModel as? BillAccountDetailStandardTextFieldCellModel {
                model.inputValue = self.dubaiTraficStandardTextField.text
                model.actions?.cellSelected(0,model)
            }
        }
        dubaiTraficStandardTextField.trailingButtonTappedCallback = {
            if let model = self.cellModel as? BillAccountDetailStandardTextFieldCellModel {
                model.actions?.cellSelected(1,model)
            }
        }
    }
}

// MARK: - Cell Model
final class DubaiTraficStandardTextFieldTableViewCellModel: StandardCellModel {
    var isPreFix: String?
    let placeHolderText: String
    var trailingButtonIcon:String?
    var textFieldType:StandardTextField.EntryType
    var inputValue:String?
    let methodType: DubaiPoliceCellType?
    var errorText:String?
    var showError:Bool
    init(actions: StandardCellModel.ActionsType = nil,
         isPreFix: String? = nil,
         placeHolderText:String,
         trailingButtonIcon: String? = nil,
         inputValue:String? = nil,
         textFieldType:StandardTextField.EntryType,
         methodType: DubaiPoliceCellType? = nil,
         errorText:String?,
         showError:Bool = false) {
        self.isPreFix = isPreFix
        self.placeHolderText = placeHolderText
        self.trailingButtonIcon = trailingButtonIcon
        self.textFieldType = textFieldType
        self.methodType = methodType
        self.errorText = errorText
        self.showError = showError
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return DubaiTraficStandardTextFieldTableViewCell.identifier()
    }
}
