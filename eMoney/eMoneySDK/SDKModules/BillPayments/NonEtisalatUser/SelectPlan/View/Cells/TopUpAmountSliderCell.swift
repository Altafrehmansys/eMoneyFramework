//
//  TopUpAmountSliderCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 26/05/2023.
//

import UIKit

class TopUpAmountSliderCell: StandardCell {
    @IBOutlet weak var tfAmount:BaseAmountField!
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var lblMin:UILabel!
    @IBOutlet weak var lblMax:UILabel!
    override func configureCell() {
        if let model = cellModel as? TopUpAmountSliderCellModel {
            tfAmount.currentColor = model.amountColor
            tfAmount.text = model.amount
            slider.value = model.currentRange
            slider.minimumValue = model.sliderMinRange
            slider.maximumValue = model.sliderMaxRange
            slider.setThumbImage(model.sliderThumbImage, for: .normal)
            slider.minimumTrackTintColor = model.sliderLeftSideColor
            slider.maximumTrackTintColor = model.sliderRightSideColor
            lblMin.text = "\(Int(model.sliderMinRange))"
            lblMin.font = model.minFont
            lblMin.textColor = model.minColor
            lblMax.text = "\(Int(model.sliderMaxRange))"
            lblMax.font = model.maxFont
            lblMax.textColor = model.maxColor
            tfAmount.textfieldFonts = [AppFont.appLight(size: .h4),AppFont.appLight(size: .h4)]
            tfAmount.isUserInteractionEnabled = true
        }
    }
    @IBAction func didMoveSlider(_ sender: UISlider) {
        self.tfAmount.text = "\(Int(sender.value))"
        if let model = self.cellModel {
            model.actions?.cellSelected(Int(sender.value),model)
        }
    }
}
final class TopUpAmountSliderCellModel:StandardCellModel {
    var amount:String
    let amountFont:UIFont
    let amountColor:UIColor
    
    let sliderLeftSideColor:UIColor!
    let sliderRightSideColor:UIColor!
    let sliderMinRange:Float
    let sliderMaxRange:Float
    var currentRange:Float
    let sliderHeight:CGFloat
    let sliderThumbImage:UIImage
    
    let minColor:UIColor
    let minFont:UIFont
    
    let maxColor:UIColor
    let maxFont:UIFont
    
    init(actions:StandardCellActions? = nil,
         amount: String,
         amountFont: UIFont = AppFont.appLight(size: .h4),
         amountColor: UIColor = AppColor.eAnd_Black_80,
         sliderLeftSideColor: UIColor = AppColor.eAnd_Maroon,
         sliderRightSideColor: UIColor = AppColor.eAnd_Best_seller,
         sliderMinRange: Float = 0,
         sliderMaxRange: Float = 250,
         currentRange:Float = 0,
         sliderHeight: CGFloat = 8.0,
         sliderThumbImage: UIImage = UIImage(named: "Knob") ?? UIImage(),
         minColor: UIColor = AppColor.eAnd_Grey_100,
         minFont: UIFont = AppFont.appMedium(size: .body4),
         maxColor: UIColor = AppColor.eAnd_Grey_100,
         maxFont: UIFont = AppFont.appMedium(size: .body4)) {
        self.amount = amount
        self.amountFont = amountFont
        self.amountColor = amountColor
        self.sliderLeftSideColor = sliderLeftSideColor
        self.sliderRightSideColor = sliderRightSideColor
        self.sliderMinRange = sliderMinRange
        self.sliderMaxRange = sliderMaxRange
        self.currentRange = currentRange
        self.sliderHeight = sliderHeight
        self.sliderThumbImage = sliderThumbImage
        self.minColor = minColor
        self.minFont = minFont
        self.maxColor = maxColor
        self.maxFont = maxFont
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return TopUpAmountSliderCell.identifier()
    }
}
