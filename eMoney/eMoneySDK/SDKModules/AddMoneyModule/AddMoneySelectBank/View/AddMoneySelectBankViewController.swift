//
//  AddMoneySelectBankViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 25/04/2023.
//  
//

import Foundation
import UIKit

class AddMoneySelectBankViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: AddMoneySelectBankPresenterProtocol!

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

extension AddMoneySelectBankViewController: AddMoneySelectBankViewProtocol {
    func setupUI() {
        setupTableView()
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationItem.setTitle(title: Strings.AddMoney.addMoneyTitle, subtitle: Strings.AddMoney.selectBank)
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
    
    func updateBanksList() {
        let indexPath = IndexPath(row: presenter.dataSource.count - 1, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}


// MARK: - UITableViewDataSource
extension AddMoneySelectBankViewController: UITableViewDataSource {
    
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
extension AddMoneySelectBankViewController: UITableViewDelegate {
    
}

