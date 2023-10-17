//
//  BillPaymentSearchContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 08/06/2023.
//  
//

import Foundation

protocol BillPaymentSearchViewProtocol: ViperView {
    func reloadSearchCategoriesTable()
    func updateSearchCategoriesTableWith(height: CGFloat)
    func handleSearchCancelled()
    func handleSearchStarted()
    func updateSearchTextField(text: String)
    func searchTextFieldFocus()
    func setDropDownView(_ datasource:[ListItems])
}

protocol BillPaymentSearchPresenterProtocol: ViperPresenter {
    func loadTableViewDataSource(datasource:[ListItems])
    var tableViewDataSource: [StandardCellModel] { get }
    var dataSource: [SearchCategoryCellModel] { get }
    var allBills: [ListItems] {set get}
    var searchedItems: [ListItems] {set get}
    func loadData()
    func didStartSearch(text: String)
    func didTapSearchBtn()
    func loadBillsListItemBottomSheet(title:String,listItems:[ListItems])
    func navigateTo(navTitle:String,bill:ListItems)
    var searchText:String? {get}
}

protocol BillPaymentSearchInteractorProtocol: ViperInteractor {

}

protocol BillPaymentSearchInteractorOutputProtocol: AnyObject {
}

protocol BillPaymentSearchRouterProtocol: ViperRouter {
    func go(to route: BillPaymentSearchRouter.Route)
}
