//
//  BillPaymentSearchViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 08/06/2023.
//  
//

import UIKit
import DropDown

class BillPaymentSearchViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var searchTextField: StandardTextField!
    @IBOutlet private weak var promotionsView: UICollectionView!
    @IBOutlet private weak var pageControl: AdvancedPageControlView!
    @IBOutlet private weak var searchForLabel: UILabel!
    @IBOutlet private weak var searchCategoriesTableView: UITableView!
    @IBOutlet private weak var searchCategoriesTableViewHeight: NSLayoutConstraint!
    
    // MARK: Properties
    var presenter: BillPaymentSearchPresenterProtocol?
    private let dropDown = DropDown()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      //  setDropDownView()
    }
    
    private func setUI() {
        setNavigationController()
        setPromotionCollectionView()
        setPromotionPagingControl()
        setSearchForCategoriesTableView()
        setSearchBarTextField()
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: "Search")
        createNavBackBtn()
    }
    
    private func setPromotionCollectionView() {
        promotionsView.register(UINib(nibName: "\(SearchPromotionCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "SearchPromotionCollectionViewCell")
        promotionsView.dataSource = self
        promotionsView.delegate = self
    }
    private func setPromotionPagingControl() {
        pageControl.drawer = ExtendedDotDrawer(numberOfPages: presenter?.dataSource.count ?? 0,
                                               height: 6.0,
                                               width: 6.0,
                                               space: 4.0,
                                               raduis: 4.0,
                                               currentItem: 0.0,
                                               indicatorColor: AppColor.eAnd_Red,
                                               dotsColor: AppColor.eAnd_Grey_20,
                                               isBordered: false,
                                               borderColor: .clear,
                                               borderWidth: 0.0,
                                               indicatorBorderColor: .clear,
                                               indicatorBorderWidth: 0.0)
        if LocaleManager.isRTLLanguage() {
            pageControl.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    func setDropDownView(_ datasource:[ListItems]) {
        dropDown.anchorView = searchTextField
        dropDown.bottomOffset = CGPoint(x:0, y: searchTextField.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [weak self] in
            self?.searchTextField.resignFirstResponder()
        }
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = datasource.map({ return /$0.title})
        
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.cellNib = UINib(nibName: "CustomDropDownCellWithImageTableViewCell", bundle: .main)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCellWithImageTableViewCell else { return }
            customCell.item = datasource[index]
//            customCell.imgView.image = UIImage(named:imageDataSource[index])
            if index == self.dropDown.dataSource.count - 1{
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        
        dropDown.selectionAction = { (index,item) in
            self.dropDown.hide()
            self.searchTextField.resignFirstResponder()
            self.presenter?.loadTableViewDataSource(datasource: self.presenter?.searchedItems ?? [])
            self.searchTextField.text = item
            
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
    private func setSearchForCategoriesTableView() {
        searchCategoriesTableView.register(UINib(nibName: "\(SearchCategoriesTableViewCell.self)", bundle: .main) , forCellReuseIdentifier: "\(SearchCategoriesTableViewCell.self)")
        searchCategoriesTableView.delegate = self
        searchCategoriesTableView.dataSource = self
    }
    
    private func setSearchBarTextField() {
        searchTextField.showTitleWhenActive = false
        searchTextField.getTextField.autocorrectionType = .no
        searchTextField.trailingButtonImage = "search-normal"
        searchTextField.title = Strings.BillPayment.searchForBiller
        searchTextField.trailingButtonTappedCallback = {
            if self.searchTextField.text.count > 0 {
                self.searchTextField.resignFirstResponder()
                self.searchTextField.text = ""
                self.presenter?.loadData()
            }
        }
        searchTextField.textChangedCallback = {
            if self.searchTextField.getTextField.isEditing {
                if self.searchTextField.text.removeWhitespace().count > 2 {
                    self.presenter?.didStartSearch(text:self.searchTextField.text)
                }
            }
//            else{
//                self.presenter?.loadTableViewDataSource(datasource: self.presenter?.searchedItems ?? [])
//            }
            if self.searchTextField.text.removeWhitespace().count > 0 {
                self.searchTextField.trailingButtonImage = "cross"
            }else{
                self.searchTextField.trailingButtonImage = "search-normal"
            }
        }
        searchTextField.textFieldDidBeginEditingCallback = {
            self.searchTextField.showError(with: "")
            if self.searchTextField.text.removeWhitespace().count > 0 {
                self.searchTextField.trailingButtonImage = "cross"
            }else{
                self.searchTextField.trailingButtonImage = "search-normal"
            }
        }
        searchTextField.textFieldDidEndEditingCallback = {
            self.searchTextField.hideError()
            if self.searchTextField.text.removeWhitespace().count > 0 {
                self.searchTextField.trailingButtonImage = "cross"
            }else{
                self.searchTextField.trailingButtonImage = "search-normal"
            }
        }
    }
}

extension BillPaymentSearchViewController: BillPaymentSearchViewProtocol {
    func reloadSearchCategoriesTable() {
        searchCategoriesTableView.reloadData()
    }
    func updateSearchCategoriesTableWith(height: CGFloat) {
        searchCategoriesTableViewHeight.constant = height
    }
    func handleSearchCancelled() {
       
    }
    func handleSearchStarted() {
      
    }
    func updateSearchTextField(text: String) {
        searchTextField.text = text
    }
    func searchTextFieldFocus() {
        searchTextField.becomeFirstResponder()
    }
}

extension BillPaymentSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter?.tableViewDataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model?.reusableIdentifier() ?? "") as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setPromotionPagingControl()
        return self.presenter?.tableViewDataSource.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let itemList =  self.presenter?.tableViewDataSource[indexPath.row] as? SearchCategoryCellModel,
            let item = itemList.item{
            if itemList.item?.isParent == true {
                self.presenter?.loadBillsListItemBottomSheet(title:/itemList.item?.title, listItems:itemList.item?.listItems ?? [])
            }else{
                let title = /self.presenter?.allBills.first(where: {$0.codeId == item.parentCodeId})?.title
                self.presenter?.navigateTo(navTitle: title, bill: item)
            }
        }
    }
}

extension BillPaymentSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = promotionsView.dequeueReusableCell(withReuseIdentifier: "SearchPromotionCollectionViewCell", for: indexPath) as? SearchPromotionCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = presenter?.dataSource.count ?? 0
        return presenter?.dataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.setPage(indexPath.row)
    }
}

extension BillPaymentSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
