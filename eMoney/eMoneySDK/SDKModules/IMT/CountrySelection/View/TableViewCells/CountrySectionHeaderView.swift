//
//  CountrySectionHeaderView.swift
//  etisalatWallet
//
//  Created by Shujaat Ali on 18/08/2022.
//  Copyright © 2022 Etisalat UAE. All rights reserved.
//

import Foundation
import UIKit


class CountrySectionHeaderView: UIView {
    
    @IBOutlet weak var titleLbl : UILabel!

    override func awakeFromNib() {
    }
    
    func setupWithItem(title : String){

        titleLbl.text = title
        titleLbl.font = AppFont.appSemiBold(size: .body2)
        titleLbl.textColor = AppColor.eAnd_Black_80

    }
      
}
