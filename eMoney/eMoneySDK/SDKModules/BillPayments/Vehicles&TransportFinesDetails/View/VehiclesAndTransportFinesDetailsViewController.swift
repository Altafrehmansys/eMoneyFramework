//
//  VehiclesAndTransportFinesDetailsViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit
import Kingfisher

class VehiclesAndTransportFinesDetailsViewController: BaseViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: Properties
    var presenter: VehiclesAndTransportFinesDetailsPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension VehiclesAndTransportFinesDetailsViewController: VehiclesAndTransportFinesDetailsViewProtocol {
    
    func setupUI() {
        self.setupTableView()
        view.backgroundColor = .white
        setUpNavbar()
        bindDataWithUI()
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
        self.navigationItem.setTitle(title:self.presenter.selectedItem?.title ?? "",subtitle:Strings.BillPayment.accountDetails)
        self.createNavBackBtn()
    }
    private func bindDataWithUI(){
        let url = URL(string: /self.presenter.input?.selectedItem?.imageUrl)
        self.imgView.kf.setImage(with: url)
        switch self.presenter.input?.fine?.selectedType {
        case .plateNo:
            self.titleLabel.text = self.presenter.input?.fine?.plateNumber.title
        case .tfcNo:
            self.titleLabel.text = self.presenter.input?.fine?.tfcNumber.title
        case .licenseNo:
            self.titleLabel.text = self.presenter.input?.fine?.licenseNumber.title
        case .fineNo:
            self.titleLabel.text = self.presenter.input?.fine?.fineNumber.title
        default:break
        }
    }
}

// MARK: - UITableViewDataSource
extension VehiclesAndTransportFinesDetailsViewController: UITableViewDataSource {
    
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
extension VehiclesAndTransportFinesDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
