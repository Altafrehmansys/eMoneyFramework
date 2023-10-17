//
//  AutoAddMoneyCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//

import UIKit

class AutoAddMoneyCell: StandardCell {

    @IBOutlet weak var btnSwitch: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = self.cellModel as? AutoAddMoneyCellModel {
            titleLabel.text = model.title
        }
    }
    
    @IBAction func btnSwitchPressed(_ sender: Any) {
    
        if let model = self.cellModel as? AutoAddMoneyCellModel {
            model.actions?.cellSelected(0,model)
        }
    }
    
    private func setUpUI(){
        titleLabel.font = AppFont.appRegular(size: .body2)
        titleLabel.textColor = AppColor.eAnd_Black_80
    }
    
}

class AutoAddMoneyCellModel: StandardCellModel {
    let title:String
    let methodType: MethodOptionsBaseTypes?
    init(actions:StandardCellActions? = nil,
         title: String,
         methodType:MethodOptionsBaseTypes? = nil) {
        self.title = title
        self.methodType = methodType
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return AutoAddMoneyCell.identifier()
    }
}
