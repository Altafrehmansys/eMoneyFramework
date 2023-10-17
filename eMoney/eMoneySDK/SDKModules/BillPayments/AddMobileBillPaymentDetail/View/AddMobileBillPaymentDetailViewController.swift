//
//  AddMobileBillPaymentDetailViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 23/05/2023.
//  
//

import Foundation
import UIKit

class AddMobileBillPaymentDetailViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnPay: BaseButton!
    @IBOutlet weak var tblView: ContentSizedTableView!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    // MARK: Properties

    var presenter: AddMobileBillPaymentDetailPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnPayPressed(_ sender: Any) {
        self.presenter.navigateToSuccessScreen()
    }
}

extension AddMobileBillPaymentDetailViewController: AddMobileBillPaymentDetailViewProtocol {
    
    func setupUI() {
        setUpNavbar()
        setupTableView()
        titleLabel.text = "Aish"
        titleLabel.font = AppFont.appRegular(size: .body4)
        titleLabel.textColor = AppColor.eAnd_Black_80
        
        subTitle.text = "+971 50478 4352"
        subTitle.font = AppFont.appRegular(size: .body5)
        subTitle.textColor = AppColor.eAnd_Grey_70
        
        
        amountLabel.text = "AED 200.00"
        amountLabel.font = AppFont.appSemiBold(size: .body1)
        amountLabel.textColor = AppColor.eAnd_Black_80
        
        amountLabel.text = "Total bill due AED 200.00, minimum due AED 120.00"
        amountLabel.font = AppFont.appRegular(size: .body4)
        amountLabel.textColor = AppColor.eAnd_Grey_100
        
        btnPay.setTitle("Pay AED 210.00", for: .normal)
        
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
        self.navigationItem.setTitle(title: "Etisalat - Postpaid bill",subtitle: "Wallet balance AED 440.90",isBoldTitle: true)
        self.createNavBackBtn()
    
     
    }
}

// MARK: - UITableViewDataSource
extension AddMobileBillPaymentDetailViewController: UITableViewDataSource {
    
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
extension AddMobileBillPaymentDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
