//
//  OrderPhysicalCardCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/07/2023.
//

import UIKit

class OrderPhysicalCardCell: StandardCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var btnOrder:BaseButton!
    @IBOutlet weak var cardImage: UIImageView!
    override func configureCell() {
        if let model = self.cellModel as? OrderPhysicalCardCellModel {
            self.bgView.backgroundColor = model.backgroundColor
            self.lblTitle.text = model.title
            self.lblTitle.font = model.titleFont
            self.lblTitle.textColor = model.titleColor
            self.btnOrder.setTitle(model.buttonTitle, for: .normal)
            self.btnOrder.type = model.buttonType
            self.cardImage.image = UIImage(named: model.rightImage)
            
        }
    }
    @IBAction func didTapOrder(_ sender: UIButton) {
        if let model = self.cellModel as? OrderPhysicalCardCellModel {
            model.actions?.cellSelected(0,model)
        }
    }
    
}
class OrderPhysicalCardCellModel: StandardCellModel {
    let backgroundColor:UIColor
    let title:String
    let titleFont:UIFont
    let titleColor:UIColor
    let buttonTitle:String
    let buttonType:BaseButtonType
    let rightImage:String
    init(actions:StandardCellActions? = nil,
         backgroundColor: UIColor = AppColor.eAnd_Error_10,
         title: String = Strings.Wallet.get_your_physical_card,
         titleFont: UIFont = AppFont.appRegular(size: .body3),
         titleColor: UIColor = AppColor.eAnd_Black_80,
         buttonTitle: String = Strings.Wallet.order,
         buttonType: BaseButtonType = .GradientButton,
         rightImage:String = "order-physical-card") {
        self.backgroundColor = backgroundColor
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.buttonTitle = buttonTitle
        self.buttonType = buttonType
        self.rightImage = rightImage
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return String(describing: OrderPhysicalCardCell.self)
    }
}
