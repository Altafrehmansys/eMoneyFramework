//
//  CountriesTableViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//

import UIKit

class CountriesTableViewCell: StandardCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var countryIcon: UIImageView!
    @IBOutlet private weak var countryName: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? CountryCellModel {
            countryName.text = model.name
            countryIcon.image = UIImage(named: model.image)
        }
    }
    func setUpUI(){
        setFonts()
    }
    
    private func setFonts() {
        countryName.font = AppFont.appRegular(size: .body3)
    }
}
