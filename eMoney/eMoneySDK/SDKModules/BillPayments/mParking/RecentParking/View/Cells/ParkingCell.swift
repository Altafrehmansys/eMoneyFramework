//
//  ParkingCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 15/06/2023.
//

import UIKit

class ParkingCell: StandardCell {
    @IBOutlet weak var leftImage:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblSubtitle:UILabel!
    @IBOutlet weak var lblParkingDuration:UILabel!
    @IBOutlet weak var lblDateTime:UILabel!
    @IBOutlet weak var viewTimeLeft:UIView!
    @IBOutlet weak var btnTimeLeft: UIButton!
    @IBOutlet weak var btnExtend: UIButton!
    override func configureCell() {
        if let model = self.cellModel as? ParkingCellModel {
            if let image = UIImage(named: /model.leftImage) {
                self.leftImage.image = image
            }else {
                if let url = URL(string: /model.leftImage) {
                    self.leftImage.load(url: url)
                }
            }
            self.lblTitle.text = model.title
            self.lblTitle.textColor = model.titleColor
            self.lblTitle.font = model.titleFont
            
            self.lblSubtitle.text = model.subTitle
            self.lblSubtitle.textColor = model.subTitleColor
            self.lblSubtitle.font = model.subTitleFont
            
            self.lblParkingDuration.text = model.parkingDuration
            self.lblParkingDuration.textColor = model.parkingDurationColor
            self.lblParkingDuration.font = model.parkingDurationFont
            
            self.lblDateTime.text = model.dateTime
            self.lblDateTime.textColor = model.dateTimeColor
            self.lblDateTime.font = model.dateTimeFont
            
            self.lblTitle.text = model.title
            self.lblTitle.textColor = model.titleColor
            self.lblTitle.font = model.titleFont
            
            self.btnTimeLeft.isUserInteractionEnabled = false
            self.btnTimeLeft.setTitle(model.timeLeft?.localized, for: .normal)
//            self.btnTimeLeft.setImage(UIImage(named: "clock-red"), for: .normal)
            self.btnTimeLeft.titleLabel?.textColor = model.timeLeftColor
            self.btnTimeLeft.backgroundColor = AppColor.eAnd_Error_10
            self.btnTimeLeft.roundCorners(corners: UIRectCorner.allCorners, radius: 10)
            self.btnTimeLeft.titleLabel?.font = model.timeLeftFont
            
            self.btnExtend.setTitle(model.extendHr, for: .normal)
            self.btnExtend.setTitleColor(model.extendHrColor, for: .normal) 
            self.btnExtend.titleLabel?.font = model.extendHrFont
        }
    }
}
final class ParkingCellModel:StandardCellModel {
    let leftImage:String?
    
    let title:String?
    let titleColor:UIColor?
    let titleFont:UIFont?
    
    let subTitle:String?
    let subTitleColor:UIColor?
    let subTitleFont:UIFont?
    
    let parkingDuration:String?
    let parkingDurationColor:UIColor?
    let parkingDurationFont:UIFont?
    
    let dateTime:String?
    let dateTimeColor:UIColor?
    let dateTimeFont:UIFont?
    
    let timeLeft:String?
    let timeLeftColor:UIColor?
    let timeLeftFont:UIFont?
    
    let extendHr:String?
    let extendHrColor:UIColor?
    let extendHrFont:UIFont?
    
    init(actions: StandardCellActions? = nil,
         leftImage:String?,
         title:String?,
         titleColor:UIColor? = AppColor.eAnd_Black_80,
         titleFont:UIFont? = AppFont.appSemiBold(size: .body2),
         subTitle:String?,
         subTitleColor:UIColor? = AppColor.eAnd_Grey_70,
         subTitleFont:UIFont? = AppFont.appRegular(size: .body3),
         parkingDuration:String?,
         parkingDurationColor:UIColor? = AppColor.eAnd_Grey_70,
         parkingDurationFont:UIFont? = AppFont.appRegular(size: .body3),
         dateTime:String?,
         dateTimeColor:UIColor? = AppColor.eAnd_Grey_70,
         dateTimeFont:UIFont? = AppFont.appRegular(size: .body3),
         timeLeft:String?,
         timeLeftColor:UIColor? = AppColor.eAnd_Error_100,
         timeLeftFont:UIFont? = AppFont.appRegular(size: .body4),
         extendHr:String?,
         extendHrColor:UIColor? = AppColor.eAnd_Error_100,
         extendHrFont:UIFont? = AppFont.appMedium(size: .body4))
    {
        self.leftImage = leftImage
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.subTitle = subTitle
        self.subTitleColor = subTitleColor
        self.subTitleFont = subTitleFont
        self.parkingDuration = parkingDuration
        self.parkingDurationColor = parkingDurationColor
        self.parkingDurationFont = parkingDurationFont
        self.dateTime = dateTime
        self.dateTimeColor = dateTimeColor
        self.dateTimeFont = dateTimeFont
        self.timeLeft = timeLeft
        self.timeLeftColor = timeLeftColor
        self.timeLeftFont = timeLeftFont
        self.extendHr = extendHr
        self.extendHrColor = extendHrColor
        self.extendHrFont = extendHrFont
        
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return String(describing: ParkingCell.self)
    }
}
