//
//  SavedBillsDetailsViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 21/06/2023.
//  
//

import Foundation
import UIKit

class SavedBillsDetailsViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    // MARK: Properties

    var presenter: SavedBillsDetailsPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension SavedBillsDetailsViewController: SavedBillsDetailsViewProtocol {
    
    func setupUI() {
        view.backgroundColor = .white
        setUpNavbar()
        setupTableView()
    }
    private func setUpNavbar(){
        self.navigationItem.setTitle(title:self.presenter.navTitle,subtitle:Strings.BillPayment.accountDetails,isBoldTitle: true)
        self.createNavBackBtn()
    }

    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tblView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tblView.reloadData()
    }
    
    private func setupTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDataSource
extension SavedBillsDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.dataSource[indexPath.row]
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
extension SavedBillsDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
