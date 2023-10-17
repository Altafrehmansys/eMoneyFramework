//
//  AppColor.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 15/03/2023.
//

import UIKit

struct AppColor {
    @available(*, unavailable) private init() {}
    
    static var defaultColor = UIColor.black
    static var eAnd_White = UIColor.white
    static var eAnd_Red = UIColor(named:"e&_Red") ?? defaultColor
    static var eAnd_Red_100 = UIColor(named:"e&_Red_100") ?? defaultColor
    static var eAnd_Maroon = UIColor(named:"e&_Maroon") ?? defaultColor
    static var eAnd_Baige = UIColor(named:"e&_Baige") ?? defaultColor 
    static var eAnd_Gray = UIColor(named:"e&_Gray") ?? defaultColor
    static var eAnd_Grey_10 = UIColor(named:"e&_Grey_10") ?? defaultColor
    static var eAnd_Grey_20 = UIColor(named:"e&_Grey_20") ?? defaultColor
    static var eAnd_Grey_30 = UIColor(named:"e&_Grey_30") ?? defaultColor
    static var eAnd_Grey_50 = UIColor(named:"e&_Grey_50") ?? defaultColor
    static var eAnd_Grey_70 = UIColor(named:"e&_Grey_70") ?? defaultColor
    static var eAnd_Grey_100 = UIColor(named:"e&_Grey_100") ?? defaultColor
    static var eAnd_Error_10 = UIColor(named:"e&_Error_10") ?? defaultColor
    static var eAnd_Error_100 = UIColor(named:"e&_Error_100") ?? defaultColor
    static var eAnd_Success_10 = UIColor(named:"e&_Success_10") ?? defaultColor
    static var eAnd_Success_100 = UIColor(named:"e&_Success_100") ?? defaultColor
    static var eAnd_Black = UIColor(named:"e&_Black") ?? defaultColor
    static var eAnd_Black_60 = UIColor(named:"e&_Black_60") ?? defaultColor
    static var eAnd_Black_70 = UIColor(named:"e&_Black_70") ?? defaultColor
    static var eAnd_Black_80 = UIColor(named:"e&_Black_80") ?? defaultColor
    static var eAnd_Shadow = UIColor(named:"e&_Shadow") ?? defaultColor
    static var eAnd_Online_Exclusive = UIColor(named:"e&_Online_Exclusive") ?? defaultColor
    static var eAnd_Limited_Offer = UIColor(named:"e&_Limited_offer") ?? defaultColor
    static var eAnd_Red_Gradient_Start = UIColor(named:"e&_Red_Gradient_Start") ?? defaultColor
    static var eAnd_Red_Gradient_End = UIColor(named:"e&_Red_Gradient_End") ?? defaultColor
    
    static var eAnd_Best_seller = UIColor(named:"e&_Best_seller") ?? defaultColor
    static var eAnd_Best_seller_light = UIColor(named:"e&_Best_seller_light") ?? defaultColor
    
    static var eAnd_bottom_sheet_background = UIColor(named:"e&_bottom_sheet_background") ?? defaultColor

    static var eAnd_Warning_100 = UIColor(named:"e&_Warning_100") ?? defaultColor
    static var eAnd_Warning_10 = UIColor(named:"e&_Warning_10") ?? defaultColor

    static var eAnd_Main_USP = UIColor(named:"e&_Main_USP") ?? defaultColor
    static var eAnd_Insight_10 = UIColor(named:"e&_Insight_10") ?? defaultColor


    static var dividerColor = eAnd_Grey_30
    
    static var disableSliderHex = eAnd_Grey_70
    static var greenSuccessHex = eAnd_Success_100
    static var disableAmountFieldColor = eAnd_Grey_100
    static var enableAmountFieldColor = eAnd_Black_80
    static var toolTipSuccessColor = UIColor(hex: "#DFEFDD")
    static let azureishWhite = UIColor(hex: "#D9ECF5")
   
    
    

    static var disabledButtonTextColor = eAnd_Grey_100
    static var enabledButtonTextColor = eAnd_White
    
    

    static let pinFieldErrorColor = AppColor.eAnd_Error_100
    static let pinFieldNormalColor = AppColor.eAnd_Grey_20
    static let pinFieldSelectedColor = AppColor.eAnd_Black_80
    
    
    //Color WithHex
    static var baseButtonGradiant1 = UIColor(hex: "#DE0801")
    static var baseButtonGradiant2 = UIColor(hex: "#950124")
    
    static var backGroundHeaderGradiant1 = UIColor(hex: "#DE0801")
    static var backGroundHeaderGradiant2 = UIColor(hex: "#6A041C")
    
    static var linearGradientStart = UIColor(hex: "#F3F3ED").withAlphaComponent(0.5)
    static var linearGradientEnd = UIColor(hex: "#E6E6DC").withAlphaComponent(0.5)
    static var numpadButtonColor = UIColor(hex: "#26273C")
    static let paidCardGradientBGStart = UIColor(hex: "#EE7670").withAlphaComponent(0.2)
    static let paidCardGradientBGEnd = UIColor(hex: "#F7E8D5").withAlphaComponent(0.2)

}
