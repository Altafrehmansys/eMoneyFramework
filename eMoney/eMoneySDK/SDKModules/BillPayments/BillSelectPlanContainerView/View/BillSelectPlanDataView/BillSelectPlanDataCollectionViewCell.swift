//
//  BillSelectPlanDataCollectionViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 30/05/2023.
//

import UIKit

class BillSelectPlanDataCollectionViewCell: StandardCollectionViewCell {

    
    // MARK: - Outlets
    @IBOutlet private weak var quotaLabel: UILabel!
    @IBOutlet private weak var validUntilLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var quotaContainerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
        setQuotaViewContainer()
        setFonts()
    }

    private func setUI() {
        borderColor = AppColor.toolTipSuccessColor
        borderWidth = 1
    }
    
    private func setQuotaViewContainer() {
        quotaContainerView.addGradient(colors: [AppColor.azureishWhite, AppColor.toolTipSuccessColor], locations: [0, 1], startPoint: CGPoint(x: 0.5, y: 1), endPoint:  CGPoint(x: 0.5, y: 0), cornerRadius: 0)
    }
    
    private func setFonts() {
        quotaLabel.font = AppFont.appRegular(size: .body2)
        validUntilLabel.font = AppFont.appSemiBold(size: .body3)
        amountLabel.font = AppFont.appSemiBold(size: .body3)
    }
    
    func config(item: Product) {
        amountLabel.text = "\(item.sendCurrencyIso ?? "") \(item.sendAmount ?? "")"
        quotaLabel.text = "2G Quota"
        validUntilLabel.text = "30 days validation"
    }
}
