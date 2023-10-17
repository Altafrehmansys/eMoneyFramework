//
//  AlternateFlowForLeanPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 22/06/2023.
//  
//

import Foundation

class AlternateFlowForLeanPresenter {

    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    // MARK: Properties

    weak var view: AlternateFlowForLeanViewProtocol?
    var router: AlternateFlowForLeanRouterProtocol?
    var interactor: AlternateFlowForLeanInteractorProtocol?
    
    private var optionsList: [AddMoneyOptionsListResponseModel.AddMoneyOptionsListDataModel] = []
    
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType: String {
            case bankAcountSingle = "BANK_ACCOUNT_SINGLE"
            case bankAcountLinked = "BANK_ACCOUNT_LINKED"
            case creditDebitCard = "DEBIT_CREDIT_CARD"
            case applePay = "APPLE_PAY"
            case general = "GENERAL"
        }
        
        var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
        }
    }
}

extension AlternateFlowForLeanPresenter: AlternateFlowForLeanPresenterProtocol {
    func loadData() {
        view?.setupUI()
        setupCellActions()
        
        Loader.shared.showFullScreen()
        interactor?.getOptionsList()
    }
}

// MARK: - Prepare Data Source
extension AlternateFlowForLeanPresenter {
    func makeDataSource() {
        dataSource.removeAll()
        
        let titleCellModel = GenericSingleLabelCellModel(content: Strings.AddMoney.otherAlternativeForAddingMoney, font: AppFont.appRegular(size: .body2), color: AppColor.eAnd_Black_80, alignment: .center, topSpace: 0, bottomSpace: 0)
        dataSource.append(titleCellModel)
        
        let subTitleCellModel = GenericSingleLabelCellModel(content: Strings.AddMoney.tryUsingDifferentSourceOrSameResource, font: AppFont.appRegular(size: .body3), color: AppColor.eAnd_Grey_100, alignment: .center, topSpace: 7, bottomSpace: 32)
        dataSource.append(subTitleCellModel)
        
        self.addPaymentOptions()
        
        view?.reloadData()
    }
    
    // MARK: - Add Payment options
    private func addPaymentOptions() {
        self.optionsList.forEach { [weak self] (model) in
            guard let `self` = self else { return }
            
            let cellType = (MethodType.CellType(rawValue: model.identifier ?? "")) ?? .general
            
            // If user cannot pay with apple pay
//                if methodType.type == .applePay {
//                    if !PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: payment.supportedNetworks) {
//                        continue
//                    }
//                }
            
            let methodCell2 = MethodOptionTableViewCellModel(actions: self.cellActions, image: model.iconImageUrl ?? "", name: model.title ?? "", subtitle: model.description, methodType: MethodType(type: cellType))
            self.dataSource.append(methodCell2)
            self.dataSource.append(self.dividerCell())
        }
        
        self.dataSource.removeLast()
        self.dataSource.append(SpaceTableViewCellModel(height: 20))
    }
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
}


// MARK: - Handle Actions
extension AlternateFlowForLeanPresenter {
    
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            if let model = model as? MethodOptionTableViewCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .bankAcountSingle:
                    self.router?.go(to: .selectBank)
                case .bankAcountLinked:
                    self.router?.go(to: .selectLeanBank)
                case .creditDebitCard:
                    self.initializeAddDebitCard()
                case .applePay:
                    let title = Strings.AddMoney.via + " " + model.name
                    let input = AddMoneyEnterAmountRouter.input(title: title, subtitle: model.subtitle ?? "", logo: model.image, currentFlow: .applePay)
                    self.router?.go(to: .enterAmountVC(input: input))
                default:
                    break
                }
            }
        })
    }
}

// MARK: - Navigation
extension AlternateFlowForLeanPresenter {
    func dismissView() {
        router?.go(to: .back)
    }
}


// MARK: - API Calls
extension AlternateFlowForLeanPresenter {
    private func initializeAddDebitCard() {
        Loader.shared.showFullScreen()
        interactor?.initializeAddCard()
    }
}


// MARK: - Output Protocol
extension AlternateFlowForLeanPresenter: AlternateFlowForLeanInteractorOutputProtocol {
    func onOptionsList(Response response: AddMoneyOptionsListResponseModel?) {
        Loader.shared.hideFullScreen()
        guard let data = response?.data else {
            debugPrint("No data found")
            return
        }
        
        self.optionsList = data
        self.makeDataSource()
    }
    
    func onOptionsList(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription, actionBtnTitle: Strings.Generic.ok, delegate: self)
    }
    
    func onAddCard(Response response: AddDebitCardResponseModel) {
        Loader.shared.hideFullScreen()
        if let data = response.data, let url = data.url, let _ = data.transactionId {
            if let url = URL(string: url) {
                var request = URLRequest(url: url)
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "GET"
                
                let input = AddMoneyWebViewRouter.Input(request: request, currentFlow: .initializeDebitCard)
                router?.go(to: .loadWebViewWith(input: input))
            }
        }
    }
    
    func onAddCard(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription, actionBtnTitle: Strings.Generic.ok, delegate: self)
    }
}

// MARK: - Error Sheet Delegate Methods
extension AlternateFlowForLeanPresenter: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
//        self.router?.go(to: .back(withAnimation: false))
    }
    
    func closeBtnTapped() {
//        self.router?.go(to: .back(withAnimation: false))
    }
}
