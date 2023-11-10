//
//  VerticalCheckBoxCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/06/2023.
//

import UIKit

class VerticalCheckBoxCellType: MethodOptionsBaseTypes {
    enum CellType {
        case violationPayment
        case MawaqifAccountTopUp
        case none
    }
    var type: CellType = .none
    init(type: CellType) {
        self.type = type
    }
}

class VerticalCheckBoxCell: StandardCell {

    @IBOutlet weak var btnCheckBox: UIButton!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? VerticalCheckBoxCellModel {
            btnCheckBox.setTitle(model.title, for:.normal)
            btnCheckBox.setImage(UIImage(named: model.isSelected ? "radio_unselected":"radio_selected"), for:.normal)
        }
    }
    
    func setUpUI(){
        btnCheckBox.titleLabel?.textColor = AppColor.eAnd_Black_80
        btnCheckBox.titleLabel?.font = AppFont.appRegular(size: .body4)
    }
    
    @IBAction func btnCheckBoxPressed(_ sender: Any) {
        if let model = self.cellModel as? VerticalCheckBoxCellModel {
            model.actions?.cellSelected(0,model)
        }
    }
}

// MARK: - Cell Model
final class VerticalCheckBoxCellModel: StandardCellModel {
    
    let title: String
    var isSelected:Bool
    let cellType:VerticalCheckBoxCellType?
    init(actions: StandardCellModel.ActionsType = nil,
         title:String,
         isSelected:Bool,
         cellType:VerticalCheckBoxCellType? = nil) {
        self.title = title
        self.isSelected = isSelected
        self.cellType = cellType
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return VerticalCheckBoxCell.identifier()
    }
}
