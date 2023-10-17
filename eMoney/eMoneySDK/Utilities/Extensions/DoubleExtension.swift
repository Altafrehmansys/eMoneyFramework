//
//  DoubleExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 06/06/2023.
//

import Foundation

extension Double {
    var formattedPrice: String {
        return String(format: "%.2f", self)
    }
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var formattedAmountWithComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        let formattedAmount = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        return formattedAmount
    }
    func addCurrency()->String {
        //FIXME: Handle RTL case.
        return "AED \(self.formattedAmountWithComma)"
    }
}
