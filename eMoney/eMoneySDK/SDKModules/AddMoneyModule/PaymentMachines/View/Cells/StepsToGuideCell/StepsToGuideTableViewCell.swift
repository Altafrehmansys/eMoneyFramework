//
//  StepsToGuideTableViewCell.swift
//  e&money
//
//  Created by Qamar Iqbal on 02/05/2023.
//

import UIKit

final class StepsToGuideTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var arrowRight: UIButton!
    @IBOutlet weak var arrowLeft: UIButton!
    
    @IBOutlet weak var stepperFirstImage: UIImageView!
    @IBOutlet weak var stepsSecondImage: UIImageView!
    @IBOutlet weak var stepsThirdImage: UIImageView!
    
    var currentIndex = 0

    // MARK: - Attributes
    var dataSource: [StandardCellModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    
    @IBAction func arrowRightAction(_ sender: Any) {
        currentIndex += 1
        updateStepImages()
    }
    
    @IBAction func arrowLeftAction(_ sender: Any) {
        currentIndex -= 1
        updateStepImages()
    }
    

    func updateStepImages() {
        scrollToIndex(index: currentIndex)
        
        let scaleSize = 2.5
        switch currentIndex {
            
        case 0:
            arrowLeft.isHidden = true
            arrowRight.isHidden = false
            
            stepperFirstImage.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
            stepsSecondImage.transform = CGAffineTransform.identity
            stepsThirdImage.transform = CGAffineTransform.identity
            
            stepperFirstImage.image = UIImage(named: "step1")
            stepsSecondImage.image = UIImage(named: "stepEmpty")
            stepsThirdImage.image = UIImage(named: "stepEmpty")
            
        case 1:
            arrowLeft.isHidden = false
            arrowRight.isHidden = false
            
            stepperFirstImage.transform = CGAffineTransform.identity
            stepsSecondImage.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
            stepsThirdImage.transform = CGAffineTransform.identity
            
            stepperFirstImage.image = UIImage(named: "stepEmpty")
            stepsSecondImage.image = UIImage(named: "step2")
            stepsThirdImage.image = UIImage(named: "stepEmpty")
            
        case 2:
            arrowLeft.isHidden = false
            arrowRight.isHidden = true
            
            stepperFirstImage.transform = CGAffineTransform.identity
            stepsSecondImage.transform = CGAffineTransform.identity
            stepsThirdImage.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
            
            stepperFirstImage.image = UIImage(named: "stepEmpty")
            stepsSecondImage.image = UIImage(named: "stepEmpty")
            stepsThirdImage.image = UIImage(named: "step3")
            
        default:
            break
        }
    }
    
    func scrollToIndex(index:Int) {
        let rect = self.collectionView.layoutAttributesForItem(at:IndexPath(row: index, section: 0))?.frame
        self.collectionView.scrollRectToVisible(rect!, animated: true)
        self.collectionView.reloadData()
    }

    override func configureCell() {
        if let model = cellModel as? StepsToGuideTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleTextColor
            
            arrowLeft.isHidden = true
            
            dataSource = model.dataSource
            
            updateStepImages()
            
            reloadCollectionView()
        }
    }
}

// MARK: - Configure Collection View
extension StepsToGuideTableViewCell {
    
    private func reloadCollectionView() {
        dataSource.forEach({collectionView.register(UINib(nibName: $0.reusableIdentifier(), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: $0.reusableIdentifier())})
        
        if let model = cellModel as? StepsToGuideTableViewCellModel {
            collectionView.isPagingEnabled = true
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(size.height))

        // Create a layout item with the defined size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Create a group with horizontal layout, containing the layout item and spacing
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
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
extension StepsToGuideTableViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate the current page based on the visible cells
        let pageWidth = collectionView.bounds.width
        let currentPage = Int((collectionView.contentOffset.x + pageWidth / 2) / pageWidth)
        
        currentIndex = currentPage
        self.updateStepImages()
    }
}

// MARK: - Cell model Class
final class StepsToGuideTableViewCellModel: StandardCellModel {
    let title: String
    let titleFont: UIFont
    let titleTextColor: UIColor
    let dataSource: [StandardCellModel]
    let itemSize: CGSize
    let interItemSpacing: CGFloat

    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appSemiBold(size: .body1),
         titleTextColor: UIColor = AppColor.eAnd_Black_80,
         dataSource: [StandardCellModel],
         itemSize: CGSize,
         interItemSpacing: CGFloat) {
        
        self.title = title
        self.titleFont = titleFont
        self.titleTextColor = titleTextColor
        self.dataSource = dataSource
        self.itemSize = itemSize
        self.interItemSpacing = interItemSpacing
        
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return StepsToGuideTableViewCell.identifier()
    }
}


// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension StepsToGuideTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
