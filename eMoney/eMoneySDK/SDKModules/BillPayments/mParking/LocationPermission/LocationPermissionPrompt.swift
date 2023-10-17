//
//  LocationPermissionPrompt.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/06/2023.
//

import UIKit

class LocationPermissionPrompt {
    static let shared = LocationPermissionPrompt()
    private  var enabledLocation:(()->Void)?
    private  var addManully:(()->Void)?
    func present(enabledLocation:(()->Void)?,
                       addManully: (()->Void)?) {
        self.enabledLocation = enabledLocation
        self.addManully = addManully
        var datasource:[StandardCellModel] = []
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(SingleImageTableViewCellModel(image: "location-tick"))
        datasource.append(SpaceTableViewCellModel(height: 10))
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.neverPayForThe,
                                                      font: AppFont.appLight(size: .h7),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment:.center,
                                                      topSpace: 0,
                                                      bottomSpace: 0))
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.wrongParkingSpace,
                                                      font: AppFont.appSemiBold(size: .h7),
                                                      color: AppColor.eAnd_Black_80,
                                                      alignment:.center,
                                                      topSpace: 0,
                                                      bottomSpace: 0))
        datasource.append(SpaceTableViewCellModel(height: 6))
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.enable_location_service_find_parking,
                                                      font: AppFont.appRegular(size: .body3),
                                                      color: AppColor.eAnd_Grey_100,
                                                      alignment:.center))
        datasource.append(SpaceTableViewCellModel(height: 6))
        datasource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.only_registered_user_use_service,
                                                      font: AppFont.appRegular(size: .body3),
                                                      color: AppColor.eAnd_Grey_100,
                                                      alignment:.center))
        datasource.append(SpaceTableViewCellModel(height: 30))
        let enableButton = BaseButton()
        enableButton.setTitle(Strings.BillPayment.enable_location_service, for: .normal)
        enableButton.type = .GradientButton
        enableButton.titleLabel?.font = AppFont.appSemiBold(size: .body3)
        enableButton.titleLabel?.textColor = AppColor.eAnd_White
        enableButton.addTarget(self, action: #selector(enableLocation), for: .touchUpInside)
        let addDetailsButton = BaseButton()
        addDetailsButton.type = .PlainButton
        addDetailsButton.setTitle(Strings.BillPayment.add_details_manually, for: .normal)
        addDetailsButton.titleLabel?.font = AppFont.appSemiBold(size: .body3)
        addDetailsButton.titleLabel?.textColor = AppColor.eAnd_Red_100
        addDetailsButton.addTarget(self, action: #selector(addManualLocation), for: .touchUpInside)
        
        let input = GenericBottomSheetRouter.RouterInput(dataSource: datasource,actionButtons: [enableButton,addDetailsButton])
        let vc = GenericBottomSheetRouter.setupModule(input: input)
        vc.modalPresentationStyle = .fullScreen
        UIApplication.getTopViewController()?.present(vc, animated: true)
    }
    @objc func addManualLocation() {
        UIApplication.getTopViewController()?.dismiss(animated: true)
        self.addManully?()
    }
    @objc func enableLocation() {
        UIApplication.getTopViewController()?.dismiss(animated: true)
        self.enabledLocation?()
    }
}
