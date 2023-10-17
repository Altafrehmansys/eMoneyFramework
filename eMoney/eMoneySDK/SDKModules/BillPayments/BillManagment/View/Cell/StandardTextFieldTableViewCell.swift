//
//  StandardTextFieldTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/06/2023.
//

import UIKit

class StandardTextFieldTableViewCell: StandardCell {

    @IBOutlet weak var inPutTextField: StandardTextField!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? StandardTextFieldTableViewCellModel {
            self.inPutTextField.placeholder = model.placeHolderText
            if let leadImage = model.leadingImage{
                inPutTextField.leadingButtonImage = leadImage
            }
            if let trailingImage = model.trailingImage{
                inPutTextField.trailingButtonImage = trailingImage
            }
        }
    }
    func setUpUI() {
        inPutTextField.textFieldFont = AppFont.appRegular(size: .body2)
        inPutTextField.textFieldTextColor = AppColor.eAnd_Black_80
    }
    
}

// MARK: - Cell Model
final class StandardTextFieldTableViewCellModel: StandardCellModel {
    
    let placeHolderText: String
    let leadingImage:String?
    let trailingImage:String?
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         placeHolderText:String,
         leadingImage:String? = nil,
         trailingImage:String? = nil,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.placeHolderText = placeHolderText
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return StandardTextFieldTableViewCell.identifier()
    }
}
