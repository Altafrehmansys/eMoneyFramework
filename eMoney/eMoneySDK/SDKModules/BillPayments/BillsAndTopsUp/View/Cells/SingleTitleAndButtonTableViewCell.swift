//
//  SingleTitleAndButtonTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 18/05/2023.
//

import UIKit

class SingleTitleAndButtonTableViewCell: StandardCell {

    @IBOutlet weak var btnViewAll: BaseButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? SingleTitleAndButtonTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleColor
         
            btnViewAll.setTitle(model.buttonTitle, for: .normal)
            btnViewAll.titleLabel?.font = AppFont.appMedium(size:.body4)
            btnViewAll.setTitleColor(model.buttonTitleColor, for: .normal)
            
        }
    }
    
    func setUpUI(){
        btnViewAll.type = .PlainButton
    }
    private func setup() {
        btnViewAll.addTarget(self, action: #selector(trailingButtonTappedAction(_:)), for: .touchUpInside)
    }
    @objc func trailingButtonTappedAction(_ sender: BaseButton) {
        if let cellModel {
            cellModel.actions?.cellSelected(0, cellModel)
        }
    }
    
}

// MARK: - Cell Model
final class SingleTitleAndButtonTableViewCellModel: StandardCellModel {
    
    let title: String
    let titleFont:UIFont
    let titleColor:UIColor
    let buttonTitle:String
    let buttonFont:UIFont
    let buttonTitleColor:UIColor

    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appSemiBold(size: .body2),
         titleColor: UIColor = AppColor.eAnd_Black_80,
         buttonTitle: String,
         buttonFont: UIFont = AppFont.appMedium(size: .body4),
         buttonTitleColor: UIColor = AppColor.eAnd_Red_100) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.buttonTitle = buttonTitle
        self.buttonFont = buttonFont
        self.buttonTitleColor = buttonTitleColor
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SingleTitleAndButtonTableViewCell.identifier()
    }
}
