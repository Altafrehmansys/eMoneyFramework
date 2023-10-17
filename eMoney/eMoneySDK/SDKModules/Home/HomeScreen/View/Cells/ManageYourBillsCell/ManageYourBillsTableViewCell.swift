//
//  ManageYourBillsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 15/04/2023.
//

import UIKit

final class ManageYourBillsTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Attributes
    var dataSource = [StandardCellModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = AppFont.appSemiBold(size: .body2)
        titleLabel.textColor = AppColor.eAnd_Black_80
        containerView.setProperties(cornerRadius: 20, borderColor: AppColor.eAnd_Grey_10, borderWidth: 1)
        containerView.addShadow(shadowOpacity: 1,
                                shadowRadius: 4,
                                shadowOffset: CGSize(width: 0, height: 1),
                                shadowColor: AppColor.eAnd_Shadow)
        setupTableView()
    }
    
    override func configureCell() {
        if let model = cellModel as? ManageYourBillsTableViewCellModel {
            self.titleLabel.text = model.title
            self.dataSource = model.dataSource
            registerCellAndReloadTableView()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.cornerRadius = 20
    }
    
    private func registerCellAndReloadTableView() {
        dataSource.forEach({tableView.register(UINib(nibName: $0.reusableIdentifier(), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0.reusableIdentifier())})
        tableView.reloadData()
        layoutIfNeeded()
    }
}

// MARK: - Cell Model Class
final class ManageYourBillsTableViewCellModel: StandardCellModel {
    let title: String
    let dataSource: [StandardCellModel]
    
    init(actions: StandardCellModel.ActionsType = nil, title: String, dataSource: [StandardCellModel]) {
        self.title = title
        self.dataSource = dataSource
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return ManageYourBillsTableViewCell.identifier()
    }
}

// MARK: - UITableViewDataSource
extension ManageYourBillsTableViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
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
extension ManageYourBillsTableViewCell: UITableViewDelegate {
    
}
