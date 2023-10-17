//
//  WalletSavedAccountViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 10/07/2023.
//

import UIKit

class WalletSavedAccountViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: WalletSavedAccountPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setTableView()
    }
    
    private func setTableView() {
        tableView.register(UINib(nibName: "\(WalletBankCardTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(WalletBankCardTableViewCell.self)")
        tableView.register(UINib(nibName: "\(WalletBankSectionHeaderTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(WalletBankSectionHeaderTableViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension WalletSavedAccountViewController: WalletSavedAccountViewProtocol {
    
}

extension WalletSavedAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item1 = WalletBankCard(cardImageURL: "", cardName: "", cardNumber: "")
        let item2 = WalletBankCard(cardImageURL: "", cardName: "", cardNumber: "")
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WalletBankSectionHeaderTableViewCell.self)") as? WalletBankSectionHeaderTableViewCell
                return cell ?? UITableViewCell()
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WalletBankCardTableViewCell.self)") as? WalletBankCardTableViewCell
                cell?.config(cards: [item1, item2])
                return cell ?? UITableViewCell()
            }
        case 3:

                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WalletBankCardTableViewCell.self)") as? WalletBankCardTableViewCell
                cell?.config(cards: [item1, item2])
                cell?.disableBorder()
                return cell ?? UITableViewCell()
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WalletBankCardTableViewCell.self)") as? WalletBankCardTableViewCell
            cell?.config(cards: [item1, item2])
            return cell ?? UITableViewCell()
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 3 {
          return 2
        }
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 56
            } else {
                return 198
            }
        case 3:
            if indexPath.row == 0 {
                return 56
            } else {
                return 198
            }
        default:
            return 198
        }
    }
}
