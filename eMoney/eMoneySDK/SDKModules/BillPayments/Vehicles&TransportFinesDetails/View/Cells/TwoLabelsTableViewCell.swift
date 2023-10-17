//
//  TwoLabelsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 30/05/2023.
//

import UIKit

class TwoLabelsTableViewCell: StandardCell {

    @IBOutlet weak var trailingLabel: UILabel!
    @IBOutlet weak var leadingLabel: UILabel!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? TwoLabelsTableViewCellModel {
            leadingLabel.text = model.leadingTitle
            leadingLabel.font = model.leadingTitleFont
            leadingLabel.textColor = model.leadingTitleColor
            
            trailingLabel.text = model.trailingTitle
            trailingLabel.font = model.trailingTitleFont
            trailingLabel.textColor = model.trailingTitleColor
        }
    }
    
    func setUpUI(){
        
    }
    
}
// MARK: - Cell Model
final class TwoLabelsTableViewCellModel: StandardCellModel {
    
    let leadingTitle: String
    let leadingTitleFont:UIFont
    var leadingTitleColor:UIColor
    
    let trailingTitle: String
    let trailingTitleFont:UIFont
    let trailingTitleColor:UIColor
    
    
    init(actions: StandardCellModel.ActionsType = nil,
         leadingTitle: String,
         leadingTitleFont: UIFont = AppFont.appRegular(size: .body3),
         leadingTitleColor: UIColor = AppColor.eAnd_Black_80,
         trailingTitle: String,
         trailingTitleFont: UIFont = AppFont.appSemiBold(size: .body3),
         trailingTitleColor: UIColor = AppColor.eAnd_Black_80) {
        
        self.leadingTitle = leadingTitle
        self.leadingTitleFont = leadingTitleFont
        self.leadingTitleColor = leadingTitleColor
        self.trailingTitle = trailingTitle
        self.trailingTitleFont = trailingTitleFont
        self.trailingTitleColor = trailingTitleColor
        
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return TwoLabelsTableViewCell.identifier()
    }
    
}
