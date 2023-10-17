//
//  SavedAccountsAndCardsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//

import UIKit

class SavedAccountsAndCardsTableViewCell: StandardCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Attributes
    var dataSource = [StandardCellModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = AppFont.appRegular(size: .body3)
        titleLabel.textColor = AppColor.eAnd_Black_80
        setupTableView()
    }
    //AppColor.eAnd_Grey_20
    override func configureCell() {
        if let model = cellModel as? SavedAccountsAndCardsTableViewCellModel {
            titleLabel.text = model.title
            containerView.setProperties(cornerRadius: model.cornerRadius, borderColor: model.borderColor, borderWidth: model.borderWidth)
            dataSource = model.dataSource
            registerCellAndReloadTableView()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCellAndReloadTableView() {
        dataSource.forEach({tableView.register(UINib(nibName: $0.reusableIdentifier(), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0.reusableIdentifier())})
        tableView.reloadData()
        layoutIfNeeded()
    }
}

// MARK: - Cell Model Class
final class SavedAccountsAndCardsTableViewCellModel: StandardCellModel {
    enum ParentType {
        case banks
        case cards
    }
    
    
    let title: String
    var dataSource: [StandardCellModel]
    let type: ParentType
    let cornerRadius: CGFloat
    let borderColor: UIColor
    let borderWidth: CGFloat
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         dataSource: [StandardCellModel],
         type: ParentType,
         cornerRadius: CGFloat = 0,
         borderColor: UIColor = .clear,
         borderWidth: CGFloat = 0) {
        self.title = title
        self.dataSource = dataSource
        self.type = type
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SavedAccountsAndCardsTableViewCell.identifier()
    }
}


// MARK: - UITableViewDataSource
extension SavedAccountsAndCardsTableViewCell: UITableViewDataSource {
    
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
extension SavedAccountsAndCardsTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
