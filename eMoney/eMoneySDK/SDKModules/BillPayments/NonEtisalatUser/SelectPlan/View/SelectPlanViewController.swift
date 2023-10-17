//
//  SelectPlanViewController.swift
//  e&money
//
//  Created by Usama Zahid Khan on 25/05/2023.
//  
//

import Foundation
import UIKit

class SelectPlanViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext:BaseButton!
    // MARK: Properties

    var presenter: SelectPlanPresenterProtocol?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    @IBAction func didTapNext(_ sender:Any) {
        self.presenter?.navigateToBillPaymentCheckout()
    }
}

extension SelectPlanViewController:UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.dataSource.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter?.dataSource[indexPath.row]
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
extension SelectPlanViewController: SelectPlanViewProtocol {
    func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.btnNext.setImage(UIImage(named:"arrow-right-with-background"), for: .normal)
        self.setupNavigatioBar()
    }
    private func setupNavigatioBar() {
        self.createNavBackBtn()
        self.navigationItem.setTitle(title: "\(self.presenter?.input?.selectedItem?.title ?? "") \(Strings.BillPayment.postpaidBill)",subtitle: "\(Strings.BillPayment.walletBalance) \(/GlobalData.shared.availableBalance?.balance?.addCurrency())",isBoldTitle: true)
    }
    func reloadTableView() {
        let identifiers = presenter?.dataSource.map { $0.reusableIdentifier() }
        identifiers?.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
}
