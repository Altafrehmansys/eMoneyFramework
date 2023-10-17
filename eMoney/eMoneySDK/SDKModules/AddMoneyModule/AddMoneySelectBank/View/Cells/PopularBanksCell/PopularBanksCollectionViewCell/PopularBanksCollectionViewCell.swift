//
//  PopularBanksCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 14/04/2023.
//

import UIKit

final class PopularBanksCollectionViewCell: StandardCollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    private func setupUI() {
        serviceImage.cornerRadius = serviceImage.frame.height / 2
        
        serviceName.font = AppFont.appRegular(size: .body4)
        serviceName.textColor = AppColor.eAnd_Grey_100
        serviceName.textAlignment = .center
    }
    
    override func configureCell() {
        if let model = cellModel as? PopularBanksCollectionViewCellModel {
            serviceName.text = model.bank.bankName
            if let imageURL = model.bank.bankLogoAlt, imageURL.contains("http"), let url = URL(string: imageURL) {
                self.serviceImage.load(url: url)
            }
        }
    }
}


// MARK: - Cell Model
final class PopularBanksCollectionViewCellModel: StandardCellModel {
    let bank: AddMoneyMetaDataResponseModel.BankDataModel
    
    init(actions: StandardCellModel.ActionsType = nil,
         bank: AddMoneyMetaDataResponseModel.BankDataModel) {
        self.bank = bank
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return PopularBanksCollectionViewCell.identifier()
    }
}
