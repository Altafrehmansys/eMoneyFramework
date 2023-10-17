//
//  BillPaymentSearchPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 08/06/2023.
//  
//

import Foundation

class BillPaymentSearchPresenter {

    // MARK: Properties

    weak var view: BillPaymentSearchViewProtocol?
    var router: BillPaymentSearchRouterProtocol?
    var interactor: BillPaymentSearchInteractorProtocol?
    var dataSource: [SearchCategoryCellModel] = []
    var tableViewDataSource: [StandardCellModel] = []
    var protomtionDatasource : [StandardCellModel] = []
    internal var searchText:String? = nil {
        didSet{
            self.search(/self.searchText)
//            loadTableViewDataSource()
      }
    }
    var allBills: [ListItems] = []
    var searchedItems: [ListItems] = []

}

extension BillPaymentSearchPresenter: BillPaymentSearchPresenterProtocol {

    func navigateTo(navTitle:String,bill:ListItems) {
        switch(bill.type){
        case .mobilEtisalat,.mobileDu,.homeDEWA,.homeLootahGas,.vehicleMawaqif,.vehicleSalik:
            self.router?.go(to: .navigateToBillAccountDetail(navTitle:navTitle, selectedItem: bill))
      
//        case .vehicleTrafficFineDubaiPolice:
//            break
//        case .ipMobile:
//        case .vehiclemParking:
        default:
          break
        }
    }
    func search(_ text:String) {
        self.searchedItems = []
        if searchText  == nil || searchText?.isEmpty == true {
            for bill in allBills {
                searchedItems.append(bill)
            }
        }else{
            for bill in allBills {
                if bill.title?.lowercased().contains(/self.searchText?.lowercased()) == true {
                    searchedItems.append(bill)
                }
                for item in (bill.listItems ?? []) {
                    if item.title?.lowercased().contains(/self.searchText?.lowercased()) == true {
                        searchedItems.append(item)
                    }
                }
            }
        }
        self.view?.setDropDownView(searchedItems)
    }
    func loadTableViewDataSource(datasource:[ListItems]){
        tableViewDataSource = []
        datasource.forEach {tableViewDataSource.append(SearchCategoryCellModel(item: $0))}
//        if searchText  == nil || searchText?.isEmpty == true {
//            for bill in allBills {
//                tableViewDataSource.append(SearchCategoryCellModel(item: bill))
//            }
//        }else{
//            for bill in allBills {
//                if bill.title?.lowercased().contains(/self.searchText) == true {
//                    tableViewDataSource.append(SearchCategoryCellModel(item: bill))
//                }
//                for item in (bill.listItems ?? []) {
//                    if item.title?.lowercased().contains(/self.searchText) == true {
//                        tableViewDataSource.append(SearchCategoryCellModel(item: item))
//                    }
//                }
//            }
//        }
        view?.reloadSearchCategoriesTable()
    }
    func makeCollectionViewDatasource() {
        for bill in allBills {
            self.dataSource.append(SearchCategoryCellModel(item: bill))
        }
    }
    func loadData() {
        makeCollectionViewDatasource()
        self.loadTableViewDataSource(datasource: self.allBills)
    }
}

extension BillPaymentSearchPresenter: BillPaymentSearchInteractorOutputProtocol {
    func didStartSearch(text: String) {
        searchText = text
    }
    func didTapSearchBtn() {
//        if searchText.isEmpty {
//            view?.searchTextFieldFocus()
//        } else {
//            view?.handleSearchCancelled()
//            view?.updateSearchTextField(text: "")
//        }
    }
    
    func loadBillsListItemBottomSheet(title: String, listItems: [ListItems]) {
        self.router?.go(to: .bottomSheetWithBillsListItems(title: title, dataSource: listItems))
    }
}

