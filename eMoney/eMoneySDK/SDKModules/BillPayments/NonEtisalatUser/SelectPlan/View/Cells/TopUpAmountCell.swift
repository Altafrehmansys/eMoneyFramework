//
//  TopUpAmountCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 26/05/2023.
//

import UIKit

class TopUpAmountCell: StandardCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var collectionView:UICollectionView!
    var dataSource: [StandardCellModel] = []
    let columnLayout =  FlowLayout(
            itemSize: CGSize(width: 55, height: 32),
            minimumInteritemSpacing: 8,
            minimumLineSpacing: 8,
            sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            )
    override func configureCell() {
        if let model = cellModel as? TopUpAmountCellModel {
            lblTitle.text = model.heading
            lblTitle.textColor = model.headingColor
            lblTitle.font = model.headingFont
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView?.collectionViewLayout = columnLayout
            self.collectionView?.contentInsetAdjustmentBehavior = .always
            self.collectionView.register(UINib(nibName: String(describing: TopUpAmountSelectionCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: TopUpAmountSelectionCell.self))
//            self.collectionView.register(TopUpAmountSelectionCell.self, forCellWithReuseIdentifier: String(describing: TopUpAmountSelectionCell.self))
            self.setupDataSource()
        }
    }
    func setupDataSource() {
        self.dataSource = []
        if let model = cellModel as? TopUpAmountCellModel {
            model.topUps.forEach {
                dataSource.append(TopUpAmountSelectionCellModel(amount: "\($0)"))
            }
        }
        self.collectionView.reloadData()
    }
}
extension TopUpAmountCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.dataSource[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reusableIdentifier() , for: indexPath) as? StandardCollectionViewCell else { return UICollectionViewCell()}
        cell.cellModel = model
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = cellModel as? TopUpAmountCellModel {
            model.actions?.cellSelected(indexPath.item, model)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 32)
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        let cellWidth = 55
//        let cellCount = self.dataSource.count
//        let cellSpacing = 8
//
//        let totalCellWidth = cellWidth * cellCount
//        let totalSpacingWidth = cellSpacing * (cellCount - 1)
//
//        let leftInset = (collectionView.bounds.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let cellWidth = 55
        let cellCount = self.dataSource.count
        let cellSpacing = 8
        let totalWidth = cellWidth * cellCount
        let totalSpacingWidth = cellSpacing * (cellCount - 1)
        let leftInset = (collectionView.bounds.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
final class TopUpAmountCellModel:StandardCellModel {
    let heading:String
    let headingColor:UIColor
    let headingFont:UIFont
    
    var topUps:[Int]
    let collectionViewHeight:CGFloat
//    let collectionViewCell:StandardCollectionViewCell
    let collectionViewCellSize:CGSize
    
    init(cellAction:StandardCellActions? = nil,
         heading: String = "Or select an amount you want to top-up (AED) :".localized,
         headingColor: UIColor = AppColor.eAnd_Grey_100,
         headingFont: UIFont = AppFont.appRegular(size: .body3),
         topUps:[Int],
         collectionViewHeight: CGFloat = 144,
//         collectionViewCell: StandardCollectionViewCell,
         collectionViewCellSize: CGSize = CGSize(width: 55, height: 32)) {
        self.heading = heading
        self.headingColor = headingColor
        self.headingFont = headingFont
        self.topUps = topUps
        self.collectionViewHeight = collectionViewHeight
//        self.collectionViewCell = collectionViewCell
        self.collectionViewCellSize = collectionViewCellSize
        super.init(actions: cellAction)
    }
    override func reusableIdentifier() -> String {
        return TopUpAmountCell.identifier()
    }
}
