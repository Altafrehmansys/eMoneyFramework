//
//  MethodOptionTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//

import UIKit

final class MethodOptionTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var methodImageView: UIImageView!
    @IBOutlet weak var methodNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var ViewNewTag: UIView!
    @IBOutlet weak var LabelNewTag: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        methodImageView.cornerRadius = methodImageView.frame.height / 2
        
        methodNameLabel.font = AppFont.appRegular(size: .body3)
        methodNameLabel.textColor = AppColor.eAnd_Black_80
        
        subtitleLabel.font = AppFont.appRegular(size: .body4)
        subtitleLabel.textColor = AppColor.eAnd_Grey_100
        
        ViewNewTag.backgroundColor = AppColor.eAnd_Main_USP
        ViewNewTag.cornerRadius = 2
        LabelNewTag.font = AppFont.appSemiBold(size: .body5)
    }
    
    override func configureCell() {
        if let cellModel = cellModel as? MethodOptionTableViewCellModel {
            methodNameLabel.text = cellModel.name
            subtitleLabel.text = cellModel.subtitle
            subtitleLabel.isHidden = cellModel.subtitle == nil
            
            ViewNewTag.isHidden = !cellModel.isNewService
            LabelNewTag.text = Strings.AddMoney.lastUsedCapital
            
            arrowImg.isHidden = cellModel.hideArrowImage
            
            if cellModel.image.contains("http"), let url = URL(string: cellModel.image) {
                self.methodImageView.load(url: url)
            } else {
                self.methodImageView.image = UIImage(named: cellModel.image)
            }
        }
    }
}

// MARK: - Cell Model
final class MethodOptionTableViewCellModel: StandardCellModel {
    
    let image: String
    let name: String
    let subtitle: String?
    let isNewService: Bool
    let hideArrowImage: Bool
    let paymentSourceId: String?
    let accountId: String?
    
    /// Pass your type as a class here,
    /// you can create a class extends from MethodOptionsBaseTypes
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellActions? = nil,
         image: String,
         name: String,
         subtitle: String? = nil,
         isNewService: Bool = false,
         hideArrowImage: Bool = false,
         methodType: MethodOptionsBaseTypes? = nil,
         paymentSourceId: String? = nil,
         accountId: String? = nil) {
        self.image = image
        self.name = name
        self.subtitle = subtitle
        self.isNewService = isNewService
        self.hideArrowImage = hideArrowImage
        self.methodType = methodType
        self.paymentSourceId = paymentSourceId
        self.accountId = accountId
        super.init(actions: actions)
        
    }
    
    override func reusableIdentifier() -> String {
        return MethodOptionTableViewCell.identifier()
    }
}

// MARK: - Methods Base type
class MethodOptionsBaseTypes { }
