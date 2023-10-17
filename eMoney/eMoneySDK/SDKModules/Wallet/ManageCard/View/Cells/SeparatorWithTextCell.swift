//
//  SeparatorWithTextCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//

import UIKit

class SeparatorWithTextCell: StandardCell {

    @IBOutlet weak var separatorTextLabel: UILabel!
    override func configureCell() {
        setUpUI()
        if let model = self.cellModel as? SeparatorWithTextCellModel {
            separatorTextLabel.text = model.text
        }
    }
    private func setUpUI(){
        separatorTextLabel.font = AppFont.appSemiBold(size: .body3)
        separatorTextLabel.textColor = AppColor.eAnd_Grey_100
    }
}

class SeparatorWithTextCellModel: StandardCellModel {
    let text:String
    init(actions:StandardCellActions? = nil,
        text:String) {
        self.text = text
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return SeparatorWithTextCell.identifier()
    }
}
