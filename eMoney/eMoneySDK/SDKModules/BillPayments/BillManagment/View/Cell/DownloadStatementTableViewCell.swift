//
//  DownloadStatementTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/06/2023.
//

import UIKit

class DownloadStatementTableViewCell: StandardCell {

    @IBOutlet weak var endDateTextField: StandardTextField!
    @IBOutlet weak var startDateTextField: StandardTextField!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? DownloadStatementTableViewCellModel {
            self.startDateTextField.title = model.startDatePlaceHolderText
            self.endDateTextField.title = model.endDatePlaceHolderText
    
            if let startDateTrailingImage = model.startDatetrailingImage{
                startDateTextField.trailingButtonImage = startDateTrailingImage
            }
            if let endDateTrailingImage = model.endDatetrailingImage{
                endDateTextField.trailingButtonImage = endDateTrailingImage
            }
        }
    }
    func setUpUI() {
        
        startDateTextField.textFieldFont = AppFont.appRegular(size: .body2)
        startDateTextField.textFieldTextColor = AppColor.eAnd_Black_80
        endDateTextField.textFieldFont = AppFont.appRegular(size: .body2)
        endDateTextField.textFieldTextColor = AppColor.eAnd_Black_80
        
    }
}

// MARK: - Cell Model
final class DownloadStatementTableViewCellModel: StandardCellModel {
    
    let startDatePlaceHolderText: String
    let endDatePlaceHolderText: String
    let startDatetrailingImage:String?
    let endDatetrailingImage:String?
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         startDatePlaceHolderText:String,
         endDatePlaceHolderText:String,
         startDatetrailingImage:String? = nil,
         endDatetrailingImage:String? = nil,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.startDatePlaceHolderText = startDatePlaceHolderText
        self.endDatePlaceHolderText = endDatePlaceHolderText
        self.startDatetrailingImage = startDatetrailingImage
        self.endDatetrailingImage = endDatetrailingImage
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return DownloadStatementTableViewCell.identifier()
    }
}
