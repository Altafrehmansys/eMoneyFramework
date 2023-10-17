//
//  OnboardingImageCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 10/04/2023.
//

import UIKit
import Kingfisher

class OnboardingImageCell: UICollectionViewCell {

    @IBOutlet weak var viewStepper: BaseStepper!
    @IBOutlet weak var imageViewBg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func setCellData(onboardingObj : WalkthroughNotifications){
        
        let url = URL(string: onboardingObj.imageURL ?? "")
//        self.imageViewBg.kf.setImage(with: url)
        
        let activityInd = UIActivityIndicatorView()
        activityInd.center = CGPoint(x: self.frame.size.width  / 2,
                                     y: self.frame.size.height / 2)
        activityInd.color = UIColor.white
        activityInd.style = .large
        self.addSubview(activityInd)
        activityInd.startAnimating()
        self.imageViewBg.kf.setImage(with: url) { res in
            activityInd.stopAnimating()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }

}
