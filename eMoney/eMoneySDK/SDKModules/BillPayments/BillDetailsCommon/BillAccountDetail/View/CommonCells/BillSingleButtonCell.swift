//
//  BillSingleButtonCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/06/2023.
//

import UIKit

class BillSingleButtonCell: StandardCell {

    @IBOutlet weak var cellButton: UIButton!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? BillSingleButtonCellModel {
            cellButton.setTitle(model.title, for:.normal)
        }
    }
    
    func setUpUI(){
        cellButton.titleLabel?.textColor = AppColor.eAnd_Red_100
        cellButton.titleLabel?.font = AppFont.appMedium(size: .body4)
    }
    
}

// MARK: - Cell Model
final class BillSingleButtonCellModel: StandardCellModel {

    let title: String
    init(actions: StandardCellModel.ActionsType = nil,
         title:String) {
        self.title = title
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return BillSingleButtonCell.identifier()
    }
}
