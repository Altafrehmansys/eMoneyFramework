//
//  DueBillsViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import Foundation
import UIKit

class DueBillsViewController: BaseViewController {

    @IBOutlet weak var billCountLabel: UILabel!
    @IBOutlet weak var btnPay: BaseButton!
    @IBOutlet weak var tblView: UITableView!
    // MARK: Properties

    var presenter: DueBillsPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnPayPressed(_ sender: Any) {
        self.presenter.moveToDueBillsDetailsScreen()
    }
    
}

extension DueBillsViewController: DueBillsViewProtocol {
    
    func setupUI() {
        self.setupTableView()
        view.backgroundColor = .white
        btnPay.setTitle(Strings.BillPayment.pay, for: .normal)
        btnPay.type = .GradientButton
        btnPay.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        billCountLabel.isHidden = true
        billCountLabel.font = AppFont.appRegular(size: .body4)
        billCountLabel.textColor = AppColor.eAnd_Maroon
        setUpNavbar()
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
    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "Due bills")
        self.createNavBackBtn()
    }
    func setBillsCount(_ count: Int) {
        if count > 0 {
            self.billCountLabel.isHidden = false
            if count == 1 {
                self.billCountLabel.text = "\(count) \(Strings.BillPayment.bill_selected)"
            }else{
                self.billCountLabel.text = "\(count) \(Strings.BillPayment.bills_selected)"
            }
        }else{
            self.billCountLabel.isHidden = true
        }
        
    }
}


// MARK: - UITableViewDataSource
extension DueBillsViewController: UITableViewDataSource {
    

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
extension DueBillsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
