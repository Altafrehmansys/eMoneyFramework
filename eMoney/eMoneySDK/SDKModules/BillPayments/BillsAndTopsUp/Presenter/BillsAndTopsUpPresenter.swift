//
//  BillsAndTopsUpPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation

class BillsAndTopsUpPresenter {
    
    // MARK: Properties
    
    weak var view: BillsAndTopsUpViewProtocol?
    var router: BillsAndTopsUpRouterProtocol?
    var interactor: BillsAndTopsUpInteractorProtocol?
    var collectionViewDataSource: [ListItems] = []
    
    var tableViewDataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var isSavedBills: Bool = false
    
}

extension BillsAndTopsUpPresenter: BillsAndTopsUpPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        Loader.shared.showFullScreen()
        interactor?.getBillsList()
        self.setupCellActions()
        self.makeDataSource()
    }
    
    func makeDataSource() {
        self.tableViewDataSource.removeAll()
        self.tableViewDataSource = self.setDataSource()
        view?.reloadTableView()
        
    }
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
    
    private func setupCellActions() {
        cellActions = StandardCellActions{ index, model in
            if let model = model as? GenericTitleAndButtonTableViewCellModel {
                self.moveToAllSavedBills()
            }
            if let model = model as? SingleButtonTableViewCellModel {
                self.moveToPayAllDueBill()
            }
            if let model = model as? SavedUtilityBillTableViewCellModel {
                self.moveToBillManagement()
            }
            if let model = model as? SavedBillCellModel {
                if let listItem = model.listItems{
                    self.loadBillsListItemBottomSheet(title:model.title,listItems:listItem)
                }
            }
            if let model = model as? SearchBillTableViewCellModel {
                self.navigateToSearch()
            }
        }
    }
    
    private func setDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        dataSource.append(GenericTitleAndButtonTableViewCellModel(actions: self.cellActions, title:Strings.BillPayment.savedAccounts , buttonTitle:Strings.BillPayment.viewAll))
        dataSource.append(spaceCell(with: 3.5))
        dataSource.append(SavedUtilityBillTableViewCellModel(actions: self.cellActions,title: "Home electricity", subTitle: "Etihad water & electricity..."))
        
        dataSource.append(dividerCell())
        dataSource.append(SavedUtilityBillTableViewCellModel(actions: self.cellActions,title: "Home electricity", subTitle: "Etihad water & electricity..."))
        dataSource.append(dividerCell())
        
        dataSource.append(SavedUtilityBillTableViewCellModel(actions: self.cellActions,title: "Home electricity", subTitle: "Etihad water & electricity..."))
        
        dataSource.append(spaceCell(with: 8))
        dataSource.append(SingleButtonTableViewCellModel(actions:self.cellActions,title: Strings.BillPayment.payAllDueBills, type:.GradientButton))
        dataSource.append(spaceCell(with: 12))
        
        let titleCell = GenericSingleLabelCellModel(content: Strings.BillPayment.payANewBiller, font: AppFont.appSemiBold(size: .body2))
        dataSource.append(titleCell)
        
        let searchCell = SearchBillTableViewCellModel(actions: self.cellActions,searchPlaceHolder:Strings.BillPayment.searchForBiller)
        dataSource.append(searchCell)
        let data = CollectionViewTableViewCellModel(actions: self.cellActions,dataSource: setSavedBillsBottomCategoriesDataSource(), itemSize: CGSize(width: 90, height: 200), interItemSpacing:12.0)
        dataSource.append(data)
        
        return dataSource
    }
    
    func setSavedBillsBottomCategoriesDataSource() -> [StandardCellModel] {
        
        var bottomCollectionViewDataSource = [StandardCellModel]()
        for bill in collectionViewDataSource {
            bottomCollectionViewDataSource.append(SavedBillCellModel(actions: self.cellActions,title:bill.title ?? "", imgName:bill.imageUrl ?? "",listItems: bill.listItems))
        }
        return bottomCollectionViewDataSource
    }
}

