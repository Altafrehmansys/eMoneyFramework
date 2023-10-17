//
//  BottomSheetCollectionViewViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 24/05/2023.
//  
//

import Foundation
import UIKit

class BottomSheetCollectionViewViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backGroundView: UIView!
    // MARK: Properties

    var presenter: BottomSheetCollectionViewPresenterProtocol!

    var numberOfColums:CGFloat = 3.0
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.backGroundView.addGestureRecognizer(tapGesture)
    }
    @objc func dismissView() {
        presenter.dismissView()
    }
    
    @IBAction func btnClosePressed(_ sender: Any) {
        presenter.dismissView()
    }
}

extension BottomSheetCollectionViewViewController: BottomSheetCollectionViewViewProtocol {
    func setupUI() {
        self.setupCollectionView()
        addGesture()
        view.backgroundColor = .clear
        backGroundView.backgroundColor = AppColor.eAnd_bottom_sheet_background
        containerView.layer.cornerRadius = 20.0
        containerView.layer.masksToBounds = true
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setTitle()
    }
    
    func reloadCollectionView() {
        let identifiers = presenter.collectionViewDataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({collectionView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: $0)})
        collectionView.reloadData()
    
    }
    
    func setTitle(){
        self.titleLabel.text = self.presenter.title
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        let flowLayout = UICollectionViewCenterLayout()
        flowLayout.itemSize = CGSize(width:(self.collectionView.frame.width - 12) / numberOfColums , height:80)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowLayout
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension BottomSheetCollectionViewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return presenter.collectionViewDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = presenter.collectionViewDataSource[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reusableIdentifier(), for: indexPath) as? StandardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cellModel = model
        return cell
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = presenter.collectionViewDataSource[indexPath.item]
        model.actions?.cellSelected(indexPath.item, model)
        model.actions?.cellDeleted
    }
}
