//
//  LinkedCardsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 16/06/2023.
//

import UIKit

final class LinkedCardsTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var lastUsedTagView: UIView!
    @IBOutlet weak var lastUsedTagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardImageView.cornerRadius = cardImageView.frame.height / 2
        
        cardNameLabel.font = AppFont.appRegular(size: .body3)
        cardNameLabel.textColor = AppColor.eAnd_Black_80
        
        subtitleLabel.font = AppFont.appRegular(size: .body4)
        subtitleLabel.textColor = AppColor.eAnd_Grey_100
        
        lastUsedTagView.backgroundColor = AppColor.eAnd_Main_USP
        lastUsedTagView.cornerRadius = 2
        lastUsedTagLabel.font = AppFont.appSemiBold(size: .body5)
    }
    
    override func configureCell() {
        if let cellModel = cellModel as? LinkedCardsTableViewCellModel {
            cardNameLabel.text = cellModel.card.brand ?? ""
            subtitleLabel.text = (cellModel.card.subtype ?? "") + " " + Strings.AddMoney.card + " " + (cellModel.card.maskedCardNumber ?? "")
            
            lastUsedTagView.isHidden = !(cellModel.card.lastUsed ?? false)
            lastUsedTagLabel.text = Strings.AddMoney.lastUsedCapital
            
            if let image = cellModel.card.imageUrl, let url = URL(string: image) {
                self.cardImageView.load(url: url)
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
final class LinkedCardsTableViewCellModel: StandardCellModel {
    
    let card: CardResponseObjectModel.CardResponseObjectDataModel
    
    init(actions: StandardCellActions? = nil,
         card: CardResponseObjectModel.CardResponseObjectDataModel) {
        self.card = card
        super.init(actions: actions)
        
    }
    
    override func reusableIdentifier() -> String {
        return LinkedCardsTableViewCell.identifier()
    }
}
