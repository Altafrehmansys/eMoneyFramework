//
//  ManageCardViewController.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/07/2023.
//  
//

import Foundation
import UIKit

class ManageCardViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var tableView:UITableView!
    var presenter: ManageCardPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
   
}

extension ManageCardViewController: ManageCardViewProtocol {
    func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.setupNavigatioBar()
    }
    private func setupNavigatioBar() {
        self.createNavBackBtn()
        self.navigationItem.setTitle(title: Strings.Wallet.manage_card)
    }
    func reloadTableView() {
        let identifiers = presenter?.dataSource.map { $0.reusableIdentifier() }
        identifiers?.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
}

extension ManageCardViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.dataSource.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter?.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: /model?.reusableIdentifier()) as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
