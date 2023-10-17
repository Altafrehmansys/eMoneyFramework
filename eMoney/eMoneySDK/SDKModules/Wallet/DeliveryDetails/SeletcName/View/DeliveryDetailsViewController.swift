//
//  DeliveryDetailsViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation
import UIKit

class DeliveryDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nameOptionsTableView: UITableView!
    @IBOutlet private weak var confirmBtn: BaseButton!
    
    // MARK: Properties

    var presenter: DeliveryDetailsPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
        
    }
    
    private func setUI() {
        setNavigationController()
        setFonts()
        setTableView()
        setLoclaization()
        setConfrimBtn()
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: Strings.Wallet.delivery_details_title, subtitle: "")
        createNavBackBtn()
    }
    
    private func setFonts() {
        titleLabel.font = AppFont.appRegular(size: .body2)
        subTitleLabel.font = AppFont.appRegular(size: .body3)
        nameTextField.font = AppFont.appSemiBold(size: .h7)
    }
    
    private func setTableView() {
        nameOptionsTableView.dataSource = self
        nameOptionsTableView.delegate = self
    }
    
    private func setLoclaization() {
        titleLabel.text = Strings.Wallet.select_name_physical_card
        subTitleLabel.text = Strings.Wallet.select_name_physical_card_message
        confirmBtn.titleLabel?.text = Strings.Wallet.confirm_name
    }
    
    private func setConfrimBtn() {
        confirmBtn.type = .GradientButton
    }
    
    @IBAction func confrimNameBtnTapped(_ sender: UIButton) {
        presenter?.confirmButtonDidTapped()
    }
}

extension DeliveryDetailsViewController: DeliveryDetailsViewProtocol {
    func reloadData() {
        let identifiers = presenter?.dataSource.map { $0.reusableIdentifier() }
        identifiers?.forEach({nameOptionsTableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        nameOptionsTableView.reloadData()
    }
}

extension DeliveryDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter?.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model?.reusableIdentifier() ?? "") as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectName(index: indexPath.row)
    }
}
