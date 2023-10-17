//
//  CustomDropDownCellWithImageTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//

import UIKit
import DropDown

class CustomDropDownCellWithImageTableViewCell: DropDownCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    var item:ListItems? = nil {
        didSet {
            if let i = self.item {
                DispatchQueue.main.async {
                    self.optionLabel.text = /i.title
                    if let url = URL(string: /i.imageUrl) {
                        self.imgView.load(url: url)
                    }
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
