//
//  SendMoneyPaymentDetailsViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyPaymentDetailsViewController: BaseViewController {

    // MARK: Properties

    @IBOutlet weak var tblView: ContentSizedTableView!
    @IBOutlet weak var btnSendMoney: BaseButton!
    @IBOutlet weak var iBANNumberLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    var presenter: SendMoneyPaymentDetailsPresenterProtocol!

    @IBOutlet weak var labelDescription: UILabel!
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
   
    @IBAction func btnSendMoneyPressed(_ sender: Any) {
        self.presenter.navigateToNextScreen()
    }
}


extension SendMoneyPaymentDetailsViewController: SendMoneyPaymentDetailsViewProtocol {

    func setupUI() {
        self.setupTableView()
        view.backgroundColor = .white
        userNameLabel.font = AppFont.appRegular(size: .body3)
        userNameLabel.textColor = AppColor.eAnd_Black_80
        iBANNumberLabel.font = AppFont.appRegular(size: .body4)
        iBANNumberLabel.textColor = AppColor.eAnd_Grey_100
        labelCurrency.font = AppFont.appRegular(size: .h4)
        labelCurrency.textColor = AppColor.eAnd_Black_80
        labelAmount.font = AppFont.appRegular(size: .h5)
        labelAmount.textColor = AppColor.eAnd_Black_80
        btnSendMoney.setTitle("Send AED 220.50", for: .normal)
        
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
        self.navigationItem.setTitle(title: "Send money",subtitle: "Account balance AED 349.50")
        self.createNavBackBtn()
    }
}

// MARK: - UITableViewDataSource
extension SendMoneyPaymentDetailsViewController: UITableViewDataSource {
    
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
extension SendMoneyPaymentDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
