//
//  CaptureIdentityImageTableViewCell.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 15/04/2023.
//

import UIKit

class CaptureIdentityImageTableViewCell: StandardCell {
    // MARK: - Outlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgBottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelTitle.font = AppFont.appRegular(size: .body2)
        labelTitle.textColor = AppColor.eAnd_Black_80
        labelTitle.numberOfLines = 2
        labelSubTitle.font = AppFont.appRegular(size: .body4)
        labelSubTitle.textColor = AppColor.eAnd_Black_80
        labelSubTitle.numberOfLines = 2
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? CaptureIdentityImageCellModel {
            if model.isSelfiScan{
                imgTopConstraint.constant = 20
                imgBottomConstraint.constant = -26
                labelTitle.text = "verify_identity_desc".localized
                labelSubTitle.text = "tip_video".localized
                imgView.image = UIImage(named: "SelfieScan")?.flipIfNeeded()
            }else{
                imgTopConstraint.constant = 55
                imgBottomConstraint.constant = 65
                labelTitle.text = "capture_identity_desc".localized
                labelSubTitle.text = "tip_photo".localized
                imgView.image = UIImage(named: "eidScan")?.flipIfNeeded()
            }
        }
    }
}

// MARK: - Cell model
final class CaptureIdentityImageCellModel: StandardCellModel {
    let isSelfiScan: Bool
    
    init(isSelfiScan: Bool) {
        self.isSelfiScan = isSelfiScan
        super.init()
    }

    override func reusableIdentifier() -> String {
        return CaptureIdentityImageTableViewCell.identifier()
    }
}
