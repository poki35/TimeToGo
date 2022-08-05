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
    // MARK: - Add constants
    var annotationArray = [MKPointAnnotation]()
    
    var typeTransport: MKDirectionsTransportType? {
        didSet {
            if annotationArray.isEmpty == false {
                
                addWayButtonTapped()
            }
        }
    }
    
    lazy var backLabel = UIView(frame: CGRect(x: 100, y: 100, width: 392, height: 150))
    lazy var labell = UILabel(frame: CGRect(x: 100, y: 100, width: 380, height: 60))
    lazy var zoomView = ZoomButtonsView(delegate: self)
    lazy var weatherButton = WeatherButtonView(delegate: self)
    lazy var backView = WayView(delegate: self)
    lazy var trip = TripView(delegate: self)
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    var addWayButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sent"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    var typeMapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "map"), for: .normal)
        return button
    }()
    
    var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        return button
    }()
    
    var addResetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    var addMyLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "near-me"), for: .normal)
        return button
    }()
    
    var searchController: UISearchController = {
        let button = UISearchController()
        return button
    }()
    
    var menuTypeRoad: [UIAction] {
        return [
            UIAction(title: "Пешком", image: nil, handler: { (selectTypeRoad) in
                self.typeTransport = .walking
            }),
            UIAction(title: "На машине", image: nil, handler: { (selectTypeRoad) in
                self.typeTransport = .automobile
            })]}
    
    var menuType: UIMenu {
        return UIMenu(title: "pox", image: nil, options: [], children: menuTypeRoad)
    }
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Стандарт", image: UIImage(systemName: "moon"), handler: { (typeMapButton) in
                self.mapView.mapType = .standard
            }),
            UIAction(title: "Спутник", image: UIImage(systemName: "moon"), handler: { (typeMapButton) in
                self.mapView.mapType = .satellite
            }),
            UIAction(title: "Гибрид", image: UIImage(systemName: "moon"), handler: { (typeMapButton) in
                self.mapView.mapType = .hybrid
            })]}
    
    var demoMenu: UIMenu {
        return UIMenu(title: "Вид карты", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    // MARK: - ViewDidLoad method
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
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.backgroundColor = UIColor.clear
        searchController.searchBar.placeholder = "Введите адрес.."
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        title = "Поиск на карте"
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        backView.isHidden = true
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        configureButtonMenu()
        
        roadType()
        
        addWayButton.addTarget(self, action: #selector(addWayButtonTapped), for: .touchUpInside)
        
        addResetButton.addTarget(self, action: #selector(addResetButtonTapped), for: .touchUpInside)
        
        addMyLocationButton.addTarget(self, action: #selector(addMyLocationButtonTapped), for: .touchUpInside)
        
        settingsButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        typeMapButton.addTarget(self, action: #selector(typeMapButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
    // MARK: - Obj-C functions
    
    @objc func tapButton() {
        let setViewController = SettingsViewController()
        navigationController?.pushViewController(setViewController, animated: true)
        
        print("hello, settings button tapped")
    }
    
    @objc func typeMapButtonTapped() {
        
        print("Compass tapped")
    }
    
    @objc func searching() {
        alertAddAddress(title: "Поиск адреса", placeholder: "Введите адрес") { [self] (text) in
            setupPlaceMark(addressPlace: text)
            
            print("Address searching")
        }
    }
    
    @objc func addAddressButtonTapped() {
        
        searchController.searchBar.searchTextField.becomeFirstResponder()
        
    }
    
    @objc func addWayButtonTapped() {
        
        if let myCoordinate = locationManager.location?.coordinate, let firstLocation = annotationArray.first?.coordinate {
            createDirectionRequest(startCoordinate: myCoordinate, destinationCoordinate: firstLocation, transportType: typeTransport)
        }
        
        for index in 0..<annotationArray.count - 1 {
            
            createDirectionRequest(startCoordinate: annotationArray[index].coordinate,destinationCoordinate: annotationArray[index + 1].coordinate, transportType: typeTransport)
        }
        
        mapView.showAnnotations(annotationArray, animated: true)
        
        print("Add way")
    }
    
    @objc func addResetButtonTapped() {
        
        annotationArray = [MKPointAnnotation]()
        
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        backView.counterKm.text = nil
        backView.counterDistance.text = nil
        
        addWayButton.isHidden = true
        addResetButton.isHidden = true
        backLabel.isHidden = false
        labell.isHidden = false
        addMyLocationButton.isHidden = false
        settingsButton.isHidden = false
        typeMapButton.isHidden = false
        weatherButton.isHidden = false
        searchController.searchBar.isHidden = false
        backView.isHidden = true
        
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
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Other Functions
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            manager.startUpdatingLocation()
            
            render(location)
            
        }
    }
    
    private func configureButtonMenu() {
        typeMapButton.menu = demoMenu
        typeMapButton.showsMenuAsPrimaryAction = true
    }
    
    func roadType() {
        backView.selectTypeRoad.menu = menuType
        backView.selectTypeRoad.showsMenuAsPrimaryAction = true
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
                
                self.alertError(title: "Ошибка", message: "Service is unavailable")
                
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
        
        if annotationArray.count > 0 {
            
            backView.isHidden = false
            settingsButton.isHidden = true
            addMyLocationButton.isHidden = true
            typeMapButton.isHidden = true
            weatherButton.isHidden = true
            labell.isHidden = true
            backView.isHidden = false
        }
        
        mapView.showAnnotations(annotationArray, animated: true)
    }
    
    //    Функция конвертирования RoadTrip из секунд в минуты и часы
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    func metersToKillometers(_ meters: Int) -> Int {
        return (meters / 1000)
    }
    
    public func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D, transportType: MKDirectionsTransportType?) {
        
        mapView.removeOverlays(mapView.overlays)
        
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = typeTransport ?? .automobile
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
                
                
                let kmFormatter =
                self.metersToKillometers(Int(route.distance))
                
                let components = self.secondsToHoursMinutesSeconds(Int(route.expectedTravelTime))
                self.backView.counterDistance.text = "\(components.0) часов \(components.1) минут"
                
                self.backView.counterKm.text = "\(kmFormatter) км"
                
            }
            
            self.mapView.addOverlay(minRoutes.polyline)
            
            print(minRoutes.expectedTravelTime)
            
        }
    }
}

// MARK: - Other Extensions

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .init(red: 50 / 255, green: 205 / 255, blue: 50 / 255, alpha: 1)
        backLabel.isHidden = true
        searchController.searchBar.isHidden = true
        addWayButton.isHidden = true
        weatherButton.isHidden = true
        
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

extension ViewController: Weather {
    func weatherTap() {
        
        labell.text = "norm pogodka"
    }
    
}

extension ViewController: TripSet {
    func set() {
        print("1231231")
    }
    
    
}

extension ViewController: ViewButtons {
    func typeRoad() {
        
        typeMapButtonTapped()
        
    }
    
    func reset() {
        
        addResetButtonTapped()
        
        print("23213123")
    }
    
    func goBut() {
        
        addWayButtonTapped()
        
        
    }
    
}

extension ViewController: ZoomButtonsDelegate {
    func zoomInTapped() {
        let region = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta * 0.7, longitudeDelta: mapView.region.span.longitudeDelta * 0.7))
        
        mapView.setRegion(region, animated: true)
    }
    
    func zoomOutTapped() {
        let zoom = getZoom()
        if zoom > 3.5 {  //Не ставить больше (выходит ошибка)
            
            let region = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta / 0.7, longitudeDelta: mapView.region.span.longitudeDelta / 0.7))
            mapView.setRegion(region, animated: true)
            
        }
    }
    
    
}

