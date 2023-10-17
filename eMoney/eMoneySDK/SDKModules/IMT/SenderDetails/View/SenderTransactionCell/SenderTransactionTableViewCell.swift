//
//  SenderTransactionTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 30/05/2023.
//

import UIKit

class SenderTransactionTableViewCell: StandardCell {

    @IBOutlet weak var button6To10: UIButton!
    @IBOutlet weak var button11To20: UIButton!
    @IBOutlet weak var buttonTwenty: UIButton!
    @IBOutlet weak var buttonLess5: UIButton!
    @IBOutlet weak var labelTransaction: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? SenderTransactionTableViewCellModel {
            //button6To10.setTitle(model.title, for: .normal)
        }
    }
    
}

// MARK: - Cell model
final class SenderTransactionTableViewCellModel: StandardCellModel {
    
    let title: String
    let text: String
    
    init(actions: StandardCellModel.ActionsType = nil, title: String, text: String) {
        self.title = title
        self.text = text
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SenderTransactionTableViewCell.identifier()
    }
}
