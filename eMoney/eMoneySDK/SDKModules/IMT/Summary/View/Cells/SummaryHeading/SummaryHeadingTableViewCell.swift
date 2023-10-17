//
//  SummaryHeadingTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/05/2023.
//

import UIKit

class SummaryHeadingTableViewCell: StandardCell {

    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var imageViewEdit: UIImageView!
    @IBOutlet weak var labelRecipent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setInterface()
    }
    func setInterface(){
        labelRecipent.text = "recipient_details".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonEditTapped(_ sender: Any) {
        if let model = cellModel as? SummaryHeadingTableViewCellModel {
            model.actions?.cellSelected(0, model)
        }
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? SummaryHeadingTableViewCellModel {
            labelRecipent.text = model.title
          
        }
    }
}

// MARK: - Cell model

final class SummaryHeadingTableViewCellModel: StandardCellModel {

    let title: String
   
    init(actions: StandardCellModel.ActionsType = nil, title: String) {
        self.title = title
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SummaryHeadingTableViewCell.identifier()
    }
}
