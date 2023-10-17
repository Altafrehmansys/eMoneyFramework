//
//  AddMoneyVerifyBankViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//  
//

import Foundation
import UIKit

class AddMoneyVerifyBankViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: BaseButton!
    
    // MARK: Properties
    var presenter: AddMoneyVerifyBankPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(AddMoneyVerifyBankViewController.self) release from memory")
    }
}

extension AddMoneyVerifyBankViewController: AddMoneyVerifyBankViewProtocol {
    func setupUI() {
        setupTableView()
        setupNavigation()
        
        
        continueButton.type = .GradientButton
        continueButton.cornerRadius = 24
        continueButton.setTitle(presenter.verifyButtonTitle, for: .normal)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
    }
    
    func updateUI() {
        continueButton.setTitle(presenter.verifyButtonTitle, for: .normal)
    }
    
    private func setupNavigation() {
        self.navigationItem.setTitle(title: Strings.AddMoney.addMoneyTitle, subtitle: Strings.AddMoney.verifyBankAccount)
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
}

// MARK: - Actions
extension AddMoneyVerifyBankViewController {
    @objc func continueButtonTapped(_ sender: BaseButton) {
        self.presenter.navigateToEnterAmountVC()
    }
}

// MARK: - UITableViewDataSource
extension AddMoneyVerifyBankViewController: UITableViewDataSource {
    
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
extension AddMoneyVerifyBankViewController: UITableViewDelegate {
    
}

