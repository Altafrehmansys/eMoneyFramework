//
//  PlanBundleCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 26/05/2023.
//

import UIKit

class PlanBundleCell: StandardCell {
    @IBOutlet weak var lblPackage:UILabel!
    @IBOutlet weak var lblValidity:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    
    
}
final class PlanBundleCellModel: StandardCellModel {
    let package:String
    let packageColor:UIColor
    let packageFont:UIFont
    
    let validity:String
    let validityColor:UIColor
    let validityFont:UIFont
    
    let price:String
    let priceColor:UIColor
    let priceFont:UIFont
    
    init(package: String,
         packageColor: UIColor = AppColor.eAnd_Black_80,
         packageFont: UIFont = AppFont.appRegular(size: .body2),
         validity: String,
         validityColor: UIColor = AppColor.eAnd_Black_80,
         validityFont: UIFont = AppFont.appSemiBold(size: .body3),
         price: String,
         priceColor: UIColor = AppColor.eAnd_Black_80,
         priceFont: UIFont = AppFont.appSemiBold(size: .body3)) {
        self.package = package
        self.packageColor = packageColor
        self.packageFont = packageFont
        self.validity = validity
        self.validityColor = validityColor
        self.validityFont = validityFont
        self.price = price
        self.priceColor = priceColor
        self.priceFont = priceFont
    }
    override func reusableIdentifier() -> String {
        return PlanBundleCell.identifier()
    }
}
