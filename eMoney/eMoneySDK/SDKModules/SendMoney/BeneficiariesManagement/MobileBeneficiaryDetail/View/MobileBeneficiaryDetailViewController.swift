//
//  MobileBeneficiaryDetailViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//  
//

import Foundation
import UIKit

class MobileBeneficiaryDetailViewController: BaseViewController {

   
    @IBOutlet weak var noRecordFoundParentView: UIView!
    @IBOutlet weak var btnRequestMoney: BaseButton!
    @IBOutlet weak var btnSendMoney: BaseButton!
    @IBOutlet weak var tblView: UITableView!
    // MARK: Properties

    var presenter: MobileBeneficiaryDetailPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnSendMoneyPressed(_ sender: Any) {
    }
    @IBAction func btnRequestMoneyPressed(_ sender: Any) {
    }
    
}

extension MobileBeneficiaryDetailViewController: MobileBeneficiaryDetailViewProtocol {
    
    func setupUI() {
        btnSendMoney.setTitle("Send Money", for: .normal)
        btnSendMoney.titleLabel?.font = AppFont.appSemiBold(size:.body2)
        btnRequestMoney.setTitle("Request", for: .normal)
        btnRequestMoney.type = .PlainButton
        btnRequestMoney.titleLabel?.font = AppFont.appSemiBold(size:.body2)
        
        setUpNavbar()
        setupTableView()
    }

    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "Khan Mohammed",subtitle: "+971 66340 97342")
        self.createNavBackBtn()
        
    }
    
    func reloadData() {
        
        if self.presenter.dataSource.count == 0{
            tblView.isHidden = true
            noRecordFoundParentView.isHidden = false
        }else {
            
            let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
            identifiers.forEach({tblView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
            tblView.reloadData()
            tblView.isHidden = false
            noRecordFoundParentView.isHidden = true
        }
    }
    
    private func setupTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDataSource
extension MobileBeneficiaryDetailViewController: UITableViewDataSource {
    
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
extension MobileBeneficiaryDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
