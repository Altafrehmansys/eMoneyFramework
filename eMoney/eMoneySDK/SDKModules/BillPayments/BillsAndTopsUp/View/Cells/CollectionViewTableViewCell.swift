//
//  CollectionViewTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 19/05/2023.
//

import UIKit


class CollectionViewTableViewCell: StandardCell {

    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cellParentView: UIView!
    
    // MARK: - Attributes
    var dataSource: [StandardCellModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    override func configureCell() {
        if let model = cellModel as? CollectionViewTableViewCellModel {
            dataSource = model.dataSource
            reloadCollectionView()
        }
    }
}

class DynamicHeightCollectionView: UICollectionView {
    
override var contentSize: CGSize {
         didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
        }
}


// MARK: - Configure Collection View
extension CollectionViewTableViewCell {
    
    private func reloadCollectionView() {
        dataSource.forEach({collectionView.register(UINib(nibName: $0.reusableIdentifier(), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: $0.reusableIdentifier())})
        
        if let model = cellModel as? CollectionViewTableViewCellModel {
            collectionView.isPagingEnabled = model.isPagingEnabled
           // collectionView.collectionViewLayout = collectionViewFlowlayout()
        }
        collectionView.reloadData()
        collectionViewHeightConstraint.constant = calculateCollectionViewHeight(collectionView: collectionView)
    }
    
    func calculateCollectionViewHeight(collectionView: UICollectionView) -> CGFloat {
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }
        
        let itemSize = flowLayout.itemSize
        let interitemSpacing = flowLayout.minimumInteritemSpacing
        let sectionInsets = flowLayout.sectionInset
        let numberOfColumns = 3 // Adjust according to your layout
        let numberOfRows = (numberOfItems + numberOfColumns - 1) / numberOfColumns
        let totalItemHeight = (itemSize.height * CGFloat(numberOfRows))
        let totalSpacingHeight = (interitemSpacing * CGFloat(numberOfRows - 1))
        let totalInsetHeight = (sectionInsets.top + sectionInsets.bottom)
        let totalHeight = totalItemHeight + totalSpacingHeight + totalInsetHeight
        return totalHeight + 0
    }
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 12, bottom: 0, right:12)
    }
    
    private func collectionViewFlowlayout() -> UICollectionViewFlowLayout{
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:(UIScreen.main.bounds.width - 80) / 3 , height:90)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }
    
   
}

// MARK: - Scroll View Delegates
extension CollectionViewTableViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate the current page based on the visible cells
        let visibleCells = collectionView.visibleCells
        let sortedCells = visibleCells.sorted { cell1, cell2 in
            return cell1.frame.origin.x < cell2.frame.origin.x
        }
        let currentPage = collectionView.indexPath(for: sortedCells[0])!.item
        
        // Update the current page of the page control
        if let model = cellModel as? CollectionViewTableViewCellModel {
            model.actions?.cellSelected(currentPage, model)
        }
    }
}

// MARK: - Cell model Class
final class CollectionViewTableViewCellModel: StandardCellModel {
 
    let dataSource: [StandardCellModel]
    let itemSize: CGSize
    let interItemSpacing: CGFloat
    let isPagingEnabled: Bool
    
    init(actions: StandardCellModel.ActionsType = nil,
         dataSource: [StandardCellModel],
         itemSize: CGSize,
         interItemSpacing: CGFloat,
         isPagingEnabled: Bool = false) {
        self.dataSource = dataSource
        self.itemSize = itemSize
        self.interItemSpacing = interItemSpacing
        self.isPagingEnabled = isPagingEnabled
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return CollectionViewTableViewCell.identifier()
    }
}


// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reusableIdentifier(), for: indexPath) as? StandardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cellModel = model
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellModel?.actions?.cellSelected(indexPath.item, dataSource[indexPath.item])
    }
}
