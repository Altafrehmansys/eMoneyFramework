//
//  StepsToGuideCollectionViewCell.swift
//  e&money
//
//  Created by Qamar Iqbal on 02/05/2023.
//

import UIKit

final class StepsToGuideCollectionViewCell: StandardCollectionViewCell {
    
    // MARK: - IBOutelets
    
    @IBOutlet weak var stepsImageView: UIImageView!
    @IBOutlet weak var stepsSubTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        stepsImageView.cornerRadius = stepsImageView.frame.size.height / 2
    }
    
    override func configureCell() {
        if let model = cellModel as? StepsToGuideCollectionViewCellModel {
            stepsImageView.image = UIImage(named: model.stepsImage)
            stepsSubTitle.text = model.stepsSubTitle
        }
    }
}

final class StepsToGuideCollectionViewCellModel: StandardCellModel {
    let stepsImage: String
    let stepsSubTitle: String
    
    init(actions: StandardCellModel.ActionsType = nil, stepsImage: String, stepsSubTitle: String) {
        self.stepsImage = stepsImage
        self.stepsSubTitle = stepsSubTitle
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return StepsToGuideCollectionViewCell.identifier()
    }
}
