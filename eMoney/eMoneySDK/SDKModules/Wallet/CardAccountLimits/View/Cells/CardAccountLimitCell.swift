//
//  CardAccountLimitCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//

import UIKit

class CardAccountLimitCell: StandardCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var limitTextField: StandardTextField!
    @IBOutlet weak var limitSlider: UISlider!
    @IBOutlet weak var minLimitLabel: UILabel!
    @IBOutlet weak var maxLimitLabel: UILabel!
    
    // MARK: - Override Methods
    override func configureCell() {
        setUp()
        if let model = cellModel as? CardAccountLimitCellModel {
            titleLabel.text = model.title
            descriptionLabel.text = model.subTitle
            minLimitLabel.text = model.minLimit
            maxLimitLabel.text = model.maxLimit
            limitSlider.minimumValue = Float(model.minLimit)!
            limitSlider.maximumValue = Float(model.maxLimit)!
            limitTextField.title = model.placeHolderText
        }
    }
    
    private func setUp(){
        
        titleLabel.font = AppFont.appSemiBold(size: .body2)
        titleLabel.textColor = AppColor.eAnd_Black_80
        limitSlider.setThumbImage(UIImage(named: "Knob") ?? UIImage(), for: .normal)
        limitSlider.minimumTrackTintColor = AppColor.eAnd_Maroon
        limitSlider.maximumTrackTintColor = AppColor.eAnd_Best_seller
        descriptionLabel.font = AppFont.appRegular(size: .body2)
        descriptionLabel.textColor = AppColor.eAnd_Grey_100
        
        maxLimitLabel.font = AppFont.appRegular(size: .body2)
        maxLimitLabel.textColor = AppColor.eAnd_Black_80
        minLimitLabel.font = AppFont.appRegular(size: .body2)
        minLimitLabel.textColor = AppColor.eAnd_Black_80

    }
    
}

// MARK: - Cell Model
final class CardAccountLimitCellModel: StandardCellModel {
    let title: String
    let subTitle: String
    let placeHolderText:String?
    let minLimit:String
    let maxLimit:String
   
    init(actions: StandardCellModel.ActionsType = nil,
        title: String,
        subTitle: String,
        placeHolderText:String?,
        minLimit:String,
        maxLimit:String) {
        self.title = title
        self.subTitle = subTitle
        self.placeHolderText = placeHolderText
        self.minLimit = minLimit
        self.maxLimit = maxLimit
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return CardAccountLimitCell.identifier()
    }
}
