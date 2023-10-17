//
//  FineDetailViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit

class FineDetailViewController: BaseViewController {

    @IBOutlet weak var tblView: ContentSizedTableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnPayFine: BaseButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelAmount: UILabel!

    // MARK: Properties

    var presenter: FineDetailPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnPayFinePressed(_ sender: Any) {
        self.presenter.navigateToSuccessfulScreen()
    }
}

extension FineDetailViewController: FineDetailViewProtocol {
    
    func setupUI() {
        self.setupTableView()
        view.backgroundColor = .white
        labelAmount.font = AppFont.appRegular(size: .h5)
        labelAmount.textColor = AppColor.eAnd_Black_80
        btnPayFine.setTitle("\(Strings.BillPayment.continueToPayFine) AED 500.50", for: .normal)
        labelAmount.text = "AED 50.00"
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
        tblView.layer.cornerRadius = 12
        tblView.layer.borderColor = AppColor.eAnd_Grey_20.cgColor
        tblView.layer.borderWidth = 1
    }
    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "Dubai Police",subtitle: "\(Strings.BillPayment.walletBalance) AED 440.00",isBoldTitle: true)
        self.createNavBackBtn()
    }
}
// MARK: - UITableViewDataSource
extension FineDetailViewController: UITableViewDataSource {
    
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
extension FineDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
