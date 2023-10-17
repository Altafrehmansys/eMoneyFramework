//
//  SelectLanguageViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/04/2023.
//  
//

import Foundation
import UIKit

class SelectLanguageViewController: BaseViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var buttonSelectLanguage: BaseButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var languageArray = [LanguageData]()
    
    // MARK: Properties
    var presenter: SelectLanguagePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewUserInterface()
        
        self.buttonSelectLanguage.setTitle("select_language_button_text".localized, for: .normal)
    }
    
    func setViewUserInterface() {
        self.tableView.registerCell(type: SelectLanguageTableViewCell.self)
        presenter?.loadData()
//        let vc = WalkthroughIntroRouter.setupModule()
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func didInternetErrorTryAgainTapped() {
        presenter?.loadData()
    }
    
    
    // MARK: IB Actions
    @IBAction func buttonClick(_ sender: Any) {
        if let selectedLang = self.languageArray.first(where: { $0.isSelected })?.languageCode?.lowercased() {
//            if selectedLang == LocaleManager.currentLanguage() {
//                presenter?.navigateToWalkthrough()
//            }else{
//                presenter?.getLangPack(selectedLang:selectedLang)
//            }
            presenter?.getLangPack(selectedLang:selectedLang)
        }
    }
}

// MARK: UITableViewDataSource
extension SelectLanguageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueCell(withType: SelectLanguageTableViewCell.self) as? SelectLanguageTableViewCell else {
            fatalError()
        }
        cell.setCellData(languageObj: languageArray[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension SelectLanguageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectLanguage(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension SelectLanguageViewController : SelectLanguageViewProtocol {
    func onLanguageResponse(languageData: [LanguageData]) {
        languageArray = languageData
        self.tableView.reloadData()
    }
}
