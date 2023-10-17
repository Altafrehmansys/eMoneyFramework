//
//  ProviderTableViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//

import UIKit

class ProviderTableViewCell: StandardCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var providerIcon: UIImageView!
    @IBOutlet private weak var providerName: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? ProviderCellModel {
            providerName.text = model.name
            providerIcon.kf.setImage(with: URL(string: model.image) )
        }
    }
    func setUpUI(){
        setFonts()
    }
    
    private func setFonts() {
        providerName.font = AppFont.appRegular(size: .body3)
    }
}
