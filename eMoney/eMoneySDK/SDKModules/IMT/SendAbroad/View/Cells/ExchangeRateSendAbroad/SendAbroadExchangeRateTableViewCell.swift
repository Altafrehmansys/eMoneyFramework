//
//  SendAbroadExchangeRateTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 22/06/2023.
//

import UIKit

class SendAbroadExchangeRateTableViewCell: StandardCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imageViewNotification: UIImageView!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var labelHeading: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    func setUI(){
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func configureCell() {
        
        if let model = cellModel as? SendAbroadExchangeRateTableViewCellModel {
            labelHeading.text = model.title
            labelDesc.text = model.desc
        }
    }
    
}

// MARK: - Cell model
final class SendAbroadExchangeRateTableViewCellModel: StandardCellModel {

    let title: String
    let desc: String
   
    init(actions: StandardCellModel.ActionsType = nil, title: String, desc: String) {
        self.title = title
        self.desc = desc
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SendAbroadExchangeRateTableViewCell.identifier()
    }
}
