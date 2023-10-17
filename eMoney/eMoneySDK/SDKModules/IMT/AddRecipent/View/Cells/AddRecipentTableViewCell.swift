//
//  AddRecipentTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//

import UIKit

class AddRecipentTableViewCell: StandardCell {

    @IBOutlet weak var textFieldAddRecipent: StandardTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //setupTextField()
    }
    
    private func setupTextField() {
        textFieldAddRecipent.title = "IBAN"
        textFieldAddRecipent.borderColor = AppColor.eAnd_Grey_20
        textFieldAddRecipent.trailingButtonImage = "info-circle"
        textFieldAddRecipent.showTitleWhenActive = true
        textFieldAddRecipent.entryType = .numberPad
        textFieldAddRecipent.state = .normal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? AddRecipentTableViewCellModel {
            textFieldAddRecipent.title = model.title
            textFieldAddRecipent.entryType = model.textFieldType
            textFieldAddRecipent.trailingButtonImage = model.imageName
            textFieldAddRecipent.borderColor = AppColor.eAnd_Grey_20
        }
    }
}

// MARK: - Cell model
final class AddRecipentTableViewCellModel: StandardCellModel {
   
    
    let title: String
    let text: String
    let textFieldType: StandardTextField.EntryType
    let imageName: String
   
    init(actions: StandardCellModel.ActionsType = nil, title: String, text: String, textFieldType: StandardTextField.EntryType,imageName : String) {
        self.title = title
        self.text = text
        self.textFieldType = textFieldType
        self.imageName = imageName
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return AddRecipentTableViewCell.identifier()
    }
}
