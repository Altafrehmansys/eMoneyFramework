//
//  MapTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 28/07/2023.
//

import UIKit
import MapKit

class MapTableViewCell: StandardCell {

    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Class Properties
    private let locationManager = LocationManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.setup()
    }
    
    override func configureCell() {
        if let model = cellModel as? MapTableViewCellModel {
            let annotations = model.coordinates.map { location -> MKAnnotation in
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                return annotation
            }
            mapView.addAnnotations(annotations)
            
            if locationManager.isLocationEnabled() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    let region = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
                    self.mapView.setRegion(region, animated: true)
                }
            } else {
                mapView.showAnnotations(annotations, animated: true)
            }
        }
    }
    
    private func setup() {
        self.setupMapView()
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        mapView.layer.cornerRadius = 12
        mapView.layer.masksToBounds = true
    }
}

// MARK: - Class Methods
extension MapTableViewCell: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }

        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? CustomAnnotationView
        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        annotationView?.image = UIImage(named: "pin")
        annotationView?.canShowCallout = true

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let annotation = annotation as? MKPointAnnotation else {
            return
        }
        
        if let model = cellModel as? MapTableViewCellModel {
            model.lat = annotation.coordinate.latitude
            model.long = annotation.coordinate.longitude
            model.actions?.cellSelected(0, model)
        }
    }
}


class CustomAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            if let annotation = annotation as? MKPointAnnotation {
                image = UIImage(named: "location")
                centerOffset = CGPoint(x: 0, y: -image!.size.height / 2)
            }
        }
    }
}

// MARK: - Cell Model
final class MapTableViewCellModel: StandardCellModel {
    let coordinates: [CLLocation]
    
    var lat: Double?
    var long: Double?
    
    init(actions: StandardCellModel.ActionsType = nil, coordinates: [CLLocation]) {
        self.coordinates = coordinates
        
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return MapTableViewCell.identifier()
    }
}
