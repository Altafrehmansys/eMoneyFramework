//
//  SearchCategoriesTableViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 09/06/2023.
//

import UIKit
import Kingfisher

class SearchCategoriesTableViewCell: StandardCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconContainerView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUI() {
        selectionStyle = .none
        setFonts()
    }
    
    private func setFonts() {
        titleLabel.font = AppFont.appRegular(size: .body3)
        iconContainerView.backgroundColor = AppColor.eAnd_Main_USP
    }
    
    override func configureCell() {
        super.configureCell()
        if let model = cellModel as? SearchCategoryCellModel {
            titleLabel.text = model.item?.title
            let url = URL(string: /model.item?.imageUrl)
            self.iconImageView.kf.setImage(with: url)
        }
    }
    
}
