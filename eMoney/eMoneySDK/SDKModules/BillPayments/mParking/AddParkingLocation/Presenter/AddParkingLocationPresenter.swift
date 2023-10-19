//
//  AddParkingLocationPresenter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/06/2023.
//  
//

import Foundation
import UIKit
//import DropDown

class AddParkingLocationPresenter {

    // MARK: Properties

    weak var view: AddParkingLocationViewProtocol?
    var router: AddParkingLocationRouterProtocol?
    var interactor: AddParkingLocationInteractorProtocol?
    var cellActions:StandardCellActions? =  nil
    let dropDown = DropDown()
    
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            if let model = model as? SingleButtonTableViewCellModel {
                if model.type == .PlainButton{
                    //Redirect to map
                
                }else{
                    //Confirm parking
                    UIApplication.getTopViewController()?.dismiss(animated: true,completion: {
                        UIApplication.getTopViewController()?.navigationController?.popViewController(animated: true)
                    })
                }
            }
        })
    }
    func customizeDropDown(dataSource:[String],imageDataSource:[String],anchorView:StandardTextField) {
      
        dropDown.anchorView = anchorView as? any AnchorView
        dropDown.bottomOffset = CGPoint(x:0, y: anchorView.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [unowned self] in
            anchorView.resignFirstResponder()
        }
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource

        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "CustomDropDownCellWithImageTableViewCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCellWithImageTableViewCell else { return }
            customCell.imgView.image = UIImage(named:imageDataSource[index])
            if index == self.dropDown.dataSource.count - 1{
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        
        dropDown.selectionAction = { (index,item) in
            anchorView.text = item
            anchorView.leadingButtonImage = imageDataSource[index]
            anchorView.setupConfigurations()
            anchorView.resignFirstResponder()
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
    private func presentDetails() {
        var datasource:[StandardCellModel] = []
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.parkingDetails,
                                                      font:AppFont.appRegular(size: .body2),alignment: .center))
        datasource.append(SpaceTableViewCellModel(height: 20))
        datasource.append(GenericSingleLabelCellModel(content: "334-A",
                                                      font:AppFont.appSemiBold(size: .body1),
                                                      alignment: .center,
                                                      topSpace: 0,bottomSpace: 0))
        datasource.append(GenericSingleLabelCellModel(content: "Burj Khalifa".localized,
                                                      font:AppFont.appRegular(size: .body1),
                                                      alignment: .center,
                                                      topSpace: 0,
                                                      bottomSpace: 0))
        datasource.append(SpaceTableViewCellModel(height: 26))
        datasource.append(TableViewCellModelWithUITableView(dataSource: self.getParkingDetailsDatasource(),
                                                            borderWidth: 1,
                                                            borderColor: AppColor.eAnd_Grey_30,
                                                            cornerRadius: 10,
                                                            leftSpace: 24,
                                                            rightSpace: 24))
        datasource.append(SpaceTableViewCellModel(height: 20))
        datasource.append(SingleButtonTableViewCellModel(actions:self.cellActions,
                                                         title:Strings.BillPayment.confirmParking,
                                                         height:48,
                                                         type: .GradientButton,
                                                         font: AppFont.appSemiBold(size: .body3),
                                                         leftSpace: 24,
                                                         rightSpace: 24))
        datasource.append(SingleButtonTableViewCellModel(actions:self.cellActions,
                                                         title: Strings.BillPayment.directions,
                                                         height: 48,
                                                         type: .PlainButton,
                                                         font:AppFont.appSemiBold(size: .body3)))
        self.router?.go(to: .presentParkingDetails(GenericBottomSheetRouter.RouterInput(dataSource: datasource)))
        
    }
    private func getParkingDetailsDatasource() -> [StandardCellModel] {
        var datasource:[StandardCellModel] = []
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.timings, value: "8 AM - 11 PM"))
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(SingleLineCellModel())
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.parkingFees,
                                                      font:AppFont.appSemiBold(size: .body3),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment: .left))
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(KeyValueTableViewCellModel(key: "1 hour".localized, value: "AED 2.00"))
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(SingleLineCellModel())
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(KeyValueTableViewCellModel(key: "2 - 5 hours".localized, value: "AED 5.00"))
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(SingleLineCellModel())
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(KeyValueTableViewCellModel(key: "5 - 14 hours".localized, value: "AED 10.00"))
        datasource.append(SpaceTableViewCellModel(height: 10))
        return datasource
    }
    
}

extension AddParkingLocationPresenter: AddParkingLocationPresenterProtocol {
    func loadData() {
        self.view?.setupUI()
        self.setupCellActions()
    }
    func presentParkingDetails() {
        self.presentDetails()
    }
    func showDropDown(anchorView:StandardTextField) {
        self.customizeDropDown(dataSource: ["Abu Dhabi", "Dubai","Sharjah","ajman","Ras Al khaimah"], imageDataSource: ["etisalat", "etisalat","etisalat","etisalat","etisalat"],anchorView: anchorView)
    }
}

extension AddParkingLocationPresenter: AddParkingLocationInteractorOutputProtocol {
    
}
