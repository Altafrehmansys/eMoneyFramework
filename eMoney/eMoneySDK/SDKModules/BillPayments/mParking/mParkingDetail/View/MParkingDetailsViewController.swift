//
//  MParkingDetailsViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation
import UIKit
//import DropDown

class MParkingDetailsViewController: BaseViewController {
//    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var providerImageView:UIImageView!
    @IBOutlet weak var providerNameLabel:UILabel!
    @IBOutlet weak var tfParkingRegion:StandardTextField!
    @IBOutlet weak var tfParkingZone:StandardTextField!
    @IBOutlet weak var parkingZoneInfoView:UIView!
    @IBOutlet weak var parkingZoneInfoLeftButton:UIButton!
    @IBOutlet weak var parkingZoneInfoLabel:UILabel!
    @IBOutlet weak var parkingZoneRightButton:UIButton!
    @IBOutlet weak var vehicleSelectedLabal:UILabel!
    
    @IBOutlet weak var lblPriceTitle:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    
    @IBOutlet weak var btnAddVehicleDetails:UIButton!
    
    @IBOutlet weak var tfNumberOfHours:StandardTextField!
    @IBOutlet weak var btnSendSMS: BaseButton!
    @IBOutlet weak var typeLabel:UILabel!
    @IBOutlet weak var segmentControl: FloatingSegmentedControl!
    @IBOutlet weak var addVehicleView:UIView!
    @IBOutlet weak var addedVehicleView:UIView!
    var dropDown = DropDown()
    // MARK: Properties

