//
//  TransactionHistoryCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 11/07/2023.
//

import UIKit

class TransactionHistoryCell: StandardCell {
    @IBOutlet weak var leftImage:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblSubtitle:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblAmount:UILabel!
    @IBOutlet weak var pointsImage: UIImageView!
    @IBOutlet weak var lblPoint:UILabel!
    override func configureCell() {
        if let model = self.cellModel as? TransactionHistoryCellModel {
            self.leftImage.image = UIImage(named: model.leftImage)
            
            self.lblTitle.text = model.title
            self.lblTitle.font = model.titleFont
            self.lblTitle.textColor = model.titleColor
            
            self.lblSubtitle.text = model.subtitle
            self.lblSubtitle.font = model.subtitleFont
            self.lblSubtitle.textColor = model.subtitleColor
            
            self.lblDate.text = model.date
            self.lblDate.font = model.dateFont
            self.lblDate.textColor = model.dateColor
            
            self.lblAmount.text = model.amount
            self.lblAmount.font = model.amountFont
            self.lblAmount.textColor = model.amountColor
            
            self.pointsImage.image = UIImage(named: "transaction-points")
            self.lblPoint.text = model.points
            self.lblPoint.font = model.pointsFont
            self.lblPoint.textColor = model.pointsColor
        }
    }
}
final class TransactionHistoryCellModel: StandardCellModel {
    let leftImage:String
    
    let title:String
    let titleFont:UIFont
    let titleColor:UIColor
    
    let subtitle:String
    let subtitleFont:UIFont
    let subtitleColor:UIColor
    
    let date:String
    let dateFont:UIFont
    let dateColor:UIColor
    
    let amount:String
    let amountFont:UIFont
    let amountColor:UIColor
    
    let points:String?
    let pointsFont:UIFont
    let pointsColor:UIColor
    
    init(actions: StandardCellActions? = nil,
         leftImage:String,
         title:String,
         titleFont:UIFont = AppFont.appSemiBold(size: .body3),
         titleColor:UIColor = AppColor.eAnd_Black_80,
         subtitle:String,
         subtitleFont:UIFont = AppFont.appRegular(size: .body3),
         subtitleColor:UIColor = AppColor.eAnd_Black_80,
         date:String,
         dateFont:UIFont = AppFont.appRegular(size: .body4),
         dateColor:UIColor = AppColor.eAnd_Grey_70,
         amount:String,
         amountFont:UIFont = AppFont.appSemiBold(size: .body3),
         amountColor:UIColor = AppColor.eAnd_Black_80,
         points:String?,
         pointsFont:UIFont = AppFont.appRegular(size: .body3),
         pointsColor:UIColor = AppColor.eAnd_Black_80)
    {
        self.leftImage = leftImage
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subtitle = subtitle
        self.subtitleFont = subtitleFont
        self.subtitleColor = subtitleColor
        self.date = date
        self.dateFont = dateFont
        self.dateColor = dateColor
        self.amount = amount
        self.amountFont = amountFont
        self.amountColor = amountColor
        self.points = points
        self.pointsFont = pointsFont
        self.pointsColor = pointsColor
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        String(describing: TransactionHistoryCell.self)
    }
}
