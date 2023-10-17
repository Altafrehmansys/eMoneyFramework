//
//  CancelCardReasonsCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//

import UIKit
import DropDown

class CancelCardReasonsCell: StandardCell {
    
    @IBOutlet weak var dropDownTextField: StandardTextField!
    let dropDown = DropDown()

    // MARK: - Override Methods
    override func configureCell() {
        
        if let model = cellModel as? CancelCardReasonsCellModel {
//            if model.showError {
//                self.dropDownTextField.showError(with: model.errorText ?? "error")
//            }else{
//                self.dropDownTextField.hideError()
//            }
            dropDownTextField.prefixFont = model.textFieldFont
            dropDownTextField.textFieldTextColor = model.textFieldColor
            dropDownTextField.title = model.placeHolderText
            dropDownTextField.getTextField.inputView = UIView()
            dropDownTextField.trailingButtonImage = "arrow-down"
            dropDownTextField.textFieldDidBeginEditingCallback = { [unowned self] in
                customizeDropDown(dataSource: model.dropDownDataSource ?? [])
            }
        }
    }
    func customizeDropDown(dataSource:[String]) {
        
        dropDown.anchorView = self.dropDownTextField
        dropDown.bottomOffset = CGPoint(x:0, y: self.dropDownTextField.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [unowned self] in
            dropDownTextField.resignFirstResponder()
        }
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource
        
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "CustomDropDownCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCell else { return }
            
            if index == self.dropDown.dataSource.count - 1{
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        dropDown.selectionAction = { (index,item) in
            self.dropDownTextField.text = item
            self.dropDownTextField.resignFirstResponder()
            self.dropDownTextField.hideError()
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
    
}

// MARK: - Cell Model
final class CancelCardReasonsCellModel: StandardCellModel {
    let textFieldFont: UIFont
    let textFieldColor: UIColor
    let placeHolderText:String
    let dropDownDataSource:[String]?
    var selectedDropDown:String?
    var errorText:String?
    var showError:Bool
    init(actions: StandardCellModel.ActionsType = nil,
         placeHolderText:String,
         textFieldFont: UIFont = AppFont.appSemiBold(size: .body2),
         textFieldColor: UIColor = AppColor.eAnd_Black_80,
         dropDownDataSource:[String]? = nil,
         errorText:String?,
         showError:Bool = false,
         selectedDropDown:String? = nil) {
        self.placeHolderText = placeHolderText
        self.textFieldFont = textFieldFont
        self.textFieldColor = textFieldColor
        self.dropDownDataSource = dropDownDataSource
        self.selectedDropDown = selectedDropDown
        self.errorText = errorText
        self.showError = showError
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return CancelCardReasonsCell.identifier()
    }
}
