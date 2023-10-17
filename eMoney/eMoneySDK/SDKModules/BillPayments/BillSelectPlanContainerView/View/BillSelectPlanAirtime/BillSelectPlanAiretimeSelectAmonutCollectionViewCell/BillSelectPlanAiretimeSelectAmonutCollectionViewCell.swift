//
//  BillSelectPlanAiretimeSelectAcmoutCellCollectionViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 29/05/2023.
//

import UIKit

class BillSelectPlanAiretimeSelectAmonutCollectionViewCell: StandardCollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var secondAmountLabel: UILabel!
    @IBOutlet private weak var secondAmountIcon: UIImageView!
    @IBOutlet private weak var secondAmountContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
        setBottomViewContainer()
        setFonts()
    }

    private func setUI() {
        borderColor = AppColor.toolTipSuccessColor
        borderWidth = 1
    }
    
    private func setBottomViewContainer() {
        secondAmountContainerView.addGradient(colors: [AppColor.azureishWhite, AppColor.toolTipSuccessColor], locations: [0, 1], startPoint: CGPoint(x: 0.5, y: 1), endPoint:  CGPoint(x: 0.5, y: 0))
    }
    
    private func setFonts() {
        amountLabel.font = AppFont.appMedium(size: .body4)
        secondAmountLabel.font = AppFont.appRegular(size: .body5)
    }
    
    func config(item: Product) {
        amountLabel.text = "\(item.sendCurrencyIso ?? "") \(item.sendAmount ?? "")"
        secondAmountLabel.text = "\(item.receiveCurrencyIso ?? "") \(item.receiveAmount ?? "")"
    }

}
 
