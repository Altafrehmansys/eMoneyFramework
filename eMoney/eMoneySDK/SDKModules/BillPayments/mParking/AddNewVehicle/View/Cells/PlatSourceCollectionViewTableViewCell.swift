//
//  PlatSourceCollectionViewTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 02/06/2023.
//

import UIKit

class PlatSourceCollectionViewTableViewCell: StandardCell {
    
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Attributes
    var dataSource: [StandardCellModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        collectionHeightConstraint.constant = 50
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func reloadCollectionView() {
        dataSource.forEach({collectionView.register(UINib(nibName: $0.reusableIdentifier(), bundle:  Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: $0.reusableIdentifier())})
        
        if let model = cellModel as? PlatSourceCollectionViewTableViewCellModel {
            collectionView.isPagingEnabled = model.isPagingEnabled
            collectionView.collectionViewLayout = collectionViewFlowlayout()
        }
        
        collectionView.reloadData()
        setSelectedCellColor(index: 0)
    }
    
    func setSelectedCellColor(index:Int) {
        collectionView.selectItem(at:IndexPath(row: index, section: 0), animated: true, scrollPosition:[])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
    }

    private func collectionViewFlowlayout() -> UICollectionViewFlowLayout{
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 300, height: 60)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        return flowLayout
    }
    
    override func configureCell() {
        if let model = cellModel as? PlatSourceCollectionViewTableViewCellModel {
            dataSource = model.dataSource
            reloadCollectionView()
        }
    }
}


// MARK: - Scroll View Delegates
extension PlatSourceCollectionViewTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate the current page based on the visible cells
        let visibleCells = collectionView.visibleCells
        let sortedCells = visibleCells.sorted { cell1, cell2 in
            return cell1.frame.origin.x < cell2.frame.origin.x
        }
        let currentPage = collectionView.indexPath(for: sortedCells[0])!.item
        
        // Update the current page of the page control
        if let model = cellModel as? PlatSourceCollectionViewTableViewCell {
           // model.actions?.cellSelected(currentPage, model)
        }
    }
}

// MARK: - Cell model Class
 class PlatSourceCollectionViewTableViewCellModel: StandardCellModel {
 
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
        return PlatSourceCollectionViewTableViewCell.identifier()
    }
}


// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension PlatSourceCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
