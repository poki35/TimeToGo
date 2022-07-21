//
//  ViewController.swift
//  TimeToGo
//
//  Created by Kirill Ponomarenko on 10.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UISearchResultsUpdating, CLLocationManagerDelegate {
    
    var annotationArray = [MKPointAnnotation]()
    
    lazy var backLabel = UIView(frame: CGRect(x: 100, y: 100, width: 392, height: 150))
    lazy var labell = UILabel(frame: CGRect(x: 100, y: 100, width: 380, height: 60))
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    let trip: UILabel = {
        let label = UILabel()
        label.text = "privet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    var addWayButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sent"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var addResetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    var addMyLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "near-me"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var zoomInButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var zoomOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var searchController: UISearchController = {
        let button = UISearchController()
        button.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labell.center = CGPoint(x: 210, y: 830)
        labell.textAlignment = .center
        labell.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.7)
        labell.textColor = .white
        labell.layer.cornerRadius = 25
        labell.layer.masksToBounds = true
        labell.isHidden = false
        
        backLabel.center = CGPoint(x: 207, y: 65)
        backLabel.layer.cornerRadius = 25
        backLabel.layer.masksToBounds = true
        backLabel.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.7)
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        searchController.searchBar.backgroundColor = UIColor.clear
        searchController.searchBar.placeholder = "Введите адрес.."
        searchController.searchResultsUpdater = self
        
        view.addSubview(mapView)
        navigationItem.searchController = searchController
        title = "Поиск на карте"
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.addSubview(labell)
        mapView.addSubview(backLabel)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        addWayButton.addTarget(self, action: #selector(addWayButtonTapped), for: .touchUpInside)
        addResetButton.addTarget(self, action: #selector(addResetButtonTapped), for: .touchUpInside)
        addMyLocationButton.addTarget(self, action: #selector(addMyLocationButtonTapped), for: .touchUpInside)
        zoomInButton.addTarget(self, action: #selector(zoomInButtonTapped), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(zoomOutButtonTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        setConstraints()
    }
    
    @objc func tapButton() {
        let setViewControoler = SettingsViewController()
        navigationController?.pushViewController(setViewControoler, animated: true)
        
        print("hello, button tapped")
    }
    
    @objc func zoomInButtonTapped() {
        let region = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta * 0.7, longitudeDelta: mapView.region.span.longitudeDelta * 0.7))
        
        mapView.setRegion(region, animated: true)
        
        print("zoom in")
    }
    
    @objc func searching() {
        alertAddAddress(title: "Поиск адреса", placeholder: "Введите адрес") { [self] (text) in
            setupPlaceMark(addressPlace: text)
            
            print("Address searching")
        }
    }
    
    @objc func zoomOutButtonTapped() {
        let zoom = getZoom()
        if zoom > 3.5 {  //Не ставить больше (выходит ошибка)
            
            let region = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta / 0.7, longitudeDelta: mapView.region.span.longitudeDelta / 0.7))
            mapView.setRegion(region, animated: true)
        }
        
        print("zoom out")
    }
    
    @objc func addAddressButtonTapped() {
        
        searchController.searchBar.searchTextField.becomeFirstResponder()
        
    }
    
    @objc func addWayButtonTapped() {
        
        for index in 0...annotationArray.count - 2 {
            createDirectionRequest(startCoordinate: annotationArray[index].coordinate,destinationCoordinate: annotationArray[index + 1].coordinate)
        }
        
        mapView.showAnnotations(annotationArray, animated: true)
        
        print("Add way")
    }
    
    @objc func addResetButtonTapped() {
        
        annotationArray = [MKPointAnnotation]()
        
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        labell.text = nil
        
        addWayButton.isHidden = true
        addResetButton.isHidden = true
        
        print("Add reset")
    }
    
    @objc func addMyLocationButtonTapped() {
        
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        
        print("My location")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            manager.startUpdatingLocation()
            manager.stopUpdatingLocation()
            
            render(location)
            
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
            
        }
    
    func render(_ location:CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func getZoom() -> Double {
        
        var angleCamera = self.mapView.camera.heading
        if  angleCamera > 270 {
            angleCamera = 560 - angleCamera
        }
        
        else if angleCamera > 90 {
            angleCamera = fabs(angleCamera - 180)
        }
        let angleRad = Double.pi * angleCamera / 180
        let width = Double(self.view.frame.size.width)
        let height = Double(self.view.frame.size.height)
        let heightOffset : Double = 20
        let spanStraight = width * self.mapView.region.span.longitudeDelta / (width * cos(angleRad) + (height - heightOffset) * sin(angleRad))
        
        return log2(360 * ((width / 256) / spanStraight)) + 1;
    }
    
    private func setupPlaceMark(addressPlace: String?) {
        
        guard let addressPlace = addressPlace else {
            
            return
        }
        
        let geo = CLGeocoder()
        
        geo.geocodeAddressString(addressPlace) { [weak self] (placemarks, error) in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                print(error)
                
                self.alertError(title: "Ошибка",
                                message: "Service is unavailable")
                
                return
            }
            self.addPlacemarkToMap(placemarks?.first, addressPlace: addressPlace)
            self.searchController.searchBar.text = nil
        }
    }
    
    private func addPlacemarkToMap(_ placemark: CLPlacemark?, addressPlace: String?) {
        
        guard let placemarkLocation = placemark?.location else { return }
        
        let annotation = MKPointAnnotation()
        annotation.title = addressPlace
        annotation.coordinate =  placemarkLocation.coordinate
        
        annotationArray.append(annotation)
        
        if annotationArray.count > 1 {
            addWayButton.isHidden = false
            addResetButton.isHidden = false
        }
        
        mapView.showAnnotations(annotationArray, animated: true)
    }
    
    //    Функция конвертирования RoadTrip из секунд в минуты и часы
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { [weak self] (response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response, let self = self else {
                self?.alertError(title: "Ошибка", message: "Дорога недоступна")
                return
                
            }
            
            let minRoutes = response.routes[0]
            
            if response.routes.count > 0 {
                
                let route = response.routes[0]
                
                print(route.expectedTravelTime)
                self.labell.text = "\(route.expectedTravelTime)"
            }
            
            self.mapView.addOverlay(minRoutes.polyline)
            
            print(minRoutes.expectedTravelTime)
            
        }
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        return renderer
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setupPlaceMark(addressPlace: searchBar.text)
        
    }
}

public extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
}

extension ViewController {
    
    private func setConstraints() {
        
        view.addSubviews(mapView, addWayButton, addResetButton, settingsButton, addMyLocationButton, zoomInButton, zoomOutButton, trip)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 55),
            
            
            addWayButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 165),
            addWayButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -155),
            addWayButton.heightAnchor.constraint(equalToConstant: 80),
            addWayButton.widthAnchor.constraint(equalToConstant: 80),
            
            
            addResetButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 150),
            addResetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addResetButton.heightAnchor.constraint(equalToConstant: 45),
            addResetButton.widthAnchor.constraint(equalToConstant: 45),
            
            
            settingsButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 808),
            settingsButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -335),
            settingsButton.heightAnchor.constraint(equalToConstant: 45),
            settingsButton.widthAnchor.constraint(equalToConstant: 45),
            
            
            addMyLocationButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 808),
            addMyLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -30),
            addMyLocationButton.heightAnchor.constraint(equalToConstant: 45),
            addMyLocationButton.widthAnchor.constraint(equalToConstant: 45),
            
            
            zoomInButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 400),
            zoomInButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
            zoomInButton.heightAnchor.constraint(equalToConstant: 55),
            zoomInButton.widthAnchor.constraint(equalToConstant: 55),
            
            
            zoomOutButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 470),
            zoomOutButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
            zoomOutButton.heightAnchor.constraint(equalToConstant: 55),
            zoomOutButton.widthAnchor.constraint(equalToConstant: 55),
            
            
            trip.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 800),
            trip.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -30),
            trip.heightAnchor.constraint(equalTo: mapView.heightAnchor, constant: 60),
            trip.widthAnchor.constraint(equalTo: mapView.widthAnchor, constant: 60)
        ])
    }
}
