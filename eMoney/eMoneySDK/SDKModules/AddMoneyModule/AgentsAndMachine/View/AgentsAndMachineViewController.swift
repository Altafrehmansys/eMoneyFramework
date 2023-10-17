//
//  AgentsAndMachineViewController.swift
//  e&money
//
//  Created by Qamar Iqbal on 04/05/2023.
//  
//

import Foundation
import UIKit
import MapKit

class AgentsAndMachineViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var presenter: AgentsAndMachinePresenterProtocol!
    var pageNumber = 0
    var selectedRowIndex: Int?
    private var currentLocation: CLLocation?
    
    private let locationManager = LocationManager()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.loadData()
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(AgentsAndMachineViewController.self) release from memory")
    }
}

extension AgentsAndMachineViewController: AgentsAndMachineViewProtocol {
    func setupUI() {
        setupTableView()
        
        locationManager.delegate = self
        locationManager.requestLocationPermission()
        
        let title = presenter.getLocationNearByType == GetLocationsView.agentsView.rawValue ? Strings.AddMoney.agentsNearby : Strings.AddMoney.paymentMachinesNearby
        
        self.titleLabel.text = title
        self.titleLabel.font = AppFont.appSemiBold(size: .body2)
        self.titleLabel.textColor = AppColor.eAnd_Black_80
        
        self.subtitleLabel.font = AppFont.appRegular(size: .body4)
        self.subtitleLabel.textColor = AppColor.eAnd_Grey_100
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
        
        self.subtitleLabel.text = "\(presenter.locationsList.count)" + " " + Strings.AddMoney.results
    }
    
    func updateDataSource(with state: FloatingPanelState) {
        presenter.updateDataSource(with: state)
    }
}

// MARK: - UITableViewDataSource
extension AgentsAndMachineViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.reusableIdentifier()) as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        let totalPages = presenter.totalPages
        
        if indexPath.row == presenter.dataSource.count - 3 && pageNumber <= totalPages{
            pageNumber += 1
            presenter.loadPageData(pageNumber: pageNumber,
                   latitude: currentLocation?.coordinate.latitude ?? 0.0,
                   longitude: currentLocation?.coordinate.longitude ?? 0.0)
        }
    }
}

// MARK: - UITableViewDelegate
extension AgentsAndMachineViewController {
    
    func showChooseMapBottomSheetAlert(lat: Double, long: Double, destinationName: String) {
        
        let alert = UIAlertController(title: nil, message: Strings.AddMoney.chooseAnApplication, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Strings.Generic.cancel, style: .cancel, handler: nil))

        let urlString = "comgooglemaps://?saddr=&daddr=" + String(lat) + "," + String(long) + "&directionsmode=driving"
        if let url = URL(string: urlString) {
            let canOpenURLString = "comgooglemaps://"
            if let canOpenURL = URL(string: canOpenURLString) {
                if UIApplication.shared.canOpenURL(canOpenURL) {
                    let handler: (UIAlertAction) -> Void = { _ in
                        UIApplication.shared.open(url, options: [:])
                    }
                    let alertAction = UIAlertAction(title: Strings.AddMoney.googleMaps, style: .default, handler: handler)
                    alert.addAction(alertAction)
                }
            }
        }

        alert.addAction(UIAlertAction(title: Strings.AddMoney.appleMaps, style: .default, handler: { _ in
            self.showDeviceMap(lat: lat, long: long, destinationName: destinationName)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func showDeviceMap(lat: Double, long: Double, destinationName: String) {
        // Create a placemark using the latitude and longitude coordinates
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let placemark = MKPlacemark(coordinate: coordinates)

        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = destinationName

        mapItem.openInMaps(launchOptions: nil)
    }
}


// MARK: - Location Manager Delegate Methods
extension AgentsAndMachineViewController: LocationManagerDelegate {
    func locationManager(didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            presenter.loadPageData(pageNumber: 0, latitude: 0, longitude: 0)
        }
    }
    
    func locationManager(didUpdateLocation location: CLLocation) {
        self.currentLocation = location
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        presenter.loadPageData(pageNumber: 0, latitude: lat, longitude: long)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(didFailWithError error: Error) {
        
    }
}
