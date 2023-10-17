//
//  SelectLanguageTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 11/04/2023.
//

import UIKit

class SelectLanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewTick: UIImageView!
    @IBOutlet weak var lblLanguage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblLanguage.font = AppFont.appRegular(size: .body3)
    }
    
    func setCellData(languageObj : LanguageData){
        self.lblLanguage.text = languageObj.languageName
        self.imageViewTick.isHidden = languageObj.isSelected ? false:true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
