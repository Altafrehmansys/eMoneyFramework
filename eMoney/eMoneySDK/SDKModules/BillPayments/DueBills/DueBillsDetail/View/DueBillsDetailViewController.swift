//
//  DueBillsDetailViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/06/2023.
//  
//

import Foundation
import UIKit

class DueBillsDetailViewController: BaseViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnPay: BaseButton!
    
    // MARK: Properties

    var presenter: DueBillsDetailPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    @IBAction func didTapPAy(_ sender: UIButton) {
        self.presenter.navigateToBillPaymentSuccess()
    }
}

extension DueBillsDetailViewController: DueBillsDetailViewProtocol {
    
    func setupUI() {
        view.backgroundColor = .white
        setUpNavbar()
        setupTableView()
        btnPay.setTitle("Pay bill", for: .normal)
    }

    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "Due bills (3)",subtitle: "Wallet balance AED 1000.90",isBoldTitle: true)
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
    func getTableViewFrameHeight() -> CGFloat{
        return tblView.frame.height
    }
    
}

// MARK: - UITableViewDataSource
extension DueBillsDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.reusableIdentifier()) as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        print(cell.frame.height,indexPath.row) 
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension DueBillsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
