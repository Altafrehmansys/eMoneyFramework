//
//  CountrySelectionViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/05/2023.
//  
//

import Foundation
import UIKit

protocol CountrySelectionViewControllerDelegate:AnyObject {
    func selectIMTCountryTapped(country:Countries)
}

class CountrySelectionViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var LblNoRecord: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
//    @IBOutlet weak var bottomBtnView: UIView!
//    @IBOutlet weak var heightBottomView: NSLayoutConstraint!
    
    // MARK: Properties
    var countriesData:CountryListData?
    var searchResults = [Countries]()
    var presenter: CountrySelectionPresenterProtocol?
    var delegte: CountrySelectionViewControllerDelegate?
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "Select a country".localized
        lblTitle.font = AppFont.appRegular(size: .body2)
        lblTitle.textColor = AppColor.eAnd_Black_80
        
        LblNoRecord.isHidden = true
        
        textFieldSearch.font = AppFont.appRegular(size: .body2)
        textFieldSearch.textColor = AppColor.eAnd_Black_60
        textFieldSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                            for: .editingChanged)

//        LblNoRecord.font = AppFont.appOldRegular(size: FontSize.old_medium)
//        LblNoRecord.textColor = AppColor.textColorPrimary
        
        if #available(iOS 15, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        
//                    self.heightBottomView.constant = 0
//                    self.bottomBtnView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        searchResults.removeAll()
        if let searchedText = textField.text, !searchedText.isEmpty {
            
            if let obj = self.countriesData?.topCorridors as? [Countries] {
                searchResults.append(contentsOf: obj)
            }
            
            if let obj = self.countriesData?.countries as? [Countries] {
                searchResults.append(contentsOf: obj)
            }
            
            searchResults = searchResults.filter({(item: Countries) -> Bool in
                return item.name?.range(of: searchedText, options: .caseInsensitive) != nil
            })
        }
        LblNoRecord.isHidden = searchResults.count == 0 ? false:true
        tableView.reloadData()
    }
    
    // MARK: IB Actions
    @IBAction func crossButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension CountrySelectionViewController: CountrySelectionViewProtocol {
    func onCounrtriesListResponse(countriesData: CountryListData) {
        
        self.countriesData = countriesData
        self.tableView.reloadData()
    }
    
    func onError(error: AppError) {
        
    }
}

extension CountrySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let searchedText = textFieldSearch.text, !searchedText.isEmpty {
            return 1
        }else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let searchedText = textFieldSearch.text, !searchedText.isEmpty {
            return searchResults.count
        } else {
            self.LblNoRecord.isHidden = searchResults.count == 0 ? false:true
            if section == 0 {
                self.LblNoRecord.isHidden = self.countriesData?.topCorridors?.count ?? 0 == 0 ? false:true
                return self.countriesData?.topCorridors?.count ?? 0
            } else {
                self.LblNoRecord.isHidden = self.countriesData?.countries?.count ?? 0 == 0 ? false:true
                return self.countriesData?.countries?.count ?? 0
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed("CountrySectionHeaderView", owner: nil, options: nil)?.first as? CountrySectionHeaderView

            if let searchedText = textFieldSearch.text, !searchedText.isEmpty {
                view?.setupWithItem(title: "Results".localized)
            }else{
                if section == 0 {
                    view?.setupWithItem(title: "Popular countries".localized)
                } else {
                    view?.setupWithItem(title: "All countries")
                }
            }
        
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailTableViewCell") as? CountryDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        //            cell.delegate = self
        var data = Countries()
        if let searchedText = textFieldSearch.text, !searchedText.isEmpty {
            data = self.searchResults[indexPath.row]
            } else {
                if indexPath.section == 0 {
                    if let obj = self.countriesData?.topCorridors as? [Countries] {
                        data = obj[indexPath.row]
                    }
                } else {
                    if let obj = self.countriesData?.countries as? [Countries] {
                        data = obj[indexPath.row]
                    }
                }
            }
        
        cell.updateCell(country:data , index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var data = Countries()
        if let searchedText = textFieldSearch.text, !searchedText.isEmpty {
            data = self.searchResults[indexPath.row]
            } else {
                if indexPath.section == 0 {
                    if let obj = self.countriesData?.topCorridors as? [Countries] {
                        data = obj[indexPath.row]
                    }
                } else {
                    if let obj = self.countriesData?.countries as? [Countries] {
                        data = obj[indexPath.row]
                    }
                }
            }
        if let del = self.delegte {
            del.selectIMTCountryTapped(country: data)
        }
        
        self.dismiss(animated: true)
    }
}
extension CountrySelectionViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset = .zero
        }
    }
    
}
