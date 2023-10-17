//
//  WalletBankCardTableViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 10/07/2023.
//

import UIKit

class WalletBankCardTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    private var cards: [WalletBankCard] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTableView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setTableView() {
        tableView.register(UINib(nibName: "\(WalletBankCardRowTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(WalletBankCardRowTableViewCell.self)")
        tableView.register(UINib(nibName: "\(WalletBankSectionHeaderTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(WalletBankSectionHeaderTableViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
    }
    func config(cards: [WalletBankCard]) {
        self.cards = cards
        tableView.reloadData()
    }
    
    func disableBorder() {
        tableView.borderWidth = 0
    }
    
}

extension WalletBankCardTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WalletBankSectionHeaderTableViewCell.self)") as? WalletBankSectionHeaderTableViewCell
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WalletBankCardRowTableViewCell.self)") as? WalletBankCardRowTableViewCell
            return cell ?? UITableViewCell()
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count + 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
