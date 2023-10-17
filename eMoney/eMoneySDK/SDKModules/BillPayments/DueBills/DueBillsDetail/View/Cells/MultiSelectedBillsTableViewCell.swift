//
//  MultiSelectedBillsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/06/2023.
//

import UIKit

class MultiSelectedBillsTableViewCell: StandardCell {

    @IBOutlet weak var cellParenView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? MultiSelectedBillsTableViewCellModel {
            self.titleLabel.text = model.title
            self.subTitleLabel.text = model.subTitle
        }
    }
    func setUpUI() {
        titleLabel.font = AppFont.appRegular(size: .body3)
        titleLabel.textColor = AppColor.eAnd_Black_80
        subTitleLabel.font = AppFont.appRegular(size: .body4)
        subTitleLabel.textColor = AppColor.eAnd_Grey_100
        cellParenView.backgroundColor = AppColor.eAnd_Grey_10
    }
    
}

class MultiSelectedBillsTableViewCellModel:StandardCellModel{
    
    let title: String
    let subTitle: String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         subTitle: String,
         methodType:MethodOptionsBaseTypes? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return MultiSelectedBillsTableViewCell.identifier()
    }
}
