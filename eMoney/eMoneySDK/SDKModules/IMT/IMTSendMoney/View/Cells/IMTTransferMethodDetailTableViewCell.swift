//
//  IMTTransferMethodDetailTableViewCell.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//

import UIKit

class IMTTransferMethodDetailTableViewCell: StandardCell {

    @IBOutlet weak var liveRateTitle: UILabel!
    @IBOutlet weak var liveRateValue: UILabel!
    @IBOutlet weak var feesTitle: UILabel!
    @IBOutlet weak var feesValue: UILabel!
    @IBOutlet weak var durationTitle: UILabel!
    @IBOutlet weak var durationIcon: UIImageView!
    @IBOutlet weak var durationValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI(){
        self.liveRateTitle.font = AppFont.appRegular(size: .body3)
        self.liveRateTitle.textColor = AppColor.eAnd_Grey_70
        self.liveRateValue.font = AppFont.appRegular(size: .body3)
        self.liveRateValue.textColor = AppColor.eAnd_Black_80
        
        self.feesTitle.font = AppFont.appRegular(size: .body3)
        self.feesTitle.textColor = AppColor.eAnd_Grey_70
        self.feesValue.font = AppFont.appRegular(size: .body3)
        self.feesValue.textColor = AppColor.eAnd_Black_80
        
        self.durationTitle.font = AppFont.appRegular(size: .body3)
        self.durationTitle.textColor = AppColor.eAnd_Grey_70
        self.durationValue.font = AppFont.appRegular(size: .body3)
        self.durationValue.textColor = AppColor.eAnd_Black_80
        
        self.liveRateTitle.text = "Live rate"
        self.feesTitle.text = "Fees"
        self.durationTitle.text = "Duration"
        
        self.liveRateValue.text = "INR 22.51"
        self.feesValue.text = "AED 3.00"
        self.durationValue.text = "2 hours"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
// MARK: - Cell model
final class IMTTransferMethodDetailCellModel: StandardCellModel {
    let data: String
    
    init(actions: StandardCellModel.ActionsType = nil, data: String) {
        self.data = data
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return IMTTransferMethodDetailTableViewCell.identifier()
    }
}
