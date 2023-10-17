//
//  ManageSavedAccountsViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 10/05/2023.
//  
//

import Foundation
import UIKit

class ManageSavedAccountsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: ManageSavedAccountsPresenterProtocol!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(AddMoneySelectBankViewController.self) release from memory")
    }
}

extension ManageSavedAccountsViewController: ManageSavedAccountsViewProtocol {
    func setupUI() {
        setupTableView()
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationItem.setTitle(title: Strings.AddMoney.manageSavedMethods)
        self.createNavBackBtn()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 10, right: 0)
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
    
    func showRemovedMethodNotificationView(isCard: Bool) {
        
        let image = isCard ? "card_removed" : "bank_removed"
        let title = isCard ? Strings.AddMoney.cardIsRemoved : Strings.AddMoney.bankAccountIsRemoved
        
        Alert.showBannerView(image: image, title: title)
    }
}

// MARK: - IBActions
extension ManageSavedAccountsViewController {
    
}

// MARK: - UITableViewDataSource
extension ManageSavedAccountsViewController: UITableViewDataSource {
    
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
extension ManageSavedAccountsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}

