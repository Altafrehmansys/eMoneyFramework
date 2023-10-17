//
//  EmployeeBeneficiaryDetailViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//  
//

import Foundation
import UIKit

class EmployeeBeneficiaryDetailViewController: BaseViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noRecordFoundParentView: UIView!
    
    @IBOutlet weak var btnDownLoad: BaseButton!
    @IBOutlet weak var btnSendMoney: BaseButton!
    @IBOutlet weak var noRecordImgView: UIImageView!
    @IBOutlet weak var noRecordDescriptionLabel: UILabel!
    @IBOutlet weak var noRecordLabel: UILabel!
    // MARK: Properties

    var presenter: EmployeeBeneficiaryDetailPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnSendMoneyPressed(_ sender: Any) {
    }
    @IBAction func btnDownLoadPressed(_ sender: Any) {
    }
    
}

extension EmployeeBeneficiaryDetailViewController: EmployeeBeneficiaryDetailViewProtocol {
    
    func setupUI() {
        btnSendMoney.setTitle("Send Money", for: .normal)
        btnSendMoney.titleLabel?.font = AppFont.appSemiBold(size:.body2)
        btnDownLoad.setTitle("Download statement", for: .normal)
        btnDownLoad.type = .PlainButton
        btnDownLoad.titleLabel?.font = AppFont.appSemiBold(size:.body2)
        setUpNavbar()
        setupTableView()
    }

    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "Zaid Darbar",subtitle: "+971 53942 9403")
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
extension EmployeeBeneficiaryDetailViewController: UITableViewDataSource {
    
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
extension EmployeeBeneficiaryDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
