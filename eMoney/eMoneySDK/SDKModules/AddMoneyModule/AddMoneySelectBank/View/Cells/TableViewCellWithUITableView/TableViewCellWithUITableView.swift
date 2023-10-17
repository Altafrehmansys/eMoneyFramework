//
//  TableViewCellWithUITableView.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 26/04/2023.
//

import UIKit

class TableViewCellWithUITableView: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Attributes
    var dataSource = [StandardCellModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func configureCell() {
        if let model = cellModel as? TableViewCellModelWithUITableView {
            
            self.tableView.layer.borderWidth = model.borderWidth
            self.tableView.layer.cornerRadius = model.cornerRadius
            self.tableView.layer.borderColor = model.borderColor.cgColor
            
            self.leadingConstraint.constant = model.leftSpace
            self.trailingConstraint.constant = model.rightSpace
            self.topConstraint.constant = model.topSpace
            self.bottomConstraint.constant = model.bottomSpace
            
            self.dataSource = model.dataSource
            self.dataSource.forEach({tableView.register(UINib(nibName: $0.reusableIdentifier(), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0.reusableIdentifier())})
            self.tableView.reloadData()
            self.layoutIfNeeded()
        }
    }
}

// MARK: - Class Methods
extension TableViewCellWithUITableView {
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension TableViewCellWithUITableView: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}

// MARK: - Cell Model
final class TableViewCellModelWithUITableView: StandardCellModel {
    var dataSource: [StandardCellModel]
    let borderWidth: CGFloat
    let borderColor: UIColor
    let cornerRadius: CGFloat
    
    let leftSpace: CGFloat
    let rightSpace: CGFloat
    let topSpace: CGFloat
    let bottomSpace: CGFloat
    
    init(actions: StandardCellModel.ActionsType = nil,
         dataSource: [StandardCellModel],
         borderWidth: CGFloat = 0,
         borderColor: UIColor = .clear,
         cornerRadius: CGFloat = 0,
         leftSpace: CGFloat = 0,
         rightSpace: CGFloat = 0,
         topSpace: CGFloat = 0,
         bottomSpace: CGFloat = 0) {
        self.dataSource = dataSource
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
        self.leftSpace = leftSpace
        self.rightSpace = rightSpace
        self.topSpace = topSpace
        self.bottomSpace = bottomSpace
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return TableViewCellWithUITableView.identifier()
    }
}
