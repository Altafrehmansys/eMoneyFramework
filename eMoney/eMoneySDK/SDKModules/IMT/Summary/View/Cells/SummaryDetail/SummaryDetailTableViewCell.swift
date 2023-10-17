//
//  SummaryDetailTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//

import UIKit

class SummaryDetailTableViewCell: StandardCell {

    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var imageViewArrow: UIImageView!
    @IBOutlet weak var imageViewInfo: UIImageView!
    @IBOutlet weak var labeDesc: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setInterface()
    }
    
    func setInterface(){
        self.labelTitle.text = "sender_title".localized
        self.labeDesc.text = "sender_desc".localized
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
        if let model = cellModel as? SummaryDetailTableViewCellModel {
            labelTitle.text = model.title
            labeDesc.text = model.desc
        }
    }
    
}

// MARK: - Cell model

final class SummaryDetailTableViewCellModel: StandardCellModel {
    let title: String
    let desc: String
    let imageUrl: String
    
    init(actions: StandardCellModel.ActionsType = nil,title: String, desc: String,imageUrl: String) {
        self.title = title
        self.desc = desc
        self.imageUrl = imageUrl
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SummaryDetailTableViewCell.identifier()
    }
}
