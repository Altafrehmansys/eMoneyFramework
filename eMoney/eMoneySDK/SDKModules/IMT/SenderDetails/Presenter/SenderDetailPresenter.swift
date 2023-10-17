//
//  SenderDetailPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

class SenderDetailPresenter {

    // MARK: Properties

    weak var view: SenderDetailViewProtocol?
    var router: SenderDetailRouterProtocol?
    var interactor: SenderDetailInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    
    func viewDidLoad() {
        view?.setupUI()
        setupCellActions()
        makeDataSource()
    }
}

extension SenderDetailPresenter: SenderDetailPresenterProtocol {
    
    
}

// MARK: - Prepare Datasource
extension SenderDetailPresenter {
    func makeDataSource() {
       
        let labelCellModel = SenderDetailTableViewCellModel(title: "home_address".localized, text: "", textFieldEntryType: .text, textFieldType: "text", image: "")
       
        let labelCellModel1 = SenderDetailTableViewCellModel(actions : cellAction, title: "residing_emirate".localized, text: "", textFieldEntryType: .text, textFieldType: "dropdown", image: "arrow-down",dropDownDataSource: ["a","c","c","q"])
        let labelCellModel2 = SenderDetailTableViewCellModel(actions : cellAction,title: "occupation".localized, text: "", textFieldEntryType: .text, textFieldType: "dropdown", image: "arrow-down",dropDownDataSource: ["a","a","c","a"])
        let labelCellModel3 = SenderDetailTableViewCellModel(title: "source_of_funds".localized, text: "", textFieldEntryType: .text, textFieldType: "text", image: "info-circle-bank")
        
        dataSource.append(labelCellModel)
        dataSource.append(labelCellModel1)
        dataSource.append(labelCellModel2)
        dataSource.append(labelCellModel3)

        view?.reloadData()
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
            if let cellModel = model as? SenderDetailTableViewCellModel {
                
                    print("cell tapped")
                }
            }
        }
    
    
   
}

extension SenderDetailPresenter: SenderDetailInteractorOutputProtocol {
    
}
