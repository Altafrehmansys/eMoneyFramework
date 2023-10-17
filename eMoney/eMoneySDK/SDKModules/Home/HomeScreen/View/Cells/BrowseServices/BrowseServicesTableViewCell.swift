//
//  BrowseServicesTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit

final class BrowseServicesTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    
    // MARK: - Attributes
    var dataSource: [StandardCellModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    override func configureCell() {
        if let model = cellModel as? BrowseServicesTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleTextColor
            
            dataSource = model.dataSource
            reloadCollectionView()
        }
    }
}

// MARK: - Configure Collection View
extension BrowseServicesTableViewCell {
    
    private func reloadCollectionView() {
        dataSource.forEach({collectionView.register(UINib(nibName: $0.reusableIdentifier(), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: $0.reusableIdentifier())})
        
        if let model = cellModel as? BrowseServicesTableViewCellModel {
            collectionView.isPagingEnabled = model.isPagingEnabled
            collectionView.collectionViewLayout = self.collectionViewCompositionalLayout(with: model.itemSize, and: model.interItemSpacing)
            collectionViewHeight.constant = model.itemSize.height
        }
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
    }
    
    private func collectionViewCompositionalLayout(with size: CGSize, and spacing: CGFloat) -> UICollectionViewCompositionalLayout {
        
        // Define the size of each item in the grid
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size.width), heightDimension: .absolute(size.height))

        // Create a layout item with the defined size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Create a group with horizontal layout, containing the layout item and spacing
        let groupWidth = (Double(dataSource.count) * size.width) + Double(CGFloat(dataSource.count - 1) * spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)

        // Create a section with the defined group and spacing
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        // Create a compositional layout with the section
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config

        return layout
    }
}

// MARK: - Scroll View Delegates
extension BrowseServicesTableViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate the current page based on the visible cells
        let visibleCells = collectionView.visibleCells
        let sortedCells = visibleCells.sorted { cell1, cell2 in
            return cell1.frame.origin.x < cell2.frame.origin.x
        }
        let currentPage = collectionView.indexPath(for: sortedCells[0])!.item
        
        // Update the current page of the page control
        if let model = cellModel as? BrowseServicesTableViewCellModel {
            model.actions?.cellSelected(currentPage, model)
        }
    }
}

// MARK: - Cell model Class
final class BrowseServicesTableViewCellModel: StandardCellModel {
    let title: String
    let titleFont: UIFont
    let titleTextColor: UIColor
    let dataSource: [StandardCellModel]
    let itemSize: CGSize
    let interItemSpacing: CGFloat
    let isPagingEnabled: Bool
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appSemiBold(size: .body2),
         titleTextColor: UIColor = AppColor.eAnd_Black_80,
         dataSource: [StandardCellModel],
         itemSize: CGSize,
         interItemSpacing: CGFloat,
         isPagingEnabled: Bool = false) {
        self.title = title
        self.titleFont = titleFont
        self.titleTextColor = titleTextColor
        self.dataSource = dataSource
        self.itemSize = itemSize
        self.interItemSpacing = interItemSpacing
        self.isPagingEnabled = isPagingEnabled
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return BrowseServicesTableViewCell.identifier()
    }
}


// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension BrowseServicesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
