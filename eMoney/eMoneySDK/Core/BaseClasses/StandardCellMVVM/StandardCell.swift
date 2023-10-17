//
//
//  StandardCell.swift
//  NY-TimesNews
//
//  Created by Uzair Mughal on 14/04/2023.
//
//

import UIKit

class StandardCell: UITableViewCell, CellModel {
    typealias CellModelType = StandardCellModel
    
    var cellModel: CellModelType? {
        didSet {
            self.configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    deinit {
        print("deinit - \(String(describing: self))")
    }
    
    class func instance(withModel cellModel: CellModelType) -> StandardCell {
        let nibName = "StandardCell"
        let cell = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed(nibName, owner: nil)!.first as! StandardCell
        cell.cellModel = cellModel
        
        return cell
    }
    
    final class func identifier() -> String {
        return String(describing: Self.self)
    }
    
    /// Called right after view model is assigned to cell
    func configureCell() {
        
    }
    
    func updateLayout(){
        if let tableView = self.superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

class StandardCollectionViewCell: UICollectionViewCell, CellModel {
    typealias CellModelType = StandardCellModel
    
    var cellModel: CellModelType? {
        didSet {
            self.configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
        print("deinit - \(String(describing: self))")
    }
    
    class func instance(withModel cellModel: CellModelType) -> StandardCell {
        let nibName = "StandardCell"
        let cell = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed(nibName, owner: nil)!.first as! StandardCell
        cell.cellModel = cellModel
        
        return cell
    }
    
    final class func identifier() -> String {
        return String(describing: Self.self)
    }
    
    /// Called right after view model is assigned to cell
    func configureCell() {
        
    }
}


class StandardCellModel: CellActions, Equatable {
    typealias ActionsType = StandardCellActions?
    
    let actions: ActionsType
    var index: Int = 0
    
    init(actions: ActionsType = nil) {
        self.actions = actions
    }
    
    func reusableIdentifier() -> String {
        assertionFailure("Don't register this cell , then you have to override this func")
        return "StandardCell"
    }
}

extension StandardCellModel {
    static func == (lhs: StandardCellModel, rhs: StandardCellModel) -> Bool {
        return lhs === rhs
    }
}

struct StandardCellActions {
    let cellSelected: (_ index: Int, _ model: StandardCellModel) -> ()
    var cellDeleted: ((_ index: Int, _ model: StandardCellModel) -> ())? = nil
}

