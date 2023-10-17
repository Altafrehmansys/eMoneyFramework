//
//  TellUsMoreCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//

import UIKit

class TellUsMoreCell: StandardCell {

    @IBOutlet weak var tellUsMoreTextView: UITextView!


    // MARK: - Override Methods
    override func configureCell() {
        setUp()
        if let model = cellModel as? TellUsMoreCellModel {

//            dropDownTextField.prefixFont = model.textFieldFont
//            dropDownTextField.textFieldTextColor = model.textFieldColor
//            dropDownTextField.title = model.placeHolderText
        }
    }
    
    private func setUp(){
       
        tellUsMoreTextView.borderWidth = 1
        tellUsMoreTextView.borderColor = AppColor.eAnd_Grey_20
        tellUsMoreTextView.cornerRadius = 16
    }
}

// MARK: - Cell Model
final class TellUsMoreCellModel: StandardCellModel {
    let placeHolderText: String
   
    init(actions: StandardCellModel.ActionsType = nil,
         placeHolderText:String) {
        self.placeHolderText = placeHolderText
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return TellUsMoreCell.identifier()
    }
}