extension BillsAndTopsUpPresenter: BillsAndTopsUpInteractorOutputProtocol {
    func onAllBillsList(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.localizedDescription, actionBtnTitle:Strings.BillPayment.ok, delegate: nil)
    }
    
    func onAllBillsList(Response response: BillsAndTopsUpResponseModel?){
        
        Loader.shared.hideFullScreen()
        if let billTypes = response?.data {
            self.collectionViewDataSource = billTypes
            view?.reloadCollectionView()
            self.makeDataSource()
        }
    }

    func onSavedBillsList(Response response: BillsAndTopsUpResponseModel?) {
        Loader.shared.hideFullScreen()
        if let savedBills = response?.data {
           // self.tableViewDataSource = savedBills
            //view?.reloadTableView()
        }
    }
    
    func onSavedBillsList(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title:Strings.BillPayment.error, message: error.localizedDescription, actionBtnTitle:Strings.BillPayment.ok, delegate: nil)
    }
}

extension BillsAndTopsUpPresenter{
    
    // Navigation for all saved bills
    
    func moveToAllSavedBills() {
        self.router?.go(to: .allSavedBills(allBills: self.collectionViewDataSource))
    }
    
    func moveToPayAllDueBill() {
        self.router?.go(to: .dueBills)
    }
    
    func moveToBillManagement() {
        self.router?.go(to: .billManagement)
    }
    
    func loadBillsListItemBottomSheet(title:String,listItems:[ListItems]) {
        self.router?.go(to: .bottomSheetWithBillsListItems(title:title,dataSource: listItems))
    }
    func navigateToAddMobileBill() {
        //self.router?.go(to:.allSavedBills)
    }
    
    
    
// Navigation for all bill types
    
    func navigateToSearch() {
        self.router?.go(to:.search(allBills: self.collectionViewDataSource))
    }
    func navigateToMobileEtiSalat(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .mobilEtisalat(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToMobileDU(navTitle:String,selectedItem:ListItems) {
        self.router?.go(to: .mobilDU(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToDEWA(navTitle:String,selectedItem:ListItems) {
        self.router?.go(to: .homeDEVA(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToISTA(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .homeISTA(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToLootahGas(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .homeLootahGas(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateDubaiTraficFine(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .vehicleDubaiTraficPoliceAndFine(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateMawaqif(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .vehicleMawaqif(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToInternationalMobile(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .internationalMobile(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToMParking(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .vehicleMParking(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToISTARegistration(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .otherServiceISTARegistration(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToSalik(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .vehicleSalik(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToSEWA(navTitle:String,selectedItem:ListItems){
        //KYCBottomSheet.shared.present(userState: .unRegister)
        InSufficientBalanceSheet.shared.presentInSufficientBottomSheet(amountTobeDetected: 6.25)
      //self.router?.go(to: .homeSEWA(navTitle: navTitle, selectedItem: selectedItem))

    }
    func navigateToAADC(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .homeAADC(navTitle: navTitle, selectedItem: selectedItem))

    }
    func navigateToADDC(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .homeADDC(navTitle: navTitle, selectedItem: selectedItem))

    }
    func navigateToEtihadWaterAndElectricity(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .homeEtihadWaterAndElectricity(navTitle: navTitle, selectedItem: selectedItem))

    }
    func navigateToAjmanSewerage(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .homeAjmanSewerage(navTitle: navTitle, selectedItem: selectedItem))

    }
    func navigateToSERGAS(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .homeSERGAS(navTitle: navTitle, selectedItem: selectedItem))

    }
    func navigateToAjmanPay(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .governmentAjmanPay(navTitle: navTitle, selectedItem: selectedItem))

    }
    func navigateToNationalBonds(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .otherServiceNationalBonds(navTitle: navTitle, selectedItem: selectedItem))

    }
    
    func navigateToHomeEtisalat(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .homeEtisalat(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToHomeDU(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .homeDU(navTitle: navTitle, selectedItem: selectedItem))
    }
    
}
