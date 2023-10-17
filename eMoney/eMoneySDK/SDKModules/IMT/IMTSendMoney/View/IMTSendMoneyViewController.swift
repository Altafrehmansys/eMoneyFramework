//
//  IMTSendMoneyViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//  
//

import Foundation
import UIKit

class IMTSendMoneyViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var stepsBar: BaseStepper!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: BaseButton!
    
    // MARK: Properties

    var presenter: IMTSendMoneyPresenterProtocol?

    var tableData:[StandardCellModel] = []
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.loadData()
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(RegistrationMethodsViewController.self)  release from memory")
    }
    
    func setupUI() {
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        self.navigationItem.setTitle(title: "Send money abroad".localized, subtitle: "Wallet balance AED 7,500.00".localized, isBoldTitle: true)
        self.stepsBar.addRedLine(noOfSteps: 3, currentStep: 1)
        createNavBackBtn()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    // MARK: - Acions
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if GlobalData.shared.isUpgradeRequired {
            KYCBottomSheet.shared.present()
        }
    }
}

extension IMTSendMoneyViewController: IMTSendMoneyViewProtocol {
    
    func reloadData(data:[StandardCellModel]) {
        self.tableData = data
        let identifiers = self.tableData.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
    
}
//44 32
// MARK: - UITableViewDataSource
extension IMTSendMoneyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = tableData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.reusableIdentifier()) as? StandardCell else {
            return UITableViewCell()
        }
        if model !== cell.cellModel {
            model.index = indexPath.row
            cell.cellModel = model
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension IMTSendMoneyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = presenter.dataSource[indexPath.row]
//        model.actions?.cellSelected(indexPath.row, model)
    }
}
extension IMTSendMoneyViewController: CountrySelectionViewControllerDelegate {
    func selectIMTCountryTapped(country: Countries) {
        presenter?.selectedCountry = country
    }

}
