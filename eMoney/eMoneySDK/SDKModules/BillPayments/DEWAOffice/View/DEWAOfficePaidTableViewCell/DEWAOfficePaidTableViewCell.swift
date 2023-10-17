//
//  DEWAOfficePaidTableViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 05/06/2023.
//

import UIKit

class DEWAOfficePaidTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cardViewContainer: UIView!
    @IBOutlet private weak var paidToLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var paidSuccessLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        setFonts()
        setCardBackground()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setFonts() {
        paidToLabel.font = AppFont.appSemiBold(size: .body2)
        timeLabel.font = AppFont.appRegular(size: .body5)
        paidSuccessLabel.font =   AppFont.appRegular(size: .body4)
        amountLabel.font = AppFont.appSemiBold(size: .body3)
    }
    
    private func setCardBackground() {
        cardViewContainer.addGradient(colors: [
            AppColor.paidCardGradientBGStart,
            AppColor.paidCardGradientBGEnd
        ], locations: nil, startPoint: .unitCoordinate(.left), endPoint: .unitCoordinate(.right))
    }
    
}
