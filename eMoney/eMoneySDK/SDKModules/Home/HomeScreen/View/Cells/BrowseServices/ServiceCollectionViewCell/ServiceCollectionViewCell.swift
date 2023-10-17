//
//  ServiceCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit

final class ServiceCollectionViewCell: StandardCollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageContainerView.cornerRadius = 12
        imageContainerView.borderWidth = 0.46
        imageContainerView.borderColor = AppColor.eAnd_Grey_20
        
        titleLabel.font = AppFont.appRegular(size: .body5)
        titleLabel.textColor = AppColor.eAnd_Black_60
        
        imageContainerView.addShadow(shadowOpacity: 1, shadowRadius: 4, shadowOffset: CGSize(width: 0, height: 1), shadowColor: AppColor.eAnd_Shadow)
    }

    override func configureCell() {
        if let model = cellModel as? ServiceCollectionViewCellModel {
            titleLabel.text = model.name
            imageView.image = UIImage(named: model.image)
        }
    }
}

// MARK: - ServiceCollectionViewCellModel
final class ServiceCollectionViewCellModel: StandardCellModel {
    let name: String
    let image: String
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         name: String,
         image: String, methodType: MethodOptionsBaseTypes? = nil)
    {
        self.name = name
        self.image = image
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ServiceCollectionViewCell.identifier()
    }
}
