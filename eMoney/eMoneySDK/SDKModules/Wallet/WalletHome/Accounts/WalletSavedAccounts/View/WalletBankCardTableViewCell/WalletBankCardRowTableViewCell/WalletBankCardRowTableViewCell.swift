//
//  WalletBankCardRowTableViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 11/07/2023.
//

import UIKit

class WalletBankCardRowTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var cardNameLabel: UILabel!
    @IBOutlet private weak var cardNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUI() {
        cardNameLabel.font = AppFont.appRegular(size: .body4)
        cardNumberLabel.font = AppFont.appRegular(size: .body4)
    }
    
}
