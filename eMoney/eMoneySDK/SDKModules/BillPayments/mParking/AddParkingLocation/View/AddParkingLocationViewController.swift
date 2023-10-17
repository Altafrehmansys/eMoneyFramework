//
//  AddParkingLocationViewController.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/06/2023.
//  
//

import Foundation
import UIKit
import MapKit

class AddParkingLocationViewController: BaseViewController {
    @IBOutlet weak var tfRegions: StandardTextField!
    @IBOutlet weak var btnPark:BaseButton!
    @IBOutlet weak var searchTextField: StandardTextField!
    @IBOutlet weak var mapView:UIView!
    
    // MARK: Properties
    
    var presenter: AddParkingLocationPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    @IBAction func didTapDropDown(_ sender: UIButton) {
    }
    @IBAction func didTapPark(_ sender:UIButton) {
        self.presenter?.presentParkingDetails()
    }
}

extension AddParkingLocationViewController: AddParkingLocationViewProtocol {
    func setupUI() {
        self.setupNavigation()
    }
    private func setupNavigation() {
        self.navigationItem.setTitle(title: "Vehicles & transport".localized,subtitle:Strings.BillPayment.selectZone,isBoldTitle: true)
        self.createNavBackBtn()
        self.btnPark.setTitle(Strings.BillPayment.parkHere, for: .normal)
        self.btnPark.type = .GradientButton
        self.setupMapView()
        self.setupSearchBar()
        self.setupDropDown()
    }
    private func setupMapView() {
        let mkMapView = MKMapView(frame: self.mapView.bounds)
        self.mapView.addSubview(mkMapView)
    }
    private func setupSearchBar() {
        self.searchTextField.trailingButtonImage = "search-normal"
        self.searchTextField.placeholder = Strings.BillPayment.searchUsingZoneNumber
        self.searchTextField.textFieldFont = AppFont.appRegular(size: .body2)
        self.searchTextField.trailingButtonTappedCallback = {[weak self] in
            
            
        }
    }
    private func setupDropDown() {
        self.tfRegions.prefixFont = AppFont.appRegular(size: .body4)
        self.tfRegions.textFieldTextColor = AppColor.eAnd_Black_80
        self.tfRegions.getTextField.inputView = UIView()
        self.tfRegions.trailingButtonImage = "arrow-down"
        self.tfRegions.placeholder = Strings.BillPayment.selectParkingRegion
       // tfRegion.leadingButtonImage = "etisalat-icon"
        
        self.tfRegions.textFieldDidBeginEditingCallback = {
            self.presenter?.showDropDown(anchorView:self.tfRegions)
        }
    }
}
