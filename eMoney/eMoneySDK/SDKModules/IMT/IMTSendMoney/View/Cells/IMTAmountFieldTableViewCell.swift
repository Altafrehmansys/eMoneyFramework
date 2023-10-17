//
//  IMTAmountFieldTableViewCell.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 31/05/2023.
//

import UIKit

class IMTAmountFieldTableViewCell: StandardCell {
    @IBOutlet weak var textField: IMTAmountTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.textField.title = "You send".localized
        self.textField.textFieldFont = AppFont.appRegular(size: .body2)
        self.textField.textFieldTextColor = AppColor.eAnd_Black_80
        self.textField.entryType = .decimal
        self.textField.state = .normal
        
        setTextFieldCallbacks()
        setActions()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? IMTAmountFieldCellModel {
            if model.isReceiverField {
                self.textField.leadingDropDownButton.isHidden = false
                self.textField.title = "They receive".localized
            }else{
                self.textField.leadingDropDownButton.isHidden = true
                self.textField.title = "You send".localized
            }
            self.textField.leadingButtonImage = model.countryFlag
            self.textField.leadingLabel = model.countryCode
            
            if let amount = model.amount {
                self.textField.text = String(format: "%.2f", amount)
            }else{
                self.textField.text = ""
            }
            
            
            if let errMsg = model.errorMsg {
                self.textField.showError(with: errMsg)
            }else{
                self.textField.hideError()
            }
            
        }
    }
    
    func setTextFieldCallbacks(){
        self.textField.textFieldDidEndEditingCallback = { [unowned self] in
            if let amount = Double(self.textField.text),amount > 0 {
                self.textField.text = String(format: "%.2f", amount)
                
                if let model = cellModel as? IMTAmountFieldCellModel {
                    model.amount = amount
                    self.cellModel?.actions?.cellSelected(1,model)
                }
            }else{
                if let model = cellModel as? IMTAmountFieldCellModel {
                    model.amount = nil
                    self.cellModel?.actions?.cellSelected(1,model)
                }
            }
        }
        
        self.textField.textFieldDidBeginEditingCallback = {
            self.updateLayout()
        }
    }
    
    func setActions(){
        textField.leadingButtonTappedCallback = {
            self.cellModel?.actions?.cellSelected(0,self.cellModel!)
        }
    }
}

// MARK: - Cell model
final class IMTAmountFieldCellModel: StandardCellModel {
    var isReceiverField: Bool
    var countryFlag:String
    var countryCode:String
    var errorMsg:String?
    
    var amount:Double?
    
    init(actions: StandardCellModel.ActionsType = nil, isReceiverField: Bool, countryCode:String , countryFlag:String, errorMsg:String? = nil, amount:Double? = nil) {
        self.isReceiverField = isReceiverField
        self.countryFlag = countryFlag
        self.countryCode = countryCode
        self.amount = amount
        self.errorMsg = errorMsg
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return IMTAmountFieldTableViewCell.identifier()
    }
}