    var presenter: MParkingDetailsPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter?.loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.loadData()
    }
    @IBAction func didTapSendSMS(_ sender:UIButton) {
        let parking = ParkingRequestModel(billerContactID: "2",
                                          noOfHours: self.tfNumberOfHours.text,
                                          parkingRegion: self.tfParkingRegion.text,
                                          parkingType: self.segmentControl.focusedIndex.description,
                                          parkingZone: self.tfParkingZone.text, flowName: "Upgrade")
        self.presenter.addParking(parking)
    }
    @IBAction func didTapAddVehicle(_ sender:UIButton) {
        self.presenter.moveToAddNewVehicle()
    }
}
extension MParkingDetailsViewController {
    func handleAddVehicle(_ isAdded:Bool = false) {
        if isAdded {
            addVehicleView.isHidden = true
            addedVehicleView.isHidden = false
        }else{
            addVehicleView.isHidden = false
            addedVehicleView.isHidden = true
        }
    }
    func showInfoView(with success:Bool,message:String) {
        self.parkingZoneInfoView.isHidden = false
        if success {
            self.parkingZoneInfoView.backgroundColor = AppColor.eAnd_Success_10
            self.parkingZoneInfoLeftButton.setImage(UIImage(named: "tick-circle"), for: .normal)
            self.parkingZoneRightButton.isHidden = false
            self.parkingZoneInfoLabel.text = message
        }else{
            self.parkingZoneInfoView.backgroundColor = AppColor.eAnd_Error_10
            self.parkingZoneInfoLeftButton.setImage(UIImage(named: "info-circle-red"), for: .normal)
            self.parkingZoneRightButton.isHidden = true
            self.parkingZoneInfoLabel.text = message
        }
    }
    @IBAction func didTapParkingInfoRightButton(_ sender:UIButton)  {
        
    }
    
}
extension MParkingDetailsViewController: MParkingDetailsViewProtocol {
    func setupZoneTextField () {
        self.parkingZoneInfoView.isHidden = true
        self.tfParkingZone.placeholder = Strings.BillPayment.selectZone
        self.tfParkingZone.trailingButtonImage = "arrow-down"
        self.tfParkingZone.textFieldDidBeginEditingCallback = { [unowned self] in
            let zones = self.presenter.mParkingDetailsZoneResponseModel?.data?.filter({
                return /$0.regionId == /self.presenter.selectedRegion?.id
            }) ?? []
            self.showDropdown(textfield:self.tfParkingZone,
                              dataSource: zones.map({ $0.title ?? "-"}) )
        }
        self.tfParkingZone.textChangedCallback = { [unowned self] in
            self.validateForm()
            self.parkingZoneInfoView.isHidden = true
            let datasource = self.presenter.mParkingDetailsZoneResponseModel?.data?.filter({$0.title?.lowercased().contains(self.tfParkingZone.text.lowercased()) == true}).map({$0.title ?? "-"})
            self.showDropdown(textfield:self.tfParkingZone,
                              dataSource:datasource ?? [])
        }
        self.tfParkingZone.textFieldDidEndEditingCallback = { [unowned self] in
            if let zone = self.presenter.mParkingDetailsZoneResponseModel?.data?.first(where: {
                return $0.title?.lowercased() == self.tfParkingZone.text.lowercased()}) {
                self.showInfoView(with: true, message: /zone.zoneArea)
            }else{
                self.showInfoView(with: false, message: Strings.BillPayment.notFoundEnterValidZone)
            }
        }
    }
    func setupRegionTextField () {
        self.tfParkingRegion.trailingButtonImage = "arrow-down"
        self.tfParkingRegion.backgroundColor = AppColor.eAnd_White
        self.tfParkingRegion.placeholder = Strings.BillPayment.selectParkingRegion
        self.tfParkingRegion.textFieldDidBeginEditingCallback = { [unowned self] in
            self.tfParkingZone.text = ""
            self.parkingZoneInfoView.isHidden = true
            self.showDropdown(textfield:self.tfParkingRegion,
                              dataSource: self.presenter.mParkingDetailsRegionResponseModel?.data?.map({/$0.title}) ?? [],
                              imageDatasource: self.presenter.mParkingDetailsRegionResponseModel?.data?.map({/$0.imageURL}) ?? [])
        }
        self.tfParkingRegion.textChangedCallback = {
            self.validateForm()
        }
    }
    func setupHoursAndPrices () {
        self.tfNumberOfHours.isUserInteractionEnabled = true
        self.tfNumberOfHours.placeholder = Strings.BillPayment.numberOfHours
        self.tfNumberOfHours.trailingButtonImage = "arrow-down"
        self.tfNumberOfHours.trailingButtonTappedCallback = { [unowned self] in
            self.showDropdown(textfield:self.tfNumberOfHours,
                              dataSource: self.presenter.selectedZone?.zoneHours?.map({return /$0.title}) ?? [])
        }
        self.tfNumberOfHours.textFieldDidBeginEditingCallback = { [unowned self] in
            self.showDropdown(textfield:self.tfNumberOfHours,
                              dataSource: self.presenter.selectedZone?.zoneHours?.map({return /$0.title}) ?? [])
        }
        self.tfNumberOfHours.textChangedCallback = {
            self.validateForm()
        }
    }
    func validateForm() {
        if self.tfParkingRegion.text.isEmpty || self.tfParkingRegion.text.isEmpty || self.tfNumberOfHours.text.isEmpty {
            self.btnSendSMS.disable()
            return
        }
        self.btnSendSMS.enable()
    }
    func setupUI() {
        self.btnSendSMS.disable()
        self.handleAddVehicle()
        self.bottomLabel.text = Strings.BillPayment.moneyWillBeDeductedFromAccount
        self.bottomLabel.font = AppFont.appRegular(size: .body4)
        self.bottomLabel.textColor = AppColor.eAnd_Grey_100
       
        self.setupRegionTextField()
        self.setupZoneTextField()
        self.setupHoursAndPrices()
        
        self.vehicleSelectedLabal.text = Strings.BillPayment.vehicleSelected
        
        
        self.lblPriceTitle.text = Strings.BillPayment.parkingFees
        self.lblPriceTitle.textColor = AppColor.eAnd_Grey_100
        self.lblPriceTitle.font = AppFont.appRegular(size: .body4)
        
        self.lblPrice.text = "AED ---"
        self.lblPrice.textColor = AppColor.eAnd_Black_80
        self.lblPrice.font = AppFont.appRegular(size: .body2)
        
        self.btnAddVehicleDetails.setTitle(Strings.BillPayment.add_vehicle_details, for: .normal)
        self.btnAddVehicleDetails.titleLabel?.font = AppFont.appRegular(size: .body3)
        self.btnAddVehicleDetails.setTitleColor(AppColor.eAnd_Black_80, for: .normal)
        self.btnAddVehicleDetails.setPadding(.all(value: 12))
        
        if let url = URL(string: /self.presenter.selectedItem?.imageUrl) {
            self.providerImageView.load(url: url)
        }
        self.providerNameLabel.text = Strings.BillPayment.mParking
        self.providerNameLabel.textColor = AppColor.eAnd_Black_80
        self.providerNameLabel.font = AppFont.appSemiBold(size: .body2)
        self.view.backgroundColor = .white
        self.btnSendSMS.type = .GradientButton
        self.btnSendSMS.setTitle("Send mParking SMS", for: .normal)
        self.btnSendSMS.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        self.setUpNavbar()
        self.setUpSegment()
        self.parkingZoneInfoLabel.font = AppFont.appMedium(size: .body4)
    }
    fileprivate func setUpSegment(){
        segmentControl.setSegments(with: [Strings.BillPayment.standard,
                                          Strings.BillPayment.premium])
//        segmentControl.addTarget(self, action: #selector(update(_:)))
        segmentControl.isAnimateFocusMoving = true
        segmentControl.focusedIndex = 0
    }
    private func setUpNavbar(){
        self.navigationItem.setTitle(title:self.presenter.navTitle,subtitle: "Account details")
        self.createNavBackBtn()
    }
    func showDropdown(textfield:StandardTextField,dataSource:[String],imageDatasource:[String]? = nil) {
        if textfield != self.tfParkingZone {
            textfield.resignFirstResponder()
        }
        dropDown.anchorView = textfield
        dropDown.bottomOffset = CGPoint(x:0, y: textfield.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [unowned self] in
            textfield.resignFirstResponder()
        }
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "CustomDropDownCellWithImageTableViewCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCellWithImageTableViewCell else { return }
            if textfield == self.tfParkingRegion {
                if let url = URL(string:/imageDatasource?[index]) {
                    customCell.imageView?.load(url: url)
                }
            }
            if index == self.dropDown.dataSource.count - 1{
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        dropDown.selectionAction = { (index,item) in
            textfield.text = item
            textfield.resignFirstResponder()
            textfield.hideError()
            if textfield == self.tfParkingRegion {
                self.presenter.selectedZone = nil
                self.presenter.selectedRegion = self.presenter.mParkingDetailsRegionResponseModel?.data?[index]
            }
            if textfield == self.tfParkingZone {
                self.presenter.selectedZone = self.presenter.mParkingDetailsZoneResponseModel?.data?[index]
                self.tfNumberOfHours.text = /self.presenter.selectedZone?.zoneHours?.first?.title
                if self.segmentControl.focusedIndex ==  0 {
                    self.lblPrice.text = /self.presenter.selectedZone?.zoneHours?.first?.standardHourFee
                }else{
                    self.lblPrice.text = /self.presenter.selectedZone?.zoneHours?.first?.premiumHourFee
                }
                
            }
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
}

// MARK: - UITableViewDelegate
extension MParkingDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
