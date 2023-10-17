//
//  EarnTransferTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 06/06/2023.
//

import UIKit

class EarnTransferTableViewCell: StandardCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var labelEarn: UILabel!
    @IBOutlet weak var imageViewLeft: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextAndInterface()
    }
    
    func setTextAndInterface(){
        labelEarn.text = "earn_points".localized
        labelEarn.textColor = AppColor.eAnd_Black_80
        labelEarn.font = AppFont.appMedium(size: .body4)
        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 12
        self.viewContent.layer.borderWidth = 1
        self.viewContent.layer.borderColor = AppColor.eAnd_Grey_30.cgColor
        self.viewContent.backgroundColor = AppColor.eAnd_Main_USP
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? EarnTransferTableViewCellModel {
            labelEarn.text = model.descriptions
            imageViewLeft.image = UIImage(named: model.image)
            self.viewContent.clipsToBounds = true
            self.viewContent.layer.cornerRadius = 12
            self.viewContent.layer.borderWidth = 1
            self.viewContent.layer.borderColor = model.color.cgColor
            self.viewContent.backgroundColor = model.color
          
        }
    }
    
}
// MARK: - Cell model

final class EarnTransferTableViewCellModel: StandardCellModel {

    let image: String
    let descriptions: String
    let color: UIColor
   
    init(actions: StandardCellModel.ActionsType = nil, image: String, descriptions: String, color: UIColor) {
        self.image = image
        self.descriptions = descriptions
        self.color = color
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return EarnTransferTableViewCell.identifier()
    }
}
