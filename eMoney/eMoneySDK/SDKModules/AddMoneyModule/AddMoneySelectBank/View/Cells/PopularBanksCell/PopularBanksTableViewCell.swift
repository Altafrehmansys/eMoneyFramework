//
//  PopularBanksTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit

final class PopularBanksTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    
    // MARK: - Attributes
    var dataSource: [StandardCellModel] = []
    let spacing: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    override func configureCell() {
        if let model = cellModel as? PopularBanksTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleTextColor
            
            dataSource = model.dataSource
            reloadCollectionView()
        }
    }
}

// MARK: - Configure Collection View
extension PopularBanksTableViewCell {
    
    private func reloadCollectionView() {
        dataSource.forEach({collectionView.register(UINib(nibName: $0.reusableIdentifier(), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: $0.reusableIdentifier())})
        collectionView.collectionViewLayout = self.collectionViewCompositionalLayout()
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func collectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        // Define the size of each item in the grid
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(70), heightDimension: .absolute(90))

        // Create a layout item with the defined size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Create a group with horizontal layout, containing the layout item and spacing
        let groupWidth = (Double(dataSource.count) * 70) + Double(CGFloat(dataSource.count - 1) * spacing)
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

// MARK: - Cell model Class
final class PopularBanksTableViewCellModel: StandardCellModel {
    let title: String
    let titleFont: UIFont
    let titleTextColor: UIColor
    let dataSource: [StandardCellModel]
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appSemiBold(size: .body2),
         titleTextColor: UIColor = AppColor.eAnd_Black_80,
         dataSource: [StandardCellModel]) {
        self.title = title
        self.titleFont = titleFont
        self.titleTextColor = titleTextColor
        self.dataSource = dataSource
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return PopularBanksTableViewCell.identifier()
    }
}


// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension PopularBanksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
