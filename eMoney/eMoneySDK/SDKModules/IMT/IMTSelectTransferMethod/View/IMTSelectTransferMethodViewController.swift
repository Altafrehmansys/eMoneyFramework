//
//  IMTSelectTransferMethodViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//  
//

import Foundation
import UIKit

class IMTSelectTransferMethodViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    var presenter: IMTSelectTransferMethodPresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        presenter?.loadData()
    }
    private func setupUI() {
        self.titleLabel.text = "Select a delivery method".localized
        self.titleLabel.font = AppFont.appRegular(size: .body2)
        self.titleLabel.textColor = AppColor.eAnd_Black_80
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    @IBAction func crossBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


// MARK: - UITableViewDataSource
extension IMTSelectTransferMethodViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter?.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model?.reusableIdentifier() ?? "") as? StandardCell else {
            return UITableViewCell()
        }
        if model !== cell.cellModel {
            cell.cellModel = model
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension IMTSelectTransferMethodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = presenter?.dataSource[indexPath.row] {
            model.actions?.cellSelected(indexPath.row, model)
        }
        
    }
}

extension IMTSelectTransferMethodViewController: IMTSelectTransferMethodViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}
