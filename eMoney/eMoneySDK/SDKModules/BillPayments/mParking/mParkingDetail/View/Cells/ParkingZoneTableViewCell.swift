//
//  ParkingZoneTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//

import UIKit

class ParkingZoneTableViewCell: StandardCell {

    @IBOutlet weak var zoneTextField: StandardTextField!
    // MARK: - Override Methods
    override func configureCell() {
       
        setUpTextField()
        if let model = cellModel as? ParkingZoneTableViewCellModel {
            self.zoneTextField.title = model.dropDownPlaceHolderText
        }
    }
    
    func setUpTextField(){
        zoneTextField.prefixFont = AppFont.appRegular(size: .body4)
        zoneTextField.textFieldTextColor = AppColor.eAnd_Black_80
        zoneTextField.postFix = "Detect"
        zoneTextField.postFixFont = AppFont.appMedium(size: .body4)
        zoneTextField.postFixColor = AppColor.eAnd_Red_100
        zoneTextField.trailingButtonImage = ""
    }
    
}

// MARK: - Cell Model
final class ParkingZoneTableViewCellModel: StandardCellModel {
    let dropDownPlaceHolderText: String
    init(actions: StandardCellModel.ActionsType = nil,
         dropDownPlaceHolderText:String) {
        self.dropDownPlaceHolderText = dropDownPlaceHolderText
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ParkingZoneTableViewCell.identifier()
    }
}
