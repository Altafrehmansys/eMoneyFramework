//
//  CardDetailsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 05/05/2023.
//

import UIKit

final class CardDetailsTableViewCell: StandardCell {
    
    // MARK: - Outlets
    @IBOutlet weak var holderNameTextField: StandardTextField!
    @IBOutlet weak var numberTextField: StandardTextField!
    @IBOutlet weak var expiryDateTextField: StandardTextField!
    @IBOutlet weak var cvvTextField: StandardTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTextFields()
    }
    
    override func configureCell() {
        if let model = cellModel as? CardDetailsTableViewCellModel {
            holderNameTextField.text = model.holderName
            holderNameTextField.state = .normal
            
            numberTextField.text = model.cardNumber
            numberTextField.state = .normal
            
            expiryDateTextField.text = model.expiryDate
            expiryDateTextField.state = .normal
            
            cvvTextField.text = model.cvv
            cvvTextField.state = .normal
        }
    }
}

// MARK: - Setup Text Fields
extension CardDetailsTableViewCell {
    private func setupTextFields() {
        holderNameTextField.title = Strings.AddMoney.cardHolderName
        holderNameTextField.entryType = .text
        holderNameTextField.state = .normal
        
        numberTextField.title = Strings.AddMoney.cardNumber
        numberTextField.trailingButtonImage = "visa-card"
        numberTextField.entryType = .numberPad
        numberTextField.state = .normal
        
        expiryDateTextField.title = Strings.AddMoney.expiryDate
        expiryDateTextField.entryType = .numberPad
        expiryDateTextField.state = .normal
        
        cvvTextField.title = Strings.AddMoney.cvv
        cvvTextField.entryType = .numberPad
        cvvTextField.state = .normal
    }
}

// MARK: - Cell Model
final class CardDetailsTableViewCellModel: StandardCellModel {
    let holderName: String
    let cardNumber: String
    let expiryDate: String
    let cvv: String
    
    init(actions: StandardCellModel.ActionsType = nil, holderName: String, cardNumber: String, expiryDate: String, cvv: String) {
        self.holderName = holderName
        self.cardNumber = cardNumber
        self.expiryDate = expiryDate
        self.cvv = cvv
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return CardDetailsTableViewCell.identifier()
    }
}
