//
//  RecentParkingViewController.swift
//  e&money
//
//  Created by Usama Zahid Khan on 15/06/2023.
//  
//

import Foundation
import UIKit

class RecentParkingViewController: BaseViewController {
    @IBOutlet weak var tableView:UITableView!
    // MARK: Properties

    var presenter: RecentParkingPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension RecentParkingViewController: RecentParkingViewProtocol {
    func setupUI() {
        self.tableView.separatorStyle = .none
        self.setupNavigatioBar()
    }
    func reloadTableView() {
        let identifiers = presenter?.datasource.map { $0.reusableIdentifier() }
        identifiers?.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
    private func setupNavigatioBar() {
        self.createNavBackBtn()
        self.navigationItem.setTitle(title:Strings.BillPayment.mParking, subtitle: nil, isBoldTitle: false)
    }
}
extension RecentParkingViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.datasource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter?.datasource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model?.reusableIdentifier() ?? "") as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
