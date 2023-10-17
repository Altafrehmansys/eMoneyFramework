//
//  SelectCountryViewViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation
import UIKit

class SelectCountryViewController: BaseViewController {

    // MARK: Outlets
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var allCountriesLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
        // MARK: Properties

    var presenter: SelectCountryViewPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setTableView()
        setFonts()
        setSearchTextField()
    }
    
    private func setSearchTextField() {
        searchTextField.addTarget(self, action: #selector(self.textFieldTextDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    private func setFonts() {
        titleLabel.font = AppFont.appRegular(size: .body2)
        allCountriesLabel.font = AppFont.appSemiBold(size: .body2)
        titleLabel.text = Strings.BillPayment.select_country
        allCountriesLabel.text = Strings.BillPayment.all_countries
    }
    
    private func setTableView() {
        tableView.register(UINib(nibName: "\(CountriesTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(CountriesTableViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func textFieldTextDidChange(_ textField: UITextField) {
        presenter?.didStartSearch(text: textField.text ?? "")
    }
}

// MARK: - PresenterOutput Extension

extension SelectCountryViewController: SelectCountryViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
// MARK: - TABLEVIEW Extension
extension SelectCountryViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        presenter?.didSelectCountry(index: indexPath.row)
    }
}
