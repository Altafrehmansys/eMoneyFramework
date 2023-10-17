//
//  LinkedBanksTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 04/08/2023.
//

import UIKit

class LinkedBanksTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var lastUsedTagView: UIView!
    @IBOutlet weak var lastUsedTagLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bankImageView.cornerRadius = bankImageView.frame.height / 2
        
        nameLabel.font = AppFont.appRegular(size: .body3)
        nameLabel.textColor = AppColor.eAnd_Black_80
        
        subtitleLabel.font = AppFont.appRegular(size: .body4)
        subtitleLabel.textColor = AppColor.eAnd_Grey_100
        
        lastUsedTagView.backgroundColor = AppColor.eAnd_Main_USP
        lastUsedTagView.cornerRadius = 2
        lastUsedTagLabel.font = AppFont.appSemiBold(size: .body5)
    }
    
    
    override func configureCell() {
        if let cellModel = cellModel as? LinkedBanksTableViewCellModel {
            nameLabel.text = cellModel.account.accountName
            subtitleLabel.text = cellModel.account.maskedAccountNumber
            
            lastUsedTagView.isHidden = !(cellModel.account.lastUsed ?? false)
            lastUsedTagLabel.text = Strings.AddMoney.lastUsedCapital
            
            if let image = cellModel.bank.bankLogoAlt, let url = URL(string: image) {
                self.bankImageView.load(url: url)
            }
            
            updateUI()
        }
    }
    
    private func updateUI() {
        if let tableView = self.superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

// MARK: - Cell Model
final class LinkedBanksTableViewCellModel: StandardCellModel {
    
    let bank: BankAccountsListResponseModel.PaymentSources
    let account:  BankAccountsListResponseModel.Accounts
    
    init(actions: StandardCellActions? = nil,
         bank: BankAccountsListResponseModel.PaymentSources,
         account:  BankAccountsListResponseModel.Accounts) {
        self.bank = bank
        self.account = account
        super.init(actions: actions)
        
    }
    
    override func reusableIdentifier() -> String {
        return LinkedBanksTableViewCell.identifier()
    }
}
