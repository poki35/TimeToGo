//
//  ZoomButtonsViewController.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 12.07.2022.
//

import UIKit
import MapKit

//class ZoomButtonsViewController: ViewController {
//
//    lazy var zoomInButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "plus"), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    lazy var zoomOutButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "minus"), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        zoomInButton.addTarget(self, action: #selector(zoomInButtonTapped), for: .touchUpInside)
//        zoomOutButton.addTarget(self, action: #selector(zoomOutButtonTapped), for: .touchUpInside)
//
//        setConstraints()
//        view.addSubview(mapView)
//
//    }
//
//    @objc func zoomInButtonTapped() {
//        let region = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta * 0.7, longitudeDelta: mapView.region.span.longitudeDelta * 0.7))
//
//        mapView.setRegion(region, animated: true)
//
//        print("zoom in")
//    }
//
//    @objc func zoomOutButtonTapped() {
//        let zoom = getZoom()
//        if zoom > 3.5 {  //Не ставить больше (выходит ошибка)
//
//            let region = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta / 0.7, longitudeDelta: mapView.region.span.longitudeDelta / 0.7))
//            mapView.setRegion(region, animated: true)
//        }
//
//        print("zoom out")
//    }
//
//    func getZoom() -> Double {
//
//        var angleCamera = self.mapView.camera.heading
//        if  angleCamera > 270 {
//            angleCamera = 560 - angleCamera
//        }
//
//        else if angleCamera > 90 {
//            angleCamera = fabs(angleCamera - 180)
//        }
//
//        let angleRad = Double.pi * angleCamera / 180
//        let width = Double(self.view.frame.size.width)
//        let height = Double(self.view.frame.size.height)
//        let heightOffset : Double = 20
//        let spanStraight = width * self.mapView.region.span.longitudeDelta / (width * cos(angleRad) + (height - heightOffset) * sin(angleRad))
//
//        return log2(360 * ((width / 256) / spanStraight)) + 1;
//    }
//
//}
//
//extension ZoomButtonsViewController {
//
//    private func setConstraints() {
//        
//        view.addSubviews(zoomInButton, zoomOutButton)
//
//        NSLayoutConstraint.activate([
//            zoomInButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 400),
//            zoomInButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
//            zoomInButton.heightAnchor.constraint(equalToConstant: 55),
//            zoomInButton.widthAnchor.constraint(equalToConstant: 55),
//
//
//            zoomOutButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 470),
//            zoomOutButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
//            zoomOutButton.heightAnchor.constraint(equalToConstant: 55),
//            zoomOutButton.widthAnchor.constraint(equalToConstant: 55)])
//    }
//
//}
