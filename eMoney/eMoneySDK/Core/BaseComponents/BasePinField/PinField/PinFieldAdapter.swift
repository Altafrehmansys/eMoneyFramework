//
//  PinFieldAdapter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 31/03/2023.
//

import UIKit

final class PinFieldAdapter: NSObject {

    var viewType: PinViewType = .loginPin
    
    var noOfPins = 4
    var pinViewSize = CGSize(width: 50, height: 50)
    var spacing: CGFloat = 6
    var isSeperatorShown: Bool = false
    var isMainViewBorderShown: Bool = false
    
    init(viewType: PinViewType) {
        self.viewType = viewType
        
        switch self.viewType {
        case .loginPin:
            noOfPins = 4
            spacing = 0
            pinViewSize = CGSize(width: 77, height: 64)
            isSeperatorShown = true
            isMainViewBorderShown = true
        case .otpPin:
            noOfPins = 4
            spacing = 16
            pinViewSize = CGSize(width: 70, height: 64)
            isSeperatorShown = false
            isMainViewBorderShown = false
        }
    }

}

// MARK: - OTPTextFieldData

extension PinFieldAdapter: OTPTextFieldData {
    func showBorderOnMainView() -> Bool {
        return isMainViewBorderShown
    }
    
    func showSeperatorBetweenFields() -> Bool {
        return isSeperatorShown
    }
    
    public func spaceBetweenViews() -> CGFloat {
        return spacing
    }

    public func numberOfPins() -> Int {
        return noOfPins
    }

    public func otpTextField(viewAt index: Int) -> PinContainer {
        
        guard let pinView = PinView.loadFromNib() as? PinView else {
            fatalError("Can't find class for init pinField")
        }
        pinView.viewType = self.viewType
        return pinView as PinContainer
    }

    public func otpTextField(sizeForViewAt index: Int) -> CGSize {
        return pinViewSize
    }

}