// MARK: - Add Constraint

extension ViewController {
    
    private func setConstraints() {
        
        view.addSubviews(mapView, labell, backLabel, addResetButton, settingsButton, addMyLocationButton, typeMapButton, zoomView, weatherButton, backView, trip)
        
        zoomView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        weatherButton.translatesAutoresizingMaskIntoConstraints = false
        addMyLocationButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        addWayButton.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        addResetButton.translatesAutoresizingMaskIntoConstraints = false
        typeMapButton.translatesAutoresizingMaskIntoConstraints = false
        trip.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 55),
            
            
            weatherButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 150),
            weatherButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -350),
            
            trip.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 750),
            trip.heightAnchor.constraint(equalToConstant: 35),
            trip.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            
            backView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 750),
            backView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 200),
            backView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -60),
            backView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 0),
            backView.widthAnchor.constraint(equalTo: mapView.widthAnchor, constant: 200),
            backView.heightAnchor.constraint(equalTo: mapView.heightAnchor, constant: 200),
            
            
            typeMapButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 805),
            typeMapButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -275),
            typeMapButton.heightAnchor.constraint(equalToConstant: 50),
            typeMapButton.widthAnchor.constraint(equalToConstant: 50),
            
            addResetButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 740),
            addResetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -30),
            addResetButton.heightAnchor.constraint(equalToConstant: 50),
            addResetButton.widthAnchor.constraint(equalToConstant: 50),
            
            
            settingsButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 805),
            settingsButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -335),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            
            
            addMyLocationButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 805),
            addMyLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -30),
            addMyLocationButton.heightAnchor.constraint(equalToConstant: 50),
            addMyLocationButton.widthAnchor.constraint(equalToConstant: 50),
            
            
            zoomView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 400),
            zoomView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10)])
        
    }
}
