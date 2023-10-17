//
//  PayBillsServicesCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 14/04/2023.
//

import UIKit

final class PayBillsServicesCollectionViewCell: StandardCollectionViewCell {
    
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
        
        serviceName.font = AppFont.appRegular(size: .body5)
        serviceName.textColor = AppColor.eAnd_Black_80
        serviceName.textAlignment = .center
    }
    
    override func configureCell() {
        if let model = cellModel as? PayBillsServicesCollectionViewCellModel {
            serviceName.font = model.nameFont
            serviceName.textColor = model.nameColor
            serviceName.textAlignment = model.nameAlignment
            serviceName.text = model.name
            
            if model.image.contains("http"), let url = URL(string: model.image) {
                self.serviceImage.load(url: url)
            } else {
                self.serviceImage.image = UIImage(named: model.image)
            }
        }
    }
}


// MARK: - Cell Model
final class PayBillsServicesCollectionViewCellModel: StandardCellModel {
    let name: String
    let image: String
    let nameFont: UIFont
    let nameColor: UIColor
    let nameAlignment: NSTextAlignment
    
    init(actions: StandardCellModel.ActionsType = nil,
         name: String,
         image: String,
         nameFont: UIFont = AppFont.appRegular(size: .body5),
         nameColor: UIColor = AppColor.eAnd_Black_80,
         nameAlignment: NSTextAlignment = .center)
    {
        self.name = name
        self.image = image
        self.nameFont = nameFont
        self.nameColor = nameColor
        self.nameAlignment = nameAlignment
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return PayBillsServicesCollectionViewCell.identifier()
    }
}
