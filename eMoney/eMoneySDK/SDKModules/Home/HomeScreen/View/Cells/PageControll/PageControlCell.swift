//
//  PageControlCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 17/04/2023.
//

import UIKit

class PageControlCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pageControl: AdvancedPageControlView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell() {
        if let model = cellModel as? PageControlCellModel {
            setupPageControl()
            pageControl.setPage(model.currentPage)
        }
    }
    
    private func setupPageControl() {
        if let model = cellModel as? PageControlCellModel {
            pageControl.drawer = ExtendedDotDrawer(numberOfPages: model.totalPages,
                                                   height: 6.0,
                                                   width: 6.0,
                                                   space: 4.0,
                                                   raduis: 4.0,
                                                   currentItem: 0.0,
                                                   indicatorColor: AppColor.eAnd_Red,
                                                   dotsColor: AppColor.eAnd_Grey_20,
                                                   isBordered: false,
                                                   borderColor: .clear,
                                                   borderWidth: 0.0,
                                                   indicatorBorderColor: .clear,
                                                   indicatorBorderWidth: 0.0)
            if LocaleManager.isRTLLanguage() {
                pageControl.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
        }
    }
}


// MARK: - Cell Model
final class PageControlCellModel: StandardCellModel {
    var currentPage: Int
    let totalPages: Int

    init(actions: StandardCellModel.ActionsType = nil,
         currentPage: Int,
         totalPages: Int)
    {
        self.currentPage = currentPage
        self.totalPages = totalPages
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return PageControlCell.identifier()
    }
}
