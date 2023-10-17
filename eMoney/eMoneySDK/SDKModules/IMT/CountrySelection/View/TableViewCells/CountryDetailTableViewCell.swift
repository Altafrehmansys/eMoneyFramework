//
//  CountryDetailTableViewCell.swift
//  etisalatWallet
//
//  Created by Shujaat Ali on 18/08/2022.
//  Copyright © 2022 Etisalat UAE. All rights reserved.
//

import UIKit

protocol CountryDetailTableViewCellDelegate:AnyObject {
    func selectCountryTapped(isSelected:Bool, index:Int)
}

class CountryDetailTableViewCell: UITableViewCell {
    @IBOutlet var lblCountryName: UILabel!
    @IBOutlet var countryImage: UIImageView!
    @IBOutlet var lblCountryCode: UILabel!
    @IBOutlet var contactImgBGView: UIView!
    
    var index:Int?
    
    weak var delegate:CountryDetailTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCountryCode.font = AppFont.appRegular(size: .body3)
        lblCountryCode.textColor = AppColor.eAnd_Black_60
        lblCountryName.font = AppFont.appRegular(size: .body3)
        lblCountryName.textColor = AppColor.eAnd_Black_80
//        contactImgBGView.backgroundColor = AppColor.primary.withAlphaComponent(0.5)
    }

    func updateCell(country: Countries,index:Int) {
        self.index = index
        lblCountryName.text = country.name ?? ""
        lblCountryCode.text = country.code ?? ""
        self.countryImage.image = UIImage(named: CountriesMapping(rawValue: country.code ?? "")?.countryFlag ?? "default-flag")
    }
    
}
