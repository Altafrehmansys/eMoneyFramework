//
//  BillsAndTopsUpViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation
import UIKit

class BillsAndTopsUpViewController: BaseViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchParentView: UIView!
    var presenter: BillsAndTopsUpPresenterProtocol!
    

    var collectionFlowLayout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:(UIScreen.main.bounds.width - 90) / 3 , height:90)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 34, bottom: 0, right: 34)
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize =  CGSize(width: self.view.frame.width, height: 40)
        flowLayout.footerReferenceSize =  CGSize(width: self.view.frame.width, height: 20)
        return flowLayout
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension BillsAndTopsUpViewController: BillsAndTopsUpViewProtocol {
    
    func setupUI() {
        self.setupCollectionView()
        self.setupTableView()
        if presenter.isSavedBills {
            tblView.isHidden = false
            collectionView.isHidden = true
            searchParentView.isHidden = true
        }else{
            tblView.isHidden = true
            collectionView.isHidden = false
            searchParentView.isHidden = false
        }
      
        setUpNavbar()
    }
    private func setUpNavbar(){
        self.navigationItem.setTitle(title:Strings.BillPayment.billsAndTopup)
        self.createNavBackBtn()
        setUpSearchBar()
    }
    func setUpSearchBar(){
        searchParentView.borderWidth = 1
        searchParentView.borderColor = AppColor.eAnd_Grey_30
        searchParentView.cornerRadius = 16
        btnSearch.setTitle(Strings.BillPayment.searchForBiller, for:.normal)
        btnSearch.titleLabel?.textColor = AppColor.eAnd_Grey_70
        btnSearch.titleLabel?.font = AppFont.appRegular(size: .body2)
        btnSearch.titleLabel?.tintColor =  AppColor.eAnd_Grey_70
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        searchParentView.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.presenter.navigateToSearch()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = collectionFlowLayout
        collectionView.register(UINib(nibName: "SingleTitleCollectionReusableView", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"SingleTitleCollectionReusableView")
        
        collectionView.register(UINib(nibName: "SeparatorLineCollectionReusableView", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:"SeparatorLineCollectionReusableView")
        collectionView.registerCell(type: ImageAndTitleCollectionViewCell.self)
    }
    
    func reloadTableView() {
        let identifiers = presenter.tableViewDataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tblView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tblView.reloadData()
    }
    
    private func setupTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.showsVerticalScrollIndicator = false
        tblView.separatorStyle = .none
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension BillsAndTopsUpViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.collectionViewDataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.collectionViewDataSource[section].listItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  let data = presenter.collectionViewDataSource[indexPath.section].listItems?[indexPath.row] as? ListItems {
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier:"ImageAndTitleCollectionViewCell", for: indexPath as IndexPath) as! ImageAndTitleCollectionViewCell
            
            cell.configureCell(with:data)
            return cell
        }
    
        return UICollectionViewCell()
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if  let data = presenter.collectionViewDataSource[indexPath.section].listItems?[indexPath.row] as? ListItems {
            switch BillsAnsTopUpType(rawValue:data.codeId ?? "0") {
                
            case .mobilEtisalat:
                self.presenter.navigateToMobileEtiSalat(navTitle:presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
                
            case .mobileDu:
                self.presenter.navigateToMobileDU(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
                
            case .homeDEWA:
                self.presenter.navigateToDEWA(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
           
            case .homeEtisalatELife:
                self.presenter.navigateToHomeEtisalat(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .homeDu:
                self.presenter.navigateToHomeDU(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .homeISTA:
                self.presenter.navigateToISTA(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .homeSEWA:
                
                self.presenter.navigateToSEWA(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
               
            case .homeAADC:
                self.presenter.navigateToAADC(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .homeADDC:
                self.presenter.navigateToADDC(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .homeEtihadWaterAndElectricity:
                self.presenter.navigateToEtihadWaterAndElectricity(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .homeAjmanSewerage:
                self.presenter.navigateToAjmanSewerage(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .homeSERGAS:
                self.presenter.navigateToSERGAS(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .homeLootahGas:
                self.presenter.navigateToLootahGas(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
                
            case .vehicleTrafficFineDubaiPolice:
                self.presenter.navigateDubaiTraficFine(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
                
            case .vehicleMawaqif:
                self.presenter.navigateMawaqif(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
                
            case .ipMobile:
                self.presenter.navigateToInternationalMobile(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)

            case .vehiclemParking:
                self.presenter.navigateToMParking(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
                
            case .osISTARegistration:
                break
              //  self.presenter.navigateToISTARegistration(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
                
            case .vehicleSalik:
                self.presenter.navigateToSalik(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .govtAjmanPay:
                break
               // self.presenter.navigateToAjmanPay(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
            case .osNationalbonds:
                self.presenter.navigateToNationalBonds(navTitle: presenter.collectionViewDataSource[indexPath.section].title ?? "", selectedItem: data)
                
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SingleTitleCollectionReusableView", for: indexPath) as! SingleTitleCollectionReusableView
            let headerTitle = presenter.collectionViewDataSource[indexPath.section].title
            header.titleLabel.text = headerTitle
            return header
        }else {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SeparatorLineCollectionReusableView", for: indexPath) as! SeparatorLineCollectionReusableView
            return header
        }
    }
}

// MARK: - UITableViewDataSource
extension BillsAndTopsUpViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.tableViewDataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.reusableIdentifier()) as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension BillsAndTopsUpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.tableViewDataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
