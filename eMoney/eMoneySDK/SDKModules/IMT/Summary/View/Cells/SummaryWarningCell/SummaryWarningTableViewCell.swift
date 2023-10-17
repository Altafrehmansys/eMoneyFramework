//
//  SummaryWarningTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//

import UIKit

class SummaryWarningTableViewCell: StandardCell {

    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var labelFraud: UILabel!
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var imageViewArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setInterface()

    }
    func setInterface(){
        labelFraud.text = "summary_fraud".localized
        self.viewOuter.clipsToBounds = true
        self.viewOuter.layer.cornerRadius = 12
        self.viewOuter.layer.borderWidth = 1
        self.viewOuter.layer.borderColor = AppColor.eAnd_Grey_30.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? SummaryWarningTableViewCellModel {
            labelFraud.text = model.desc
          
        }
    }
    
}
// MARK: - Cell model

final class SummaryWarningTableViewCellModel: StandardCellModel {

    let desc: String
    let imageUrl: String
    
    init(actions: StandardCellModel.ActionsType = nil, desc: String,imageUrl: String) {
        self.desc = desc
        self.imageUrl = imageUrl
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SummaryWarningTableViewCell.identifier()
    }
}
