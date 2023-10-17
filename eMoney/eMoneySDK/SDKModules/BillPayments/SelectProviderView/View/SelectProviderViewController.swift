//
//  SelectProviderViewViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation
import UIKit

class SelectProviderViewController: BaseViewController {

    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var allCountriesLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
        // MARK: Properties

    var presenter: SelectProviderViewPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setTableView()
        setFonts()
    }
    
    private func setFonts() {
        titleLabel.font = AppFont.appRegular(size: .body2)
        allCountriesLabel.font = AppFont.appSemiBold(size: .body2)
        allCountriesLabel.text = Strings.BillPayment.all_providers
        titleLabel.text = Strings.BillPayment.select_a_network_provider
    }
    
    private func setTableView() {
        tableView.register(UINib(nibName: "\(ProviderTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(ProviderTableViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - PresenterOutput Extension

extension SelectProviderViewController: SelectProviderViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
// MARK: - TABLEVIEW Extension
extension SelectProviderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter?.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model?.reusableIdentifier() ?? "") as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectProvider(index: indexPath.row)
    }
}
