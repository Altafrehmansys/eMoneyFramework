//
//  RecipentDetailsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/05/2023.
//

import UIKit

class RecipentDetailsTableViewCell: StandardCell {

    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var labelIban: UILabel!
    @IBOutlet weak var labelIbanHeading: UILabel!
    @IBOutlet weak var labelBankName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewName: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setInterface()
    }
    func setInterface(){
        labelIbanHeading.text = "iban".localized
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
        if let model = cellModel as? RecipentDetailsTableViewCellModel {
            labelIban.text = model.name
          
        }
    }
    
}

// MARK: - Cell model

final class RecipentDetailsTableViewCellModel: StandardCellModel {

    let name: String
    let bankName: String
    let iban: String
    let imageUrl: String
    
   
    init(actions: StandardCellModel.ActionsType = nil, name: String, bankName: String, iban: String, imageUrl: String) {
        self.name = name
        self.bankName = bankName
        self.iban = iban
        self.imageUrl = imageUrl
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return RecipentDetailsTableViewCell.identifier()
    }
}
