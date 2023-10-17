//
//  AllSavedBillsViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 24/05/2023.
//  
//

import Foundation
import UIKit

class AllSavedBillsViewController: BaseViewController {

    // MARK: Properties

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: AllSavedBillsPresenterProtocol!
    
    var collectionFlowLayout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 50, height: 50)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        return flowLayout
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension AllSavedBillsViewController: AllSavedBillsViewProtocol {
    
    
    func setupUI() {
        self.setupTableView()
        self.setupCollectionView()
        view.backgroundColor = .white
        setUpNavbar()
    }
    func reloadCollectionView() {
        let identifiers = presenter.collectionViewDataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({collectionView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: $0)})
        collectionView.reloadData()
        setSelectedCellColor(index: 0)
    }
    
    func reloadTableView() {
        let identifiers = presenter.tableViewDataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tblView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tblView.reloadData()
    }
    
    func setSelectedCellColor(index:Int) {
        collectionView.selectItem(at:IndexPath(row: index, section: 0), animated: true, scrollPosition:[])
    }
    
    private func setupTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
    }
    private func setUpNavbar(){
        self.navigationItem.setTitle(title:Strings.BillPayment.savedAccounts)
        self.createNavBackBtn()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        collectionView.collectionViewLayout = collectionFlowLayout
    }
    
}

// MARK: - UITableViewDataSource
extension AllSavedBillsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = presenter.tableViewDataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.reusableIdentifier()) as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension AllSavedBillsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.tableViewDataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}



// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension AllSavedBillsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
