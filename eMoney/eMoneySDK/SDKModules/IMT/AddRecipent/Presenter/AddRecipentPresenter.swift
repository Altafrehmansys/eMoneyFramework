//
//  AddRecipentPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class AddRecipentPresenter {

    // MARK: Properties

    weak var view: AddRecipentViewProtocol?
    var router: AddRecipentRouterProtocol?
    var interactor: AddRecipentInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    var selectedSegmentIndex = 0
    var selectedSegmentIndex1 = 0
    
    func viewDidLoad() {
        view?.setupUI()
        setupCellActions()
        makeDataSource()
    }
}

extension AddRecipentPresenter: AddRecipentPresenterProtocol {
    
    func navigateToSummary() {
        router?.go(to: .summary)
        
    }
}

// MARK: - Prepare Datasource
extension AddRecipentPresenter {
    func makeDataSource() {
        let imageModel = IMTSegmentCellModel(actions: cellAction, iconWithTitles: [IconWithLabel(icon: UIImage(named: "profile-someoneElse")!, title: "Someone else"), IconWithLabel(icon: UIImage(named: "profile-myself")!, title: "Myself")], type: .iconWithLabel, selectedIndex: self.selectedSegmentIndex1)
        let labelCellModel = AddRecipentTableViewCellModel(title: "recipient_full_name".localized, text: "", textFieldType: .text, imageName: "info-circle-bank")
        let labelCellModel1 = AddRecipentTableViewCellModel(title: "mob_number".localized, text: "", textFieldType: .text, imageName: "contact-icon")
        let labelCellModel2 = AddRecipentTableViewCellModel(title: "iban".localized, text: "", textFieldType: .text, imageName: "info-circle-bank")
        let labelCellModel3 = AddRecipentTableViewCellModel(title: "nickname_optional".localized, text: "", textFieldType: .text, imageName: "")
        
        dataSource.append(imageModel)
        dataSource.append(labelCellModel)
        dataSource.append(labelCellModel1)
        dataSource.append(labelCellModel2)
        dataSource.append(labelCellModel3)
        view?.reloadData()
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
            if let cellModel = model as? AddRecipentTableViewCellModel {
                print("cell tapped")
            }
        }
    }
    
}

extension AddRecipentPresenter: AddRecipentInteractorOutputProtocol {
    
}
