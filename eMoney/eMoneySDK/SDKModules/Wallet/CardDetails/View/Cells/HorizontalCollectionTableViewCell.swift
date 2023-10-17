//
//  HorizontalCollectionTableViewCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 11/07/2023.
//

import UIKit

class HorizontalCollectionTableViewCell: StandardCell {
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var collectionViewHContraint:NSLayoutConstraint!
    var dataSource: [StandardCellModel] = []
    override func configureCell() {
        if let model = cellModel as? HorizontalCollectionTableViewCellModel {
            dataSource = model.datasource
            reloadCollectionView()
        }
        if let model = self.cellModel as? HorizontalCollectionTableViewCellModel {
            
            self.collectionViewHContraint.constant = /(self.cellModel as? HorizontalCollectionTableViewCellModel)?.collectionHeight
            let identifier = model.datasource.first?.reusableIdentifier()
            self.collectionView.register(UINib(nibName: String(describing: identifier), bundle: .main),
                                             forCellWithReuseIdentifier: String(describing: identifier))
            
            
        }
    }
    private func reloadCollectionView() {
        dataSource.forEach({collectionView.register(UINib(nibName: $0.reusableIdentifier(), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: $0.reusableIdentifier())})
        
        if let model = cellModel as? HorizontalCollectionTableViewCellModel {
            self.collectionViewHContraint.constant = model.collectionHeight
            self.setupLayout(model)
        }
        self.collectionView.reloadData()
        
    }
    func setupLayout(_ model:HorizontalCollectionTableViewCellModel) {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: , height: screenWidth/3)
        layout.minimumInteritemSpacing = model.spacing
        layout.minimumLineSpacing = model.spacing
        self.collectionView.collectionViewLayout = layout
    }
}
final class HorizontalCollectionTableViewCellModel: StandardCellModel {
    let datasource:[StandardCellModel]
    let cellSize:CGSize
    let spacing:CGFloat
    let collectionHeight:CGFloat
    let numberOfCellPerPage:Int
    init(actions: StandardCellActions? = nil,
         datasource:[StandardCellModel],
         cellSize:CGSize = .zero,
         spacing:CGFloat = 0,
         collectionHeight:CGFloat,
         numberOfCellPerPage:Int = 4
    ) {
        self.datasource = datasource
        self.cellSize = cellSize
        self.spacing = spacing
        self.collectionHeight = collectionHeight
        self.numberOfCellPerPage = numberOfCellPerPage
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return String(describing: HorizontalCollectionTableViewCell.self)
    }
}
extension HorizontalCollectionTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return /(self.cellModel as? HorizontalCollectionTableViewCellModel)?.datasource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = (self.cellModel as? HorizontalCollectionTableViewCellModel)?.datasource[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: /model?.reusableIdentifier(), for: indexPath) as? StandardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cellModel = model
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerPage = /(self.cellModel as? HorizontalCollectionTableViewCellModel)?.numberOfCellPerPage
        let height = (self.cellModel as? HorizontalCollectionTableViewCellModel)?.collectionHeight
        let width = self.collectionView.bounds.width / CGFloat(cellsPerPage)
        return CGSize(width:width, height:/height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = self.cellModel as? HorizontalCollectionTableViewCellModel {
            model.actions?.cellSelected(indexPath.item,model)
        }
    }
}
